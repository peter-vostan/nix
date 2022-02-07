{ pkgs, lib, system, ... }: {
  imports = [
    ./cachix.nix
    ./users.nix
  ];

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
