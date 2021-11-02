{
  description = "opeik's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # macOS support.
    macos = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nix user repo.
    nur = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Manages your home directory.
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Provides Rust toolchains.
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix, nixpkgs, macos, home, nur, fenix, ... }:
    let
      overlays = { nixpkgs.overlays = [ nur.overlay fenix.overlay ]; };
      sharedModules = [ ./modules overlays ];
      macosModules = [ home.darwinModules.home-manager ./modules/macos ];
      nixosModules = [ home.nixosModules.home-manager ./modules/nixos ];

      # Creates a nixOS system.
      nixosSystem = { system, modules }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ nixosModules ++ modules;
        };

      # Creates a macOS system.
      macosSystem = { system, modules }:
        macos.lib.darwinSystem {
          inherit system;
          modules = sharedModules ++ macosModules ++ modules;
          specialArgs = { inherit fenix; };
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
