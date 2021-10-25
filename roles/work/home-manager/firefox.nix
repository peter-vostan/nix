{ pkgs, lib, ... }:
let
  # Wrap `firefox` to always use `wayland`.
  firefoxWayland = (pkgs.firefox.overrideAttrs (_: {
    desktopItem =
      pkgs.makeDesktopItem {
        name = "firefox";
        exec = "env MOZ_ENABLE_WAYLAND=1 MOZ_DBUS_REMOTE=1 firefox %u";
        icon = "firefox";
        comment = "";
        desktopName = "Firefox";
        genericName = "Web Browser";
        categories = "Network;WebBrowser;";
        mimeType = lib.concatStringsSep ";" [
          "text/html"
          "text/xml"
          "application/xhtml+xml"
          "application/vnd.mozilla.xul+xml"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/ftp"
        ];
      };
  }));
in
{
  programs.firefox = {
    enable = true;
    package = if pkgs.stdenv.isLinux then firefoxWayland else pkgs.firefox;
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
