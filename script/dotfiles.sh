#!/usr/bin/env bash
#
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''
echo '[Dotfiles]'

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    local currentSrc="$(readlink $dst)"

    if [ "$currentSrc" == "$src" ]
    then

      skip=true;

    else

      echo "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
      [s]kip, [o]verwrite, [b]ackup ?"
      read -n 1 action

      case "$action" in
        o )
          overwrite=true;;
        b )
          backup=true;;
        s )
          skip=true;;
        * )
          ;;
      esac

    fi

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      echo "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      echo "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      echo "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    echo "linked $1 to $2"
  fi
}

for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
do
  dst="$HOME/.$(basename "${src%.*}")"
  link_file "$src" "$dst"
done
