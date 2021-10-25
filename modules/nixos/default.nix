{ pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./mdns.nix
    ./mime.nix
    ./print.nix
  ];

  # `nixos` version.
  system.stateVersion = "21.05";
  # Automatically optimize the Nix store.
  nix.autoOptimiseStore = true;
  # UTF-8 everywhere!
  i18n.defaultLocale = "en_US.UTF-8";
  # Set time zone.
  time.timeZone = "Australia/Perth";
}
