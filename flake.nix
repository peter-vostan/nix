{
  description = "opeik's nix configs";

  inputs = {
    nix.url = "github:nixos/nix/2.4-maintenance";
    nixos.url = "github:nixos/nixpkgs/nixos-21.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # macOS support.
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixos";
    };
    # Manages your home directory.
    home = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixos";
    };
    # Provides Rust toolchains.
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixos";
    };
  };

  outputs = { self, nix, nixos, nixos-unstable, darwin, home, nur, fenix, ... }:
    let
      overlays = { nixpkgs.overlays = [ nix.overlay nur.overlay fenix.overlay ]; };
      sharedModules = [ ./modules overlays ];
      macosModules = [ home.darwinModules.home-manager ./modules/macos ];
      nixosModules = [ home.nixosModules.home-manager ./modules/nixos ];

      # Creates a nixOS system.
      nixosSystem = { system, modules }:
        let
          nixos-unstable-overlay = final: prev: {
            unstable = nixos-unstable.legacyPackages.${system};
          };
          extraOverlays = [{ nixpkgs.overlays = [ nixos-unstable-overlay ]; }];
        in
        nixos.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ nixosModules ++ modules ++ extraOverlays;
        };

      # Creates a macOS system.
      macosSystem = { system, modules }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = sharedModules ++ macosModules ++ modules;
        };
    in
    {
      nixosConfigurations = {
        marisa = nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/marisa ./profiles/work ];
        };
      };

      darwinConfigurations = {
        reimu = macosSystem {
          system = "aarch64-darwin";
          modules = [ ./hosts/reimu ./profiles/personal ];
        };
        reimu-ci = macosSystem {
          system = "x86_64-darwin";
          modules = [ ./hosts/reimu ./profiles/personal ];
        };
      };
    };
}
