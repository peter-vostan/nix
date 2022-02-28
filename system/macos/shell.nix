# Implements user shell configuration
{ config, lib, pkgs, ... }:
with lib;
{
  options.macos.shell = lib.mkOption {
    type = types.path;
    default = "/bin/zsh";
    description = "Set the user shell";
  };

  config.home.activation =
    let
      shell = config.macos.shell;
    in
    {
      setShell = hm.dag.entryAfter [ "writeBoundary" ] ''
        echo 'setting shell to ${shell}'
        $DRY_RUN_CMD sudo chsh -s "${shell}" "$USER" &>/dev/null
      '';
    };
}
