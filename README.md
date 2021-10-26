# nix

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repo contains the nix config which I use on my macOS and nixOS machines.
The initial structure was inspired by
[davegallant/nixos-config](https://github.com/davegallant/nix-config).

## Bootstrapping

### macOS

1. Install [Nix unstable](https://github.com/numtide/nix-unstable-installer)

   ```sh
   curl -s https://api.github.com/repos/numtide/nix-unstable-installer/releases/latest |
      grep 'browser_download_url' |
      grep '/install' |
      cut -d '"' -f 4 |
      xargs curl --silent --location |
      sh -s -- --daemon --darwin-use-unencrypted-nix-store-volume
   ```

2. Install [nix-darwin](https://github.com/LnL7/nix-darwin)

   ```sh
   nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer && \
   ./result/bin/darwin-installer
   ```

3. Bootstrap

   ```sh
   # For configuration `foobar`.
   config='foobar'
   nix build ".#darwinConfigurations.${config}.system"
   ./result/sw/bin/darwin-rebuild switch --flake ".#${config}"
   ```

### nixOS

1. Enable Flakes by adding the following to `/etc/nixos/configuration.nix`

   ```nix
   {
     package = pkgs.nixUnstable;
     extraOptions = "experimental-features = nix-command flakes";
   }
   ```

2. Bootstrap

   ```sh
   nixos-rebuild switch
   ```

## Switching

- Switch the current configuration

  ```sh
  ./switch.sh
  ```

- Switch to the configuration `foobar`

  ```sh
  ./switch.sh foobar
  ```

## Update

To update nixpkgs defined in [flake.nix](./flake.nix), run

```sh
nix flake update
```

If there are updates, they should be reflected in [flake.lock](./flake.lock).
