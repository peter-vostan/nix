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
sh <(curl -L https://nixos.org/nix/install)
```

Install nix-darwin
```sh
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer && \
./result/bin/darwin-installer
```

Bootstrap build
```sh
nix build ".#darwinConfigurations.work-mac.system" --extra-experimental-features 'nix-command flakes'
./result/sw/bin/darwin-rebuild switch --flake .#work-mac

# The followig might need to be run to resolve errors with these existing files
sudo rm /etc/nix/nix.conf
sudo rm /etc/shells
```

Install XCode
```sh
xcode-select --install
```

## nixOS

### Full Disk Encryption

https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134

```sh
# switch to root
sudo -i

# Setup partitions
gdisk /dev/nvme0n1
  o
  n [ENTER] [ENTER] 500M ef00
  n [ENTER] [ENTER] [ENTER] 8300
  w

# Label first partition (boot) for reference in hardware.nix
fatlabel /dev/nvme0n1p1 boot

# Encrypt 2nd partition (root)
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup luksOpen /dev/nvme0n1p2 enc-pv

# Create root and swap volumes
pvcreate /dev/mapper/enc-pv
vgcreate vg /dev/mapper/enc-pv
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n root vg

# Make boot and root filesystems
mkfs.fat /dev/nvme0n1p1
mkfs.ext4 -L root /dev/vg/root

# Make swap area
mkswap -L swap /dev/vg/swap

# Mount the root and boot partitions
mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

# Activate swap area
swapon /dev/vg/swap
```

### Install

Install nixos with simple working config (this makes it easier to deal with any issues with the custom config as you always have a working config to roll back to)
```sh
nixos-generate-config --root /mnt

# Add the following to /mnt/etc/nixos/configuration.nix to enable flakes
nix = {
  package = pkgs.nix_2_4;
  extraOptions = ''experimental-features = nix-command flakes'';
};

# Add the following to /mnt/etc/nixos/hardware-configuration.nix to configure the encrypted root drive
boot.initrd.luks.devices = {
  root = {
    device = "/dev/nvme0n1p2";
    preLVM = true;
    allowDiscards = true;
  };
};

# Install nixos config and then reboot into it
nixos-install
reboot
```

Install custom config
 - Compare /etc/nixos/configuration.nix and /etc/nixos/harware-configuration.nix with the specified /host config files, paying particular attention to the boot and networking sections
```sh
nixos-rebuild switch --flake https://github.com/peter-vostan/nix#work
reboot
```

User setup
```sh
# Login as root

# Set password for the user account
passwd $USERNAME

# Logout and login as the user

# Remove root user password
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

## Nix Repl

```sh
# Explore nixpkgs
nix repl '<nixpkgs>'

# repl supports tab-tab autocompletion for all derivations eg.
nix-repl> python3Packages.future.meta.longDescription
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
