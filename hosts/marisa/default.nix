# Dell Precision 7550.
{ ... }: {
  imports = [ ./hardware.nix ];

  # Set hostname.
  networking.hostName = "marisa";

  # Setup network interfaces.
  networking.interfaces.eno2.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;
}
