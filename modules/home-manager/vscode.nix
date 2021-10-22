{ pkgs, lib, ... }:
let
  monokai-pro = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "theme-monokai-pro-vscode";
    publisher = "monokai";
    version = "1.1.19";
    sha256 = "sha256-haCxXYRAhUI3Kc6YvaarXKBd7/KcCWsd53wuZF7zf2o=";
  };
  rust-test-explorer = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-rust-test-adapter";
    publisher = "swellaby";
    version = "0.11.0";
    sha256 = "sha256-IgfcIRF54JXm9l2vVjf7lFJOVSI0CDgDjQT+Hw6FO4Q=";
  };
in
{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      # Theme
      monokai-pro # The one true theme

      # Keybinds
      vscodevim.vim # The one true layout

      # Languages
      ## Rust
      matklad.rust-analyzer # Language server
      serayuzgur.crates # Dependency analyzer
      tamasfe.even-better-toml # Improved TOML support
      rust-test-explorer
      # jscearcy.rust-doc-viewer
      # swellaby.vscode-rust-test-adapter
      vadimcn.vscode-lldb # Debugger

      ## Nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector
    ];

    userSettings = {
      # Theme
      "workbench.colorTheme" = "Monokai Pro";
      "workbench.iconTheme" = "Monokai Pro Icons";

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
      "editor.renderFinalNewline" = true;

      # Terminal
      "terminal.integrated.fontSize" = 12;
      "terminal.integrated.fontWeight" = "700";

      # Files
      "files.autoSave" = "afterDelay";
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;

      # Languages
      ## Nix
      "nix.enableLanguageServer" = true;

      # Telemetry
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;

      # Updates
      "update.mode" = "none"; # Updates are handled by Nix.
    };
  };
}
