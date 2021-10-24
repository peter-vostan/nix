{ pkgs, lib, ... }:
let
  monokai-pro = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "theme-monokai-pro-vscode";
    publisher = "monokai";
    version = "1.1.19";
    sha256 = "sha256-haCxXYRAhUI3Kc6YvaarXKBd7/KcCWsd53wuZF7zf2o=";
  };
in
{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      # General
      monokai-pro # The one true theme
      vscodevim.vim # The one true layout
      ms-vscode-remote.remote-ssh # SSH support
      eamodio.gitlens # Visualize git data
      github.vscode-pull-request-github # GitHub integration

      # Languages
      ## Rust
      matklad.rust-analyzer # Language server
      serayuzgur.crates # Dependency analyzer
      tamasfe.even-better-toml # Improved TOML support
      vadimcn.vscode-lldb # Debugger

      ## Nix
      jnoortheen.nix-ide # Language server
      arrterian.nix-env-selector # `nix shell` support

      ## Docker
      ms-azuretools.vscode-docker # Language support

      ## Markdown
      yzhang.markdown-all-in-one # Language support
    ];

    userSettings = {
      # Workbench
      "workbench.colorTheme" = "Monokai Pro";
      "workbench.iconTheme" = "Monokai Pro Icons";
      "workbench.fontAliasing" = "auto";

      # Editor
      "editor.acceptSuggestionOnEnter" = "off";
      "editor.autoClosingBrackets" = "always";
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = true;
      "editor.cursorStyle" = "block";
      "editor.fontFamily" = "'FiraCode Nerd Font', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "editor.fontWeight" = "700";
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.renderFinalNewline" = false;
      "editor.rulers" = [ 80 ];
      "editor.stickyTabStops" = true;
      "editor.smoothScrolling" = true;

      # Terminal
      "terminal.integrated.fontSize" = 12;

      # Files
      "files.autoSave" = "afterDelay";
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "files.eol" = "\n";

      # Telemetry
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "githubPullRequests.telemetry.enabled" = false;

      # Updates
      "update.mode" = "none";

      # Languages
      ## Rust
      "crates.listPreReleases" = true;
      "rust-analyzer.completion.postfix.enable" = false;
      "rust-analyzer.experimental.procAttrMacros" = true;

      ## Nix
      "nix.enableLanguageServer" = true;
      "[nix]" = { "editor.tabSize" = 2; };
    };
  };
}
