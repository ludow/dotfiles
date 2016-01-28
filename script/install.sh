#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# find the installers and run them iteratively
for scripts in $(find . -name "install.sh" | grep -v "script/install.sh")
do
  sh -c "${scripts}"
done

sh $DOTFILES_ROOT/script/dotfiles.sh

echo ''
echo '✅ All installed!'
