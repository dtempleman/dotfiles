# Daniel's configuration files

## Install

```shell
git clone git@github.com:dtempleman/dotfiles.git
```

```shell
cd dotfiles
```

### GNU stow

Configuration files are managed using [GNU stow](https://www.gnu.org/software/stow/).

ubuntu
```shell
sudo apt update && sudo apt install stow
```

macos
```shell
brew install stow
```

```shell
stow .
```

## Configurations and Dependencies

- bash
- zsh
  - eza
  - Powerlevel10k
  - zoxide
  - zsh-autosuggestions
  - zsh-syntax-highlighting
- git
- ssh
- aerospace
- ghostty
- oh-my-posh
- tilix