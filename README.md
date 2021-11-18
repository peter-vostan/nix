# nix

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repo contains the nixOS machine configurations.
The initial inspired / copied from

[opeik/nix](https://github.com/opeik/nix).

[DylanRJohnston/nixos](https://github.com/DylanRJohnston/nixos)

[davegallant/nixos-config](https://github.com/davegallant/nix-config).

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

```sh
nixos-install --flake https://github.com/peter-vostan/nix#work

reboot
```

Remove root user password once you in gnome
```sh
passwd -d root
```

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

## Debugging

Search what others have done in;

https://github.com/NixOS/nixpkgs

https://search.nixos.org/packages

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
