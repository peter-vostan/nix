{ pkgs, lib, system, ... }: {
  imports = [
    ../default.nix

    ./desktop.nix
    # ./nomad.nix
    ./mdns.nix
    ./printer.nix
    ./tailscale.nix
    ./users.nix
    ./virtualisation.nix
  ];

  nix.autoOptimiseStore = true;

  # `nixos` version.
  system.stateVersion = "21.11";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Australia/Perth";

  environment.systemPackages = with pkgs; [ chromium ];

  # Being replaced by `nix-index` soon™.
  # See: https://github.com/NixOS/nixpkgs/issues/39789.
  programs.command-not-found.enable = false;
}
