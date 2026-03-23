#!/usr/bin/env python3
"""Guard hooks for Bash tool — block dangerous command patterns.

Usage: python3 guard_bash.py <check-name>
  Reads Claude Code hook JSON from stdin and exits 2 to block, 0 to allow.

Checks:
  git-c                   Block 'git -C <path>' usage
  gh-repo-flag            Block 'gh -R' or 'gh --repo' flag usage
  gh-api-hardcoded-repo   Block hardcoded repo paths in 'gh api'
  gh-api-wrong-repo       Block 'gh api' targeting a repo other than the current one
"""

import json
import os
import re
import subprocess
import sys
from typing import Optional


def check_git_c(cmd: str) -> Optional[str]:
    if re.search(r"git\s+-C\s+\S", cmd):
        return (
            f"Current directory: {os.getcwd()}\n"
            "Do not use 'git -C'. You are already in the correct directory. "
            "Run git commands without -C."
        )
    return None


def check_gh_repo_flag(cmd: str) -> Optional[str]:
    if re.search(r"gh\s+.*(-R\s+|--repo[\s=])", cmd):
        return (
            "Do not use gh with -R or --repo flag. "
            "Run gh commands in the current repository context "
            "without specifying a different repo."
        )
    return None


def check_python_json_parse(cmd: str) -> Optional[str]:
    if re.search(r"python3?\s+.*-c\s+['\"].*import\s+json", cmd) or re.search(
        r"python3?\s+-c\s+['\"].*import\s+json", cmd
    ):
        return (
            "Do not use Python to parse JSON. Use jq instead.\n"
            "Examples:\n"
            "  jq '.key' file.json\n"
            "  cat file.json | jq '.key'\n"
            "  jq -r '.array[]' file.json"
        )
    return None


def check_gh_api_hardcoded_repo(cmd: str) -> Optional[str]:
    has_hardcoded = re.search(
        r"(?:^|\s)(?:gh\s+api|.*&&\s*gh\s+api|.*\|\|\s*gh\s+api)"
        r"\s+.*/repos/[a-zA-Z0-9_.-]+/",
        cmd,
    )
    has_dynamic = re.search(r"/repos/\$\(", cmd)
    if has_hardcoded and not has_dynamic:
        return (
            "Do not hardcode a repository path in gh api. "
            "Use the current repo dynamically: "
            "gh api /repos/$(gh repo view --json nameWithOwner -q .nameWithOwner)/..."
        )
    return None


def check_gh_api_wrong_repo(cmd: str) -> Optional[str]:
    # Only inspect commands that contain 'gh api'
    if not re.search(r"gh\s+api", cmd):
        return None
    # Find /repos/{owner}/{repo} path segment
    match = re.search(r"/repos/([a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+)", cmd)
    if not match:
        # No specific repo path (e.g., /user, /search, /rate_limit) — allow
        return None
    # Dynamic substitution like /repos/$(...) — allow (checked by gh-api-hardcoded-repo)
    if re.search(r"/repos/\$\(", cmd):
        return None
    target_repo = match.group(1)
    result = subprocess.run(
        ["gh", "repo", "view", "--json", "nameWithOwner", "-q", ".nameWithOwner"],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        # Can't determine current repo — allow rather than false-block
        return None
    current_repo = result.stdout.strip()
    if target_repo.lower() != current_repo.lower():
        return (
            f"Blocked: gh api targets '{target_repo}' but the current repo is '{current_repo}'. "
            "Use the current repo dynamically: "
            "gh api /repos/$(gh repo view --json nameWithOwner -q .nameWithOwner)/..."
        )
    return None


CHECKS = {
    "git-c": check_git_c,
    "gh-repo-flag": check_gh_repo_flag,
    "gh-api-hardcoded-repo": check_gh_api_hardcoded_repo,
    "gh-api-wrong-repo": check_gh_api_wrong_repo,
    "python-json-parse": check_python_json_parse,
}


def main() -> None:
    if len(sys.argv) < 2 or sys.argv[1] not in CHECKS:
        print(f"Usage: {sys.argv[0]} <{'|'.join(CHECKS)}>", file=sys.stderr)
        sys.exit(1)

    data = json.load(sys.stdin)
    cmd = data.get("tool_input", {}).get("command", "")

    error = CHECKS[sys.argv[1]](cmd)
    if error:
        print(error)
        sys.exit(2)


if __name__ == "__main__":
    main()
