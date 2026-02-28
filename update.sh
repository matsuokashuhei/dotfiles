#!/bin/bash -eu

DOTFILES_HOME=$HOME/.dotfiles

# Statusline (usedhonda/statusline)
STATUSLINE_REPO=$DOTFILES_HOME/repos/statusline
STATUSLINE_DEST=$HOME/.claude/statusline.py

if [ ! -d $STATUSLINE_REPO ]; then
  echo "Error: $STATUSLINE_REPO does not exist. Run install.sh first."
  exit 1
fi

echo "Updating statusline..."
(cd $STATUSLINE_REPO && git pull)
cp $STATUSLINE_REPO/statusline.py $STATUSLINE_DEST
echo "statusline.py updated successfully."

# Everything Claude Code (affaan-m/everything-claude-code)
ECC_REPO=$DOTFILES_HOME/repos/everything-claude-code
ECC_RULES_DEST=$DOTFILES_HOME/claude/rules

if [ ! -d $ECC_REPO ]; then
  echo "Error: $ECC_REPO does not exist. Run install.sh first."
  exit 1
fi

echo "Updating everything-claude-code..."
(cd $ECC_REPO && git pull)
cp $ECC_REPO/rules/common/*.md $ECC_RULES_DEST/
echo "everything-claude-code rules updated successfully."

# Claude Plugins Official (anthropics/claude-plugins-official)
CPO_REPO=$DOTFILES_HOME/repos/claude-plugins-official
CPO_PLUGINS=$CPO_REPO/plugins

if [ ! -d $CPO_REPO ]; then
  echo "Error: $CPO_REPO does not exist. Run install.sh first."
  exit 1
fi

echo "Updating claude-plugins-official..."
(cd $CPO_REPO && git pull)

# Superpowers (obra/superpowers)
SP_REPO=$DOTFILES_HOME/repos/superpowers

if [ ! -d $SP_REPO ]; then
  echo "Error: $SP_REPO does not exist. Run install.sh first."
  exit 1
fi

echo "Updating superpowers..."
(cd $SP_REPO && git pull)

# Force-recopy all CPO + superpowers assets (overwrite existing)
AGENTS_DEST=$DOTFILES_HOME/claude/agents
COMMANDS_DEST=$DOTFILES_HOME/claude/commands
SKILLS_DEST=$DOTFILES_HOME/claude/skills
HOOKS_DEST=$DOTFILES_HOME/claude/hooks

# CPO agents (prefixed)
cp $CPO_PLUGINS/code-simplifier/agents/code-simplifier.md $AGENTS_DEST/code-simplifier--code-simplifier.md
cp $CPO_PLUGINS/pr-review-toolkit/agents/code-reviewer.md $AGENTS_DEST/pr-review-toolkit--code-reviewer.md
cp $CPO_PLUGINS/pr-review-toolkit/agents/code-simplifier.md $AGENTS_DEST/pr-review-toolkit--code-simplifier.md
cp $CPO_PLUGINS/pr-review-toolkit/agents/comment-analyzer.md $AGENTS_DEST/pr-review-toolkit--comment-analyzer.md
cp $CPO_PLUGINS/pr-review-toolkit/agents/pr-test-analyzer.md $AGENTS_DEST/pr-review-toolkit--pr-test-analyzer.md
cp $CPO_PLUGINS/pr-review-toolkit/agents/silent-failure-hunter.md $AGENTS_DEST/pr-review-toolkit--silent-failure-hunter.md
cp $CPO_PLUGINS/pr-review-toolkit/agents/type-design-analyzer.md $AGENTS_DEST/pr-review-toolkit--type-design-analyzer.md
cp $CPO_PLUGINS/feature-dev/agents/code-architect.md $AGENTS_DEST/feature-dev--code-architect.md
cp $CPO_PLUGINS/feature-dev/agents/code-explorer.md $AGENTS_DEST/feature-dev--code-explorer.md
cp $CPO_PLUGINS/feature-dev/agents/code-reviewer.md $AGENTS_DEST/feature-dev--code-reviewer.md

# Superpowers agent (prefixed)
cp $SP_REPO/agents/code-reviewer.md $AGENTS_DEST/superpowers--code-reviewer.md

# CPO commands
cp $CPO_PLUGINS/commit-commands/commands/clean_gone.md $COMMANDS_DEST/
cp $CPO_PLUGINS/commit-commands/commands/commit-push-pr.md $COMMANDS_DEST/
cp $CPO_PLUGINS/commit-commands/commands/commit.md $COMMANDS_DEST/
cp $CPO_PLUGINS/code-review/commands/code-review.md $COMMANDS_DEST/
cp $CPO_PLUGINS/pr-review-toolkit/commands/review-pr.md $COMMANDS_DEST/
cp $CPO_PLUGINS/claude-md-management/commands/revise-claude-md.md $COMMANDS_DEST/
cp $CPO_PLUGINS/feature-dev/commands/feature-dev.md $COMMANDS_DEST/

# Superpowers commands
cp $SP_REPO/commands/brainstorm.md $COMMANDS_DEST/
cp $SP_REPO/commands/execute-plan.md $COMMANDS_DEST/
cp $SP_REPO/commands/write-plan.md $COMMANDS_DEST/

# CPO skills (remove existing, then copy fresh)
rm -rf $SKILLS_DEST/claude-automation-recommender
cp -r $CPO_PLUGINS/claude-code-setup/skills/claude-automation-recommender $SKILLS_DEST/

rm -rf $SKILLS_DEST/claude-md-improver
cp -r $CPO_PLUGINS/claude-md-management/skills/claude-md-improver $SKILLS_DEST/

# Superpowers skills (remove existing, then copy fresh)
for skill_dir in $SP_REPO/skills/*/
do
  dirname=$(basename $skill_dir)
  rm -rf $SKILLS_DEST/$dirname
  cp -r $skill_dir $SKILLS_DEST/$dirname
done

# Hooks
cp $CPO_PLUGINS/security-guidance/hooks/security_reminder_hook.py $HOOKS_DEST/

echo "claude-plugins-official and superpowers updated successfully."
