#!/usr/bin/env bash
# Create the per-machine local config files in this repo (gitignored) from the
# checked-in examples, and symlink them into $HOME the same way stow does.
#
#   ./init.sh kinsol      # work machine: kinsol identity + kinsol github key by default
#   ./init.sh personal    # personal machine: personal identity + personal github key by default
#   ./init.sh -f <profile>  regenerate the local files even if they already exist
#
# Folder rules (~/kinsol, ~/kemple) apply regardless of the profile chosen here.
set -euo pipefail

usage() { sed -n '2,9s/^# \{0,1\}//p' "$0"; exit 1; }

force=0
if [[ "${1:-}" == "-f" || "${1:-}" == "--force" ]]; then force=1; shift; fi

case "${1:-}" in
    kinsol)   keep="work machine";  drop="personal machine" ;;
    personal) keep="personal machine";  drop="work machine" ;;
    *) usage ;;
esac

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install_local <path> <mode>
#   <path> is relative to both the repo and $HOME, e.g. .ssh/config.local
#   1. write $repo/<path> from $repo/<path>.example (chosen option uncommented)
#   2. symlink $HOME/<path> -> $repo/<path> (relative, like stow)
install_local() {
    local rel="$1" mode="$2"
    local src="$repo/$rel.example" file="$repo/$rel" link="$HOME/$rel"

    # an older install left a real file in $HOME: adopt it into the repo if the
    # repo has none yet, otherwise keep it as a backup
    if [[ -f "$link" && ! -L "$link" ]]; then
        if [[ ! -e "$file" ]]; then
            mv "$link" "$file"
            echo "adopted  $link -> $file"
        else
            mv "$link" "$link.bak"
            echo "backup   $link -> $link.bak"
        fi
    fi

    if [[ -e "$file" && $force -eq 0 ]]; then
        echo "keep     $file (exists, use -f to regenerate)"
    else
        sed -e "/$keep/s/^#//" \
            -e "/$drop/s/^\([^#]\)/#\1/" \
            "$src" > "$file"
        echo "wrote    $file"
    fi
    chmod "$mode" "$file"

    # relative link target, as stow would make it (falls back to absolute
    # if the repo is not inside $HOME)
    local target="$file"
    if [[ "$repo" == "$HOME"/* ]]; then
        local up="" dir="${rel%/*}"
        [[ "$dir" != "$rel" ]] && up="$(sed 's#[^/]*#..#g' <<< "$dir")/"
        target="$up${repo#"$HOME"/}/$rel"
    fi
    mkdir -p "$(dirname "$link")"
    ln -sfn "$target" "$link"
    echo "linked   $link -> $target"
}

install_local .gitconfig.local   644
install_local .ssh/config.local  600
chmod 700 "$HOME/.ssh"

echo
echo "default identity: $(git config --global --includes user.name) <$(git config --global --includes user.email)>"
echo "default github key: $(ssh -G github.com 2>/dev/null | awk '/^identityfile /{print $2; exit}')"
