# Implements user ~/Applications management
{ config, lib, pkgs, ... }:
with lib;
{
  options.macos.manageAppDir = lib.mkOption {
    type = types.bool;
    default = false;
    description = "Manages the ~/Applications directory";
  };

  config.home.activation =
    let
      isEnabled = config.macos.manageAppDir;
    in
    {
      manageAppDir = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
        app_dir="$HOME/Applications";

        # If ~/Applications exists, move it
        if [ -f "$app_dir" ] || [ -L "$app_dir" ]; then
          echo "moving $app_dir to $app_dir.old"
          $DRY_RUN_CMD mv -n "$app_dir" "$app_dir.old"
        fi

        $DRY_RUN_CMD mkdir -p "$app_dir"

        # Delete existing aliases
        for app in "$app_dir"/*.app; do
          if [ "$(mdls -raw -name kMDItemKind "$app")" = "Alias" ]; then
            $DRY_RUN_CMD rm -f "$app"
          fi
        done

        # Alias all user apps
        for app in "$newGenPath"/home-path/Applications/*.app; do
          app_name=$(basename "$app"); app_path=$(realpath "$app")
          echo "aliasing $app_name -> $app_dir/$app_name"
          $DRY_RUN_CMD rm -f "$app_dir/$app_name" && $DRY_RUN_CMD osascript \
            -e "tell app \"Finder\"" \
              -e "make new alias file at POSIX file \"$app_dir\" to POSIX file \"$app_path\"" \
              -e "set name of result to \"$app_name\"" \
            -e "end tell" >/dev/null
        done
      '';
    };
}
