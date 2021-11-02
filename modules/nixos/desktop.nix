{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      nvidiaWayland = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock # Makes gnome *usable*
  ];
}
