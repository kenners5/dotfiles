#!/bin/bash
set -euo pipefail

dotfiles_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dotfiles_to_install=".bashrc .zshrc .gitconfig .githelpers"

function check_and_install () {
    if test -h "${HOME}/${1}"; then
        # Warn if the bashrc symlink is pointing elsewhere
        if test ! "${HOME}/${1}" -ef "${1}"; then
            echo "${1} symlink found pointing to a different place, leaving alone..."
        fi
    # Warn if the bashrc is an actual file
    elif test -f "${HOME}/${1}"; then
        echo "Found a real ${1}, leaving alone..."
    # Install the symlink
    else
        ln -s "${dotfiles_path}/${1}" "${HOME}/${1}"
    fi
}

echo "Installing dotfiles..."

for dotfile in $dotfiles_to_install
do
    echo "=> ${dotfile}"
    check_and_install "${dotfile}"
done

echo "done."
