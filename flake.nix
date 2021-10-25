{
  description = "opeik's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = github:nix-community/NUR;
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, darwin, home-manager, nixpkgs, nixos-hardware, nur, ... }:
    let
      sharedModules = [ ./modules ];
      macosModules = [ home-manager.darwinModules.home-manager ./modules/macos ];
      nixosModules = [ home-manager.nixosModules.home-manager ./modules/nixos ];
      overlays = [{ nixpkgs.overlays = [ nur.overlay ]; }];

      # Creates a macOS configuration.
      macosConfig = { system ? "aarch64-darwin", modules }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = sharedModules ++ macosModules ++ modules ++ overlays;
        };

      # Creates a nixOS configuration.
      nixosConfig = { system ? "x86_64-linux", modules }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ nixosModules ++ modules ++ overlays;
        };
    in
    {
      darwinConfigurations = {
        reimu = macosConfig { modules = [ ./hosts/reimu ./roles/home ]; };
        reimu-ci = macosConfig { system = "x86_64-darwin"; modules = [ ./hosts/reimu ./roles/home ]; };
      };

      nixosConfigurations = {
        marisa = nixosConfig { modules = [ ./hosts/marisa ./roles/work ]; };
      };
    };
}
