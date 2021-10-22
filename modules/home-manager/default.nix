{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./git.nix
    ./pkg.nix
    ./vscode.nix
    ./firefox.nix
    ./font.nix
    ./mime.nix
  ];

  # Enable `home-manager`.
  home.stateVersion = "21.11";
  programs = {
    home-manager.enable = true;
  };
}
