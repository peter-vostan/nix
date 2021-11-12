{ pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Prefer the packaged version for extensions which require additional binaries.
      vadimcn.vscode-lldb
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # To fetch new extension versions, run `./fetch-vscode-ext`.
      {
        name = "shell-format";
        publisher = "foxundermoon";
        version = "7.1.1";
        sha256 = "Vp+w/b2jpzS0F9lkPKrakpJiUbxjjlYMecyrl0I6OK0=";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "11.6.1";
        sha256 = "0nghanaxa5db7lxfi4nly45iaps560zkwsfhmzhiiaan0hj0qmcs";
      }
      {
        name = "vscode-pull-request-github";
        publisher = "GitHub";
        version = "0.31.1";
        sha256 = "17az74in63xy460g8m1wsyj0i4gza6rw42fwi1i0l0afl5a8nc2s";
      }
      {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "0.1.18";
        sha256 = "1v3j67j8bydyqba20b2wzsfximjnbhknk260zkc0fid1xzzb2sbn";
      }
      {
        name = "nix-env-selector";
        publisher = "arrterian";
        version = "1.0.7";
        sha256 = "sha256-DnaIXJ27bcpOrIp1hm7DcrlIzGSjo4RTJ9fD72ukKlc=";
      }
      {
        name = "theme-monokai-pro-vscode";
        publisher = "monokai";
        version = "1.1.19";
        sha256 = "0skzydg68bkwwwfnn2cwybpmv82wmfkbv66f54vl51a0hifv3845";
      }
      {
        name = "code-spell-checker";
        publisher = "streetsidesoftware";
        version = "2.0.10";
        sha256 = "05jgq7yci2c09msz3bbbdfjkh61jx7ga3sjpb5hh7wgzp9pfi8yn";
      }
      {
        name = "even-better-toml";
        publisher = "tamasfe";
        version = "0.14.2";
        sha256 = "17djwa2bnjfga21nvyz8wwmgnjllr4a7nvrsqvzm02hzlpwaskcl";
      }
      {
        name = "errorlens";
        publisher = "usernamehw";
        version = "3.4.0";
        sha256 = "qBqQGv0BmTFK/y8hprplCVr5aZr3z9jM5a2Eu6CfOfU=";
      }
    ];

    userSettings = lib.mkMerge [
      {
        # Workbench
        "workbench.colorTheme" = "Monokai Pro";
        "workbench.iconTheme" = "Monokai Pro Icons";

        # Editor
        "editor.acceptSuggestionOnEnter" = "off";
        "editor.autoClosingBrackets" = "always";
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = true;
        "editor.fontFamily" = "'FiraCode Nerd Font', monospace";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        "editor.fontWeight" = "700";
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

        # Spelling
        "cSpell.allowCompoundWords" = true;
        "cSpell.spellCheckDelayMs" = 1000;

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
