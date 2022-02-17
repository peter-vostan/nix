# nix

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repo contains the nixOS and macOS machine configurations.
The initial inspired / copied from

[opeik/nix](https://github.com/opeik/nix).

[DylanRJohnston/nixos](https://github.com/DylanRJohnston/nixos)

[davegallant/nixos-config](https://github.com/davegallant/nix-config).

## macOS

### Install

Install Nix unstable
```sh
curl -s https://api.github.com/repos/numtide/nix-unstable-installer/releases/latest |
   grep 'browser_download_url' |
   grep '/install' |
   cut -d '"' -f 4 |
   xargs curl --silent --location |
   sh -s -- --daemon --darwin-use-unencrypted-nix-store-volume
```

Install nix-darwin
```sh
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer && \
./result/bin/darwin-installer
```

Bootstrap build
```sh
nix build ".#darwinConfigurations.work-mac.system" --extra-experimental-features nix-command --extra-experimental-features flakes
./result/sw/bin/darwin-rebuild switch --flake .#work-mac

# The followig might need to be run to resolve errors with these existing files
sudo rm /etc/nix/nix.conf
sudo rm /etc/shells
```

Set default shell
```sh
chsh -s /run/current-system/sw/bin/fish
```

## nixOS

### Full Disk Encryption

https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134

```sh
# Setup partitions
# Use GPT format
gdisk /dev/nvme0n1
  o
  n [ENTER] [ENTER] 500M ef00
  n [ENTER] [ENTER] [ENTER] 8300
  w

# Label first partition (boot drive) for reference in hardware.nix
fatlabel /dev/nvme0n1p1 boot

# Encrypt 2nd partition
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup luksOpen /dev/nvme0n1p2 enc-pv

pvcreate /dev/mapper/enc-pv
vgcreate vg /dev/mapper/enc-pv
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n root vg

mkfs.fat /dev/nvme0n1p1
mkfs.ext4 -L root /dev/vg/root
mkswap -L swap /dev/vg/swap
```

### Install

To enable flakes in NixOS (so that this config can be built), add the following to /etc/nix/configuration.nix
```sh
nix = {
  package = pkgs.nixUnstable;
  extraOptions = ''experimental-features = nix-command flakes'';
}
```

You might also need to copy accross the /etc/nix/hardware-configuration.nix if you don't already have this defined

```sh
nixos-install --flake https://github.com/peter-vostan/nix#work
reboot
```

Remove root user password once you're logged into gnome
```sh
passwd -d root
```

## Build / Switch

```sh
sudo nixos-rebuild switch --flake .#work-dell
# OR
darwin-rebuild switch --flake .#work-mac
```

## Update

To update nixpkgs defined in [flake.nix](./flake.nix), run

```sh
nix flake update
```

If there are updates, they should be reflected in [flake.lock](./flake.lock).

## Git

Git user.email is not set globally to force it to be set explicitly in each repo (to separate work and personal)

```sh
git config user.email "email@email.com"
```

## Templates

```sh
cp -r ~/dev/nix/templates/rust-dev/. .
```

## External Displays

```sh
# To see what displays are connected
xrandr 

# Example for the Fugro meeting rooms
xrandr --output DP-3 --mode 1920x1080 --rate 60

# Also look at autorandr
```

## Tailscale

```
sudo tailscale up --accept-routes
tailscale status
```