# Dell Precision 7550.
{ ... }: {
  imports = [ ./hardware.nix ];

  # networking.hostName = "";
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ 9000 14550 ];

  # Enable SSH server.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
}
