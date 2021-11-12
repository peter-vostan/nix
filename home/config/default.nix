{ pkgs, lib, config, ... }: {
  imports = [
    ./fish.nix
    ./git.nix
    ./ssh.nix
    ./vscode.nix
  ];

  home.stateVersion = "21.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    htop
    google-chrome
    # Keeps crashing if I enable ozone wayland...
    # (google-chrome.override {
    #   commandLineArgs = [
    #     "--enable-features=UseOzonePlatform"
    #     "--ozone-platform=wayland"
    #   ];
    # })
    rnix-lsp # Nix language server
    teams # ms-teams
  ];
}
