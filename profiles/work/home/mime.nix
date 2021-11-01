{ ... }: {
  xdg.mime.enable = true;
  xdg.mimeApps.defaultApplications = {
    # Set `firefox` as the default web browser.
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "application/xhtml+xml" = [ "firefox.desktop" ];
    "application/vnd.mozilla.xul+xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/ftp" = [ "firefox.desktop" ];
  };
}
