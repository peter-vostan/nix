{
  networking.firewall.allowedTCPPorts = [ 4646 4647 ];
  services.nomad = {
    enable = true;

    settings = {
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
      advertise = {
        # Tailscale IP
        http = "100.111.249.65";
        rpc = "100.111.249.65";
        # serf = "1.2.3.4:5648";
      };
    };
  };
}
