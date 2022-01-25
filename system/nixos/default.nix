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
  system.stateVersion = "21.05";
  nix = { autoOptimiseStore = true; };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Australia/Perth";

  # Being replaced by `nix-index` soon™.
  # See: https://github.com/NixOS/nixpkgs/issues/39789.
  programs.command-not-found.enable = false;

  nix = {
    # Use flakes for **maximum hermeticism**.
    package = pkgs.nix;
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
