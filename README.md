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

#### install stow
```shell
sudo apt update && sudo apt install stow
```

#### run stow
```shell
mkdir -p -m 700 ~/.ssh
stow --no-folding -t ~ .
```

- `-t ~` links into your home directory. Without it, stow links into the repo's parent directory, which is only `~` if you cloned into `~`.
- `--no-folding` links individual files, never whole directories. Without it, stow makes a directory that doesn't exist yet (such as `~/.ssh` or `~/.config/tmux`) a single symlink into this repo, and anything written there later (SSH keys, app state) ends up inside the repo.
- Real files already in the way (such as a fresh machine's `~/.bashrc`) make stow refuse. Move them aside first, e.g. `mv ~/.bashrc ~/.bashrc.bak`.

### Per-machine defaults (git identity and GitHub key)

Each machine picks its default git identity and GitHub SSH key in two local files, `.gitconfig.local` and `.ssh/config.local`. They live in this repo but are gitignored, and are symlinked into `~` like the rest of the dotfiles. Create them from the `.example` files with:

```shell
./init.sh kinsol      # work machine
./init.sh personal    # personal machine
```

Existing local files are kept; use `./init.sh -f <profile>` to regenerate them. `init.sh` creates the symlinks itself, so it can run before or after stow.

Folder rules override the machine default on every machine:

| Repo location | Identity | GitHub SSH key |
| --- | --- | --- |
| `~/kinsol/**` | kinsol | `github.com-kinsol` |
| `~/kemple/**` | personal | `github.com-personal` |
| anywhere else | from `~/.gitconfig.local` | from `~/.ssh/config.local` |

Check a repo with `git config user.email` and `git ls-remote --get-url origin`.

## Configurations and Dependencies

- bash (login shell)
  - eza
  - oh-my-posh
  - zoxide
- git
- ssh
- tmux
- tilix
- VS Code
  - settings: `.config/Code/User/settings.json`
  - extensions: `vscode-extensions.txt` (not linked; denv's bootstrap installs them)