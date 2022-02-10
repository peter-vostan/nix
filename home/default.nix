{ pkgs, lib, config, ... }: {
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    rnix-lsp # Nix language server
  ];
}
