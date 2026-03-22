#!/usr/bin/env python3
"""Guard hooks for Bash tool — block dangerous command patterns.

Usage: python3 guard_bash.py <check-name>
  Reads Claude Code hook JSON from stdin and exits 2 to block, 0 to allow.

Checks:
  git-c                   Block 'git -C <path>' usage
  gh-repo-flag            Block 'gh -R' or 'gh --repo' flag usage
  gh-api-hardcoded-repo   Block hardcoded repo paths in 'gh api'
  cd-worktree             Block 'cd <worktree> && <command>' chaining
"""

import json
import os
import re
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


def check_cd_worktree(cmd: str) -> Optional[str]:
    if re.search(r"cd\s+\S+\s*&&\s*git\s", cmd):
        return (
            "Do not chain 'cd <path> && git <command>'. "
            "The working directory persists between Bash calls. "
            "Run 'cd <path>' alone first, then run git commands separately."
        )
    return None


CHECKS = {
    "git-c": check_git_c,
    "gh-repo-flag": check_gh_repo_flag,
    "gh-api-hardcoded-repo": check_gh_api_hardcoded_repo,
    "cd-worktree": check_cd_worktree,
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
