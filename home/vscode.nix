{ pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode; # use unstable version so that it's kept up to date
    extensions = with pkgs.unstable.vscode-extensions; [
      vadimcn.vscode-lldb
      github.github-vscode-theme
      github.vscode-pull-request-github
      usernamehw.errorlens
      eamodio.gitlens
      foxundermoon.shell-format
      arrterian.nix-env-selector
      jnoortheen.nix-ide
      tamasfe.even-better-toml
      matklad.rust-analyzer
    ];

    userSettings = lib.mkMerge [
      {
        # Editor
        "editor.acceptSuggestionOnEnter" = "off";
        "editor.autoClosingBrackets" = "always";
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = true;
        "editor.fontFamily" = "'FiraCode Nerd Font', monospace";
        "editor.fontLigatures" = true;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.renderFinalNewline" = false;
        "editor.rulers" = [ 80 ];
        "editor.smoothScrolling" = true;
        "editor.stickyTabStops" = true;

        # Terminal
        "terminal.integrated.fontSize" = 12;
        "terminal.integrated.allowChords" = false;
        "terminal.integrated.gpuAcceleration" = "on";
        "terminal.integrated.cursorStyle" = "line";
        "terminal.integrated.cursorBlinking" = true;

        # Files
        "files.autoSave" = "afterDelay";

        # Telemetry
        "githubPullRequests.telemetry.enabled" = false;
        "telemetry.telemetryLevel" = "off";

        # Updates
        "update.mode" = "none";

        # Git
        "git.autofetch" = true;
        "gitlens.codeLens.enabled" = false;
        "gitlens.currentLine.enabled" = false;

        # Languages
        ## Nix
        "nix.enableLanguageServer" = true;
        "nixEnvSelector.nixFile" = "\${workspaceRoot}/shell.nix";
        "[nix]" = { "editor.tabSize" = 2; };

        ## Shell
        "shellformat.path" = "${pkgs.shfmt}/bin/shfmt";
      }
    ];
  };
}
