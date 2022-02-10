{ ... }: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting";
    };

    # Enable the `starship` prompt.
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        battery.disabled = true;
        nix_shell = {
          symbol = "⛄ ";
          format = ''via [$symbol$state( $name)]($style) '';
        };
      };
    };

    # Enables per-directory run-command files.
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
