{ pkgs, ... }: {
  # macOS (`nix-darwin`) verison.
  system.stateVersion = 4;
  # Allow proprietary packages.
  nixpkgs.config.allowUnfree = true;
  # Enable the Nix build daemon.
  services.nix-daemon.enable = true;
  # Add additional allowed shells. Set using `chsh -s /run/current-system/sw/bin/fish`.
  environment.shells = [ pkgs.fish ];

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
}
