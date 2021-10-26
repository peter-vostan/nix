{ ... }: {
  programs.git = {
    enable = true;
    userName = "Sandro Stikić";
    ignores = [ ".DS_Store" ];
    extraConfig = {
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
