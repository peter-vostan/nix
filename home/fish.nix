{ ... }: {
  programs = {
    fish = {
      enable = true;
      # Disable welcome message.
      interactiveShellInit = "set fish_greeting; fish_vi_key_bindings";
    };

    # Enable the `starship` prompt.
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        nix_shell = {
          symbol = "⛄ ";
          format = ''via [$symbol$state( $name)]($style) '';
        };
      };
    };

    # Enables per-directory run-command files.
    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
  };
}
