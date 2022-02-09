{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    # Rust toolchain packages.
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Rust crate builder for Nix.
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    # Ros overlay for ROS packages
    ros-overlay = {
      url = "github:lopsided98/nix-ros-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fenix, naersk, flake-utils, ros-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ ros-overlay.overlay ]; };

        rust = {
          pkgs = fenix.packages.${system};
          channel = rust.pkgs.stable;
          toolchain = rust.pkgs.combine (with pkgs;
            [
              rust.channel.toolchain
              # rust.pkgs.targets.aarch64-unknown-linux-gnu.stable.rust-std
              # rust.pkgs.targets.armv7-unknown-linux-gnueabihf.stable.rust-std
            ] ++ lib.optionals stdenv.isDarwin [
              darwin.apple_sdk.frameworks.Security
              libiconv
            ]
          );
          dev = rust.pkgs.combine [
            rust.toolchain
            rust.channel.rust-src
          ];
        };

        builder = naersk.lib.${system}.override {
          cargo = rust.toolchain;
          rustc = rust.toolchain;
        };

        # armv7l-pkgs = import nixpkgs { inherit system; crossSystem = { system = "armv7l-linux"; }; };
        # aarch64-pkgs = import nixpkgs { inherit system; crossSystem = { system = "aarch64-linux"; }; };
      in
      rec
      {
        # `nix build`
        defaultPackage = packages.default;

        # `nix run`
        defaultApp = flake-utils.lib.mkApp {
          drv = defaultPackage;
        };

        # `nix develop`
        devShell = with pkgs; mkShell ({
          buildInputs = [
            rust.toolchain

            glibcLocales
            (with rosPackages.foxy; [
              colcon
              rmw-fastrtps-dynamic-cpp
              rosidl-default-generators
              rosidl-default-runtime
              ros2action
              ros2node
              ros2run
              ros2service
              ros2topic
              turtlesim
            ])
          ];

          shellHook = ''
            . ros_ws/install/setup.sh
          '';

          RMW_IMPLEMENTATION = "rmw_fastrtps_dynamic_cpp";

          RUST_SRC_PATH = "${rust.dev}/lib/rustlib/src";

          # Rust Bindgen
          LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
          BINDGEN_EXTRA_CLANG_ARGS = "-I${llvmPackages.libclang.lib}/lib/clang/${lib.getVersion llvmPackages.clang}/include -I${glibc.dev}/include";
        });

        packages = {
          default = builder.buildPackage {
            root = ./.;
            doCheck = true;
            RUST_BACKTACE = "full";
          };

          docker = pkgs.dockerTools.buildLayeredImage {
            name = "xyz";
            tag = "latest";
            config.Cmd = [ "${packages.default}/bin/xyz" ];
            created = "now";
          };

          # aarch64-linux = builder.buildPackage {
          #   root = ./.;
          #   doCheck = true;
          #   RUST_BACKTACE = "full";
          #   CARGO_BUILD_TARGET = "aarch64-unknown-linux-gnu";
          #   CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER =
          #     "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/aarch64-unknown-linux-gnu-gcc";
          # };
        };
      }
    );
}
