{ config, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/github.com";
      };
      "stikic.me" = {
        hostname = "stikic.me";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/stikic.me";
      };
      "stikic.com" = {
        hostname = "stikic.com";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/stikic.com";
      };
      "marisa.local" = {
        hostname = "marisa.local";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/marisa.local";
      };
    };
  };
}
