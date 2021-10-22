{ pkgs, lib, ... }:
let
  packages = with pkgs; [
    # Dev tools
    ## Languages
    ### Nix
    rnix-lsp # Nix language server
    git # Version control
    vim # Command line text editor
    # Utilities
    htop # Interactive proccess viewer
    wally-cli # Firmware flasher for ZSA keyboards
  ];
  macosPackages = with pkgs; [ ];
  nixosPackages = with pkgs; [
    _1password-gui # Password manager
    gnomeExtensions.dash-to-dock
  ];
in
{
  home.packages = packages
    ++ lib.optionals pkgs.stdenv.isDarwin macosPackages
    ++ lib.optionals pkgs.stdenv.isLinux nixosPackages;
}
