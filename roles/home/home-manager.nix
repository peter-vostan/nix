{ config, ... }: {
  programs.git = {
    userEmail = "sandro@stikic.com";
    lfs.enable = true;
    signing = {
      key = "E1492413C1CB24EC";
      signByDefault = true;
    };
  };

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
    };
  };
}
