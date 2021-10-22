{ ... }: {
  # Use gnome via wayland.
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      nvidiaWayland = true;
    };
  };
}
