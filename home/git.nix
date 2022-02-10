{ ... }: {
  programs.git = {
    enable = true;
    # Configure userName and userEmail at a higher level for configurability
    # userName = "";
    # userEmail = "";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      branch = {
        autosetupmerge = "always";
        autosetuprebase = "always";
      };
      core = {
        autocrlf = false;
        editor = "code --wait";
        eol = "lf";
      };
      diff.tool = "vscode";
      difftool.vscode.cmd = "code --wait --diff $LOCAL $REMOTE";
      init.defaultBranch = "main";
      merge.tool = "vscode";
      pull.rebase = true;
      push.default = "current";
      rebase.autoStash = true;
    };
  };
}
