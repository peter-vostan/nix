# Implements sudo Touch ID authentication
{ config, lib, pkgs, ... }: {
  options.security.pam.enableSudoTouchIdAuth = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''
      Enable sudo authentication with Touch ID

      When enabled, this option adds the following line to /etc/pam.d/sudo:

          auth       sufficient     pam_tid.so

      (Note that macOS resets this file when doing a system update. As such, sudo
      authentication with Touch ID won't work after a system update until the nix-darwin
      configuration is reapplied.)
    '';
  };

  config.system.activationScripts.extraActivation.text =
    let
      isEnabled = config.security.pam.enableSudoTouchIdAuth;
      pamFile = "/etc/pam.d/sudo";
      option = "security.pam.enableSudoTouchIdAuth";
      sed = "${pkgs.gnused}/bin/sed";
    in
    ''
      echo "setting up sudo touch id authentication"
      ${if isEnabled then ''
        if ! grep 'pam_tid.so' ${pamFile} > /dev/null; then
          $DRY_RUN_CMD ${sed} -i '2i\
        auth       sufficient     pam_tid.so # enabled by nix-darwin: `${option}`
          ' ${pamFile}
        fi
      '' else ''
        if grep '${option}' ${pamFile} > /dev/null; then
          $DRY_RUN_CMD ${sed} -i '/${option}/d' ${pamFile}
        fi
      ''}
    '';
}
