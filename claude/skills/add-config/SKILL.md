---
name: add-config
description: Add a new application configuration to the dotfiles repository
disable-model-invocation: true
---

## Usage

`/add-config <app-name>` — e.g., `/add-config zsh`

## Steps

1. **Create app directory** at repository root: `~/.dotfiles/<app-name>/`
2. **Place config files** inside the new directory
3. **Add symlink block to `install.sh`** following the existing pattern:

```bash
# <app-name>
SRC_DIR=$DOTFILES_HOME/<app-name>
DEST_DIR=<target-directory>

mkdir -p $DEST_DIR

for file in <file-names>
do
  if [ -f $DEST_DIR/$file ]; then
    echo "$DEST_DIR/$file already exists, aborting to avoid overwriting."
  else
    echo "installing $file to $DEST_DIR/"
    ln -s $SRC_DIR/$file $DEST_DIR/$file
  fi
done
```

4. **Update `CLAUDE.md`**:
   - Add entry to the repository structure tree
   - Add row to the symlinks table
5. **Validate**: Run `bash -n install.sh` to check syntax
6. **Optional**: If the config pulls from a remote source, add update logic to `update.sh`
