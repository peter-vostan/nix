{ ... }: {
  programs = {
    fish = {
      enable = true;
      # Disable welcome message.
      promptInit = "set fish_greeting";
      interactiveShellInit = "fish_vi_key_bindings";
    };

    # Enable the `starship` prompt.
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    # Enables per-directory run command files.
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
