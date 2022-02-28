{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      battery.disabled = true;
    };
  };

  # Install powerline fonts for starship
  home.packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
}
