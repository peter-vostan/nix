{ pkgs, lib, system, ... }: {
  imports = [
    ./cachix.nix
    ./desktop.nix
    # ./nomad.nix
    ./mdns.nix
    ./printer.nix
    ./tailscale.nix
    ./users.nix
    ./virtualisation.nix
  ];

  # `nixos` version.
  system.stateVersion = "21.11";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Australia/Perth";

  # Being replaced by `nix-index` soon™.
  # See: https://github.com/NixOS/nixpkgs/issues/39789.
  programs.command-not-found.enable = false;

  nix = {
    package = pkgs.nix_2_4; # Needed for flake support
    autoOptimiseStore = true;
    extraOptions = ''
      experimental-features = nix-command flakes
      # Uses more disk space but speeds up nix-direnv.
      keep-derivations = true
      keep-outputs = true
    '';
  };

  # Allow proprietary packages.
  nixpkgs.config.allowUnfree = true;
  # System-wide packages.
  environment.systemPackages = with pkgs; [ ];

  # Integrate with shells.
  programs = {
    fish.enable = true;
  };
}
