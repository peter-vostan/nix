{ pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      # Prefer the packaged version for extensions which require additional binaries.
      vadimcn.vscode-lldb
      matklad.rust-analyzer
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
        name = "rust-analyzer";
        publisher = "matklad";
        version = "0.2.792";
        sha256 = "1m4g6nf5yhfjrjja0x8pfp79v04lxp5lfm6z91y0iilmqbb9kx1q";
      }
      {
        name = "theme-monokai-pro-vscode";
        publisher = "monokai";
        version = "1.1.19";
        sha256 = "0skzydg68bkwwwfnn2cwybpmv82wmfkbv66f54vl51a0hifv3845";
      }
      {
        name = "vscode-docker";
        publisher = "ms-azuretools";
        version = "1.17.0";
        sha256 = "01na7j64mavn2zqfxkly9n6fpr6bs3vyiipy09jkmr5m86fq0cdx";
      }
      {
        name = "remote-ssh";
        publisher = "ms-vscode-remote";
        version = "0.65.8";
        sha256 = "0csi4mj2j00irjaw6vjmyadfbpmxxcx73idlhab6d9y0042mpr0g";
      }
      {
        name = "crates";
        publisher = "serayuzgur";
        version = "0.5.10";
        sha256 = "1dbhd6xbawbnf9p090lpmn8i5gg1f7y8xk2whc9zhg4432kdv3vd";
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
        name = "vim";
        publisher = "vscodevim";
        version = "1.21.10";
        sha256 = "0c9m7mc2kmfzj3hkwq3d4hj43qha8a75q5r1rdf1xfx8wi5hhb1n";
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
        "editor.smoothScrolling" = true;
        "editor.stickyTabStops" = true;

        # Terminal
        "terminal.integrated.fontSize" = 12;
        "terminal.integrated.allowChords" = false;
        "terminal.integrated.gpuAcceleration" = "on";

        # Files
        "files.autoSave" = "afterDelay";
        "files.eol" = "\n";
        "files.exclude" = {
          "**/.direnv/" = true; # Direnv build artifacts
          "**/.DS_Store" = true; # macOS Finder directory metadata
          "**/.git" = true; # Git data
          "**/result" = true; # Rust build artifacts
          "**/target" = true; # Nix build output
        };
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;

        # Remote SSH
        "remote.SSH.useLocalServer" = false;
        "remote.SSH.remotePlatform" = {
          "marisa.local" = "linux";
        };

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

        # Languages
        ## Rust
        "crates.listPreReleases" = true;
        "rust-analyzer.completion.postfix.enable" = false;
        "rust-analyzer.experimental.procAttrMacros" = true;

        ## Nix
        "nix.enableLanguageServer" = true;
        "nixEnvSelector.nixFile" = "\${workspaceRoot}/shell.nix";
        "[nix]" = { "editor.tabSize" = 2; };
      }
      (lib.mkIf (pkgs.stdenv.isLinux) {
        # Native window decorations don't work yet.
        # See: https://github.com/microsoft/vscode/issues/124202
        # "window.titleBarStyle" = "custom";
      })
    ];
  };
}
