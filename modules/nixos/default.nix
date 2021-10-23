{ pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./mime.nix
    ./print.nix
    ./user.nix
    ./user.nix
  ];

  # `nixos` version.
  system.stateVersion = "21.11";
  # Automatically optimize the Nix store.
  nix.autoOptimiseStore = true;
  # UTF-8 everywhere!
  i18n.defaultLocale = "en_US.UTF-8";
  # Set time zone.
  time.timeZone = "Australia/Perth";
}
