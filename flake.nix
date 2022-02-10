{
  description = "peter's nix configs";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    macos = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
      # url = "github:nix-community/home-manager/release-21.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cachix.url = "github:jonascarpay/declarative-cachix";
  };

  outputs = { self, nixpkgs, macos, home, cachix, ... }:
    {
      nixosConfigurations.work-dell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          cachix.nixosModules.declarative-cachix
          home.nixosModules.home-manager
          ./hosts/work-dell
          ./system/nixos
        ];
      };

      darwinConfigurations.work-mac = macos.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          cachix.nixosModules.declarative-cachix
          home.darwinModules.home-manager
          ./system/macos
        ];
      };
    };
}
