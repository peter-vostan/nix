{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Rust
      matklad.rust-analyzer                   # Language server
      serayuzgur.crates                       # Dependency analyzer
      tamasfe.even-better-toml                # Improved TOML support
      # jscearcy.rust-doc-viewer
      # swellaby.vscode-rust-test-adapter
      vadimcn.vscode-lldb                     # Debugger

      # Nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector
    ];
    userSettings = {
      # "editor.fontFamily" = "";
    };
  };
}
