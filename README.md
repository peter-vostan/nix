# nix

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repo contains the nixOS machine configurations.
The initial inspired / copied from

[opeik/nix](https://github.com/opeik/nix).

[davegallant/nixos-config](https://github.com/davegallant/nix-config).

## nixOS

### Full Disk Encryption

Add details
 - include boot label

### Install

root user remove password



### Build / Switch

   ```sh
   sudo nixos-rebuild switch --flake .#work
   ```

## Update

To update nixpkgs defined in [flake.nix](./flake.nix), run

```sh
nix flake update
```

If there are updates, they should be reflected in [flake.lock](./flake.lock).
