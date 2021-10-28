{ ... }: {
  # Use gnome via wayland.
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      # Wayland disabled until vscode fixes hardware acceleration.
      # See: https://github.com/microsoft/vscode/issues/105729
      wayland = false;
      nvidiaWayland = false;
    };
  };
}
