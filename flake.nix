{
  description = "opeik's nix configs";

  inputs = {
    # Nix packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = github:nix-community/NUR;
    # macOS support.
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Manages your home directory.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Provides Rust toolchains.
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, darwin, home-manager, nixpkgs, nur, fenix, ... }:
    let
      overlays = { nixpkgs.overlays = [ nur.overlay fenix.overlay ]; };
      sharedModules = [ ./modules overlays ];
      macosModules = [ home-manager.darwinModules.home-manager ./modules/macos ];
      nixosModules = [ home-manager.nixosModules.home-manager ./modules/nixos ];

      # Creates a macOS configuration.
      macosConfig = { system, modules }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = sharedModules ++ macosModules ++ modules;
        };

      # Creates a nixOS configuration.
      nixosConfig = { system, modules }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ nixosModules ++ modules;
        };
    in
    {
      darwinConfigurations = {
        reimu = macosConfig {
          system = "aarch64-darwin";
          modules = [ ./hosts/reimu ./profiles/personal ];
        };
        reimu-ci = macosConfig {
          system = "x86_64-darwin";
          modules = [ ./hosts/reimu ./profiles/personal ];
        };
      };

      nixosConfigurations = {
        marisa = nixosConfig {
          system = "x86_64-linux";
          modules = [ ./hosts/marisa ./profiles/work ];
        };
      };
    };
}
