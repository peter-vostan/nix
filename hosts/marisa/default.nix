# Dell Precision 7550.
# In the BIOS, disable Video > Switchable graphics
{ ... }: {
  imports = [ ./hardware.nix ];

  # Set hostname.
  networking.hostName = "marisa";

  # Setup network interfaces.
  networking.interfaces.eno2.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  # Enable SSH server.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  users.users.opeik.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIFxG3ZHW2JkmJ/v76Q+MCrwafK5BAQ3ZQf76F+pKh53"
  ];
}
