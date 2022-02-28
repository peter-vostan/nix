{ pkgs, lib, config, ... }: {
  fonts.fontconfig.enable = true;
  xdg.enable = true;

  programs = {
    home-manager.enable = true;

    # Enables per-directory run-command files.
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
  };

  home = {
    # Ensure home-managers's state version is the same as the nixpkgs version.
    stateVersion = "21.11";
    # Default packages
    packages = with pkgs; [
      rnix-lsp # Nix language server
      jq # sed for json eg. $ echo '{"foo": 10}' | jq .foo
    ];
  };
}
