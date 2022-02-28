{ ... }: {
  # git configuration, see: <https://nix-community.github.io/home-manager/options.html#opt-programs.git.enable>
  programs.git = {
    enable = true;
    # Configure userName and userEmail at a higher level for configurability
    # userName = "";
    # userEmail = "";
    ignores = [ ".DS_Store" ]; # Global file ignore list
    # git settings, see: <https://git-scm.com/docs/git-config#_variables>
    extraConfig = {
      core = {
        eol = "lf"; # Always use Unix line endings
        autocrlf = false; # Don't automatically convert line endings
        editor = "code --wait"; # Use VSCode as the commit message editor
      };
      merge.tool = "vscode"; # Use VSCode as the merge tool
      diff.tool = "vscode"; # Use VSCode as the diff tool
      difftool.vscode.cmd = "code --wait --diff $LOCAL $REMOTE"; # Setup VSCode diffing
      init.defaultBranch = "main"; # Use `main` as the default branch name
      pull.rebase = true; # Always rebase instead of merge
      push.default = "current"; # Use the same branch names locally and remotely
      rebase.autoStash = true; # Automatically stash unstaged changes then reapply after an action
    };
  };
}
