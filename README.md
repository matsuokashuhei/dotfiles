# Getting started

1. Install Homebrew

    See https://brew.sh

2. Install mise

    ```
    brew install mise
    ```

3. Make a dotfiles

    ```
    https://github.com/matsuokashuhei/dotfiles.git $HOME/.dotfiles
    ```

4. Setup with mise

    ```
    cd $HOME/.dotfiles
    mise bootstrap
    ```

# Tips

## Reorder Devin permissions

```bash
jq '.permissions.allow |= sort' ~/.dotfiles/devin/config.json > /tmp/config.json \
  && mv /tmp/config.json ~/.dotfiles/devin/config.json
```