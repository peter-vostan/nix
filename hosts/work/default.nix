# Dell Precision 7550.
{ ... }: {
  imports = [ ./hardware.nix ];

  # Set hostname.
  # networking.hostName = "";

  # Setup network interfaces.
  networking.interfaces.eno2.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ 9000 ];

  # Enable SSH server.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # users.users.peter.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAAAA"
  # ];
}
