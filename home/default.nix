{ pkgs, lib, config, ... }: {
  programs.home-manager.enable = true;
  xdg.enable = true;

  home = {
    # Ensure home-managers's state version is the same as the nixpkgs version.
    stateVersion = "21.11";
    # Default packages
    packages = with pkgs; [
      rnix-lsp # Nix language server
      jq # sed for json eg. $ echo '{"foo": 10}' | jq .foo
    ];
    # Alias apps to `~/Applcations` for SpotLight indexing.
    # TODO: Test if this breaks things for NixOS and can only be used by nixDarwin
    activation = {
      aliasApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        apps_path="$HOME/Applications";
        for app in "$genProfilePath"/home-path/Applications/*.app; do
          app_alias="$(basename "$app")"
          $DRY_RUN_CMD rm -f "$apps_path/$app_alias"
          $DRY_RUN_CMD osascript \
            -e "tell app \"Finder\"" \
            -e "make new alias file at POSIX file \"$apps_path\" to POSIX file \"$app\"" \
            -e "set name of result to \"$app_alias\"" -e "end tell" >/dev/null
        done
      '';
    };
  };
}
