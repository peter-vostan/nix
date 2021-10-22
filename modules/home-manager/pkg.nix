{ pkgs, lib, ... }:
let
  packages = with pkgs; [
    # Dev tools
    ## Languages        
    ### Nix             
    rnix-lsp            # Nix language server

    # Utilities         
    htop                # Improved `top`
  ];
  macosPackages = with pkgs; [ ];
  nixosPackages = with pkgs; [
    _1password-gui      # Password manager
  ];
in
{
  home.packages = packages
    ++ lib.optionals pkgs.stdenv.isDarwin macosPackages
    ++ lib.optionals pkgs.stdenv.isLinux nixosPackages;
}
