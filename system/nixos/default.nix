{ pkgs, lib, system, ... }: {
  imports = [
    ./desktop.nix
    # ./nomad.nix
    ./mdns.nix
    ./printer.nix
    ./tailscale.nix
    ./virtualisation.nix
  ];

  # `nixos` version.
  system.stateVersion = "21.11";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Australia/Perth";

  nix = {
    autoOptimiseStore = true;
    package = pkgs.nix_2_4; # Needed for flake support
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
  environment.systemPackages = with pkgs; [ chromium ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Integrate with shells.
  programs = {
    zsh.enable = true;
    fish.enable = true;

    # Being replaced by `nix-index` soon™.
    # See: https://github.com/NixOS/nixpkgs/issues/39789.
    command-not-found.enable = false;
  };

  cachix = [
    { name = "nix-community"; sha256 = "00lpx4znr4dd0cc4w4q8fl97bdp7q19z1d3p50hcfxy26jz5g21g"; }
  ];
}
