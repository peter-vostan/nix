{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    # Rust toolchain packages.
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, fenix, flake-utils, flake-compat }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        rust.channel = "stable";
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ];
        };
        channel = fenix.packages.${system}.${rust.channel};
        toolchain = channel.withComponents [ "cargo" "rustc" "rust-src" "rustfmt" ];
      in
      rec {
        # `nix develop`
        devShell = with pkgs; mkShell ({
          buildInputs = [
            toolchain
          ];

          RUST_SRC_PATH = "${channel.rust-src}/lib/rustlib/src";

          # OpenSSL
          # OPENSSL_NO_VENDOR = 1;
          # OPENSSL_DIR = "${openssl}/bin";

          # Rust Bindgen
          # LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";
          # BINDGEN_EXTRA_CLANG_ARGS = "-I${llvmPackages.libclang.lib}/lib/clang/${lib.getVersion llvmPackages.clang}/include -I${glibc.dev}/include";
        });
      }
    );
}
