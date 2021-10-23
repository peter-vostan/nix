{ pkgs, lib, config, ... }: {
  imports = [
    ./fish.nix
    ./git.nix
    ./pkg.nix
    ./vscode.nix
    #./firefox.nix
    ./font.nix
  ];

  home.stateVersion = "21.05";
  programs.home-manager.enable = true;
}
