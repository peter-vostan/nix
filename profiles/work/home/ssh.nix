{ config, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "${config.home.homeDirectory}/.ssh/github.com";
      };
      "fugro.github.com" = {
        hostname = "github.com";
        identityFile = "${config.home.homeDirectory}/.ssh/fugro.github.com";
      };
    };
  };
}
