{
  description = "peter's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs-channels/nixos-unstable";
    macos = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cachix.url = "github:jonascarpay/declarative-cachix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, macos, home, nur, cachix, ... }:
    let
      # Understand this??
      unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
      };
      overlays = { nixpkgs.overlays = [ unstable nur.overlay ]; };
    in
    {
      nixosConfigurations.work-dell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          overlays
          cachix.nixosModules.declarative-cachix

          home.nixosModules.home-manager
          ./home
          ./hosts/work-dell
          ./system/nixos
        ];
      };

      darwinConfigurations.work-mac = macos.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          overlays
          cachix.nixosModules.declarative-cachix

          home.darwinModules.home-manager
          ./home
          # ./hosts/work-mac
          ./system/macos
        ];
      };
    };
}
