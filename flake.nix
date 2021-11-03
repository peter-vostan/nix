{
  description = "opeik's nix configs";

  inputs = {
    nix.url = "github:nixos/nix/2.4";
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    macos = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixos";
    };
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos";
    };
    nur = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixos";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixos";
    };
  };

  outputs = { self, nix, nixos, macos, home, nur, fenix, ... }:
    let
      overlays = { nixpkgs.overlays = [ nix.overlay nur.overlay fenix.overlay ]; };
      sharedModules = [ ./modules overlays ];
      macosModules = [ home.darwinModules.home-manager ./modules/macos ];
      nixosModules = [ home.nixosModules.home-manager ./modules/nixos ];

      # Creates a macOS configuration.
      macosConfig = { system, modules }:
        macos.lib.darwinSystem {
          inherit system;
          modules = sharedModules ++ macosModules ++ modules;
        };

      # Creates a nixOS configuration.
      nixosConfig = { system, modules }:
        nixos.lib.nixosSystem {
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
