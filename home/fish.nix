{ pkgs, ... }: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting";
    };

    # Enable the `starship` prompt.
    starship = {
      enable = true;
      settings = {
        battery.disabled = true;
      };
    };

    # Enables per-directory run-command files.
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      nix-direnv.enableFlakes = true;
    };
  };

  # Install powerline font for starship.
  home.packages = with pkgs; [
    # Fira Code
    (nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];
}
