#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq unzip
url='https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/misc/vscode-extensions/update_installed_exts.sh'
curl -s "${url}" | bash
