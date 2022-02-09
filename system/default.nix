{ pkgs, system, ... }: {
  nix = {
    package = pkgs.nixUnstable; # Needed for flake support
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Integrate with shells.
  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  cachix = [
    { name = "nix-community"; sha256 = "00lpx4znr4dd0cc4w4q8fl97bdp7q19z1d3p50hcfxy26jz5g21g"; }
  ];
}
