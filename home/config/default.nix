{ pkgs, lib, config, ... }: {
  imports = [
    ./fish.nix
    ./git.nix
    ./ssh.nix
    ./vscode.nix
  ];

  home.stateVersion = "21.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    htop
    lsof
    chromium
    rnix-lsp # Nix language server
  ];
}
