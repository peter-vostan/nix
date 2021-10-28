{ ... }: {
  programs.git = {
    userEmail = "sandro@stikic.com";
    signing = {
      key = "E1492413C1CB24EC";
      signByDefault = true;
    };
  };
}
