{ pkgs, ... }: {
  imports = [
    ../default.nix
  ];

  # macOS (`nix-darwin`) verison.
  system.stateVersion = 4;
  # Allow proprietary packages.
  nixpkgs.config.allowUnfree = true;
  # Enable the Nix build daemon.
  services.nix-daemon.enable = true;
  # Add additional allowed shells. Set using `chsh -s /run/current-system/sw/bin/fish`.
  environment.shells = [ pkgs.fish ];
}
