# Implements user Terminal.app configuration
{ config, lib, pkgs, ... }:
with lib;
{
  options.macos.terminal.font = mkOption {
    type = types.nullOr types.str;
    default = null;
    description = "Set the user Terminal.app font";
  };

  config.home.activation =
    let
      font = config.macos.terminal.font;
    in
    lib.mkIf (! isNull font) {
      setTerminalFont = hm.dag.entryAfter [ "writeBoundary" ] ''
        echo 'setting terminal font to "${font}"'
        $DRY_RUN_CMD osascript -e '
        tell application "Terminal"
            set profiles to name of every settings set
                repeat with profile in profiles
                    set font name of settings set profile to "${font}"
            end repeat
        end tell'
      '';
    };
}
