{ ... }: {
  programs.git = {
    enable = true;
    userName = "Sandro Stikić";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
