{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    # Rust toolchain packages.
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    # Ros overlay for ROS packages
    ros-overlay = {
      url = "github:lopsided98/nix-ros-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fenix, flake-utils, ros-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        rustchannel = "stable";
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ros-overlay.overlay ];
        };
        channel = fenix.packages.${system}.${rust.channel};
        toolchain = channel.withComponents [ "cargo" "rustc" "rust-src" ];
      in
      {
        # `nix develop`
        devShell = with pkgs; mkShell ({
          buildInputs = [
            toolchain

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

          RUST_SRC_PATH = "${channel.rust-src}/lib/rustlib/src";

          # Rust Bindgen
          LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
          BINDGEN_EXTRA_CLANG_ARGS = "-I${llvmPackages.libclang.lib}/lib/clang/${lib.getVersion llvmPackages.clang}/include -I${glibc.dev}/include";
        });
      }
    );
}
