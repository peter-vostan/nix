{ pkgs, lib, system, ... }: {
  imports = [
    ./cachix.nix
  ];

  nix = {
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
}
