#!/bin/sh
set -euo pipefail

# Print a command prior to execution.
run() {
    CMD="${@}"
    printf "> $(green running:) \`${CMD}\`\n"
    ${@}
}

# What if it was ~~purple~~ green.
green() {
    # Terminal style control codes.
    GREEN='\033[1;32m'
    CLEAR='\033[0m'
    printf "${GREEN}${1}${CLEAR}"
}

main() {
    case "$OSTYPE" in
    "darwin"*)
        run sudo darwin-rebuild switch --flake ".#${host}"
        ;;
    "linux-gnu"*)
        run sudo nixos-rebuild switch --flake ".#${host}"
        ;;
    *)
        printf "unsupported os"
        exit 1
        ;;
    esac
    printf "> switch ok 🎉 \n"
}

host="${1-$(hostname)}"
main
