{ pkgs, ... }: {
  programs.firefox = {
      enable = true;
      package = if pkgs.stdenv.isLinux then pkgs.firefox-wayland else pkgs.firefox;
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
