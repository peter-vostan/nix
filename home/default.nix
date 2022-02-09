{ pkgs, lib, config, ... }: {
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    git
    htop
    lsof
    rnix-lsp # Nix language server
  ];
}
