#!/bin/sh
set -euo pipefail

# Terminal style control codes.
GREEN='\033[1;32m'
CLEAR='\033[0m'

host="${1-$(hostname)}"

# Print a command prior to execution.
run() {
    CMD="${@}"
    printf "> $(green running:) \`${CMD}\`\n"
    ${@}
}

# What if it was ~~purple~~ green.
green() {
    printf "${GREEN}${1}${CLEAR}"
}

main() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        os='macOS'
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        os='NixOS'
    else
        printf "unsupported os"
        exit 1
    fi

    printf "> switching $(green ${os}) configuration for host $(green ${host})\n"

    if [[ ${os} == 'macOS' ]]; then
        run sudo darwin-rebuild switch --flake ".#${host}"
    elif [[ "${os}" == 'NixOS' ]]; then
        run sudo nixos-rebuild switch --flake ".#${host}"
    fi

    printf "> switch ok 🎉 \n"
}

main
