{
  description = "peter's nix configs";

  inputs = {
    nix.url = "github:nixos/nix/2.4";
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
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

  outputs = { self, nix, nixos, home, nur, fenix, ... }:
    let
      overlays = { nixpkgs.overlays = [ nix.overlay nur.overlay fenix.overlay ]; };
      sharedModules = [ ./modules overlays ];
      nixosModules = [ ./modules/nixos home.nixosModules.home-manager ];

      # Creates a nixOS configuration.
      nixosConfig = { system, modules }:
        nixos.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ nixosModules ++ modules;
        };
    in
    {
      nixosConfigurations = {
        work = nixosConfig {
          system = "x86_64-linux";
          modules = [ ./hosts/work ./profiles/work ];
        };
      };
    };
}
