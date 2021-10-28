{ config, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/github.com";
      };
    };
  };
}
