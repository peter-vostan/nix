{ pkgs, lib, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      onepassword-password-manager
    ];
    profiles.opeik.settings = {
      # Restore last session on startup.
      "browser.startup.page" = 3;
    };
  };
}
