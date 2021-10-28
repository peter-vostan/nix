{ pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./docker.nix
    ./mdns.nix
    ./mime.nix
    ./print.nix
  ];

  # `nixos` version.
  system.stateVersion = "21.05";
  nix = {
    # Automatically optimize the Nix store.
    autoOptimiseStore = true;
    gc.dates = "weekly";
  };

  # UTF-8 everywhere!
  i18n.defaultLocale = "en_US.UTF-8";
  # Set time zone.
  time.timeZone = "Australia/Perth";
  # Being replaced by `nix-index` soon™.
  # See: https://github.com/NixOS/nixpkgs/issues/39789.
  programs.command-not-found.enable = false;
}
