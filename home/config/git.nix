{ ... }: {
  programs.git = {
    enable = true;
    userName = "Peter Vostan";
    # Removed from global config to force it to be set explicitly in each repo (to separate work and personal)
    # userEmail = "p.vostan@fugro.com";
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
