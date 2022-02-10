{ pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Prefer the packaged version for extensions which require additional binaries.
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

        # Files
        "files.autoSave" = "afterDelay";

        # Telemetry
        "githubPullRequests.telemetry.enabled" = false;
        "telemetry.enableCrashReporter" = false;
        "telemetry.enableTelemetry" = false;

        # Updates
        "update.mode" = "none";

        # Git
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
