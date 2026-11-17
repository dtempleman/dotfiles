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

### Per-machine defaults (git identity and GitHub key)

Each machine picks its default git identity and GitHub SSH key in two local files, `.gitconfig.local` and `.ssh/config.local`. They live in this repo but are gitignored, and are symlinked into `~` like the rest of the dotfiles. Create them from the `.example` files with:

```shell
./init.sh kinsol      # work machine
./init.sh personal    # personal machine
```

Existing local files are kept; use `./init.sh -f <profile>` to regenerate them. `init.sh` creates the symlinks itself, so it can run before or after `stow .`.

Folder rules override the machine default on every machine:

| Repo location | Identity | GitHub SSH key |
| --- | --- | --- |
| `~/kinsol/**` | kinsol | `github.com-kinsol` |
| `~/kemple/**` | personal | `github.com-personal` |
| anywhere else | from `~/.gitconfig.local` | from `~/.ssh/config.local` |

Check a repo with `git config user.email` and `git ls-remote --get-url origin`.

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