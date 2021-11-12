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
  };

  outputs = { self, nix, nixos, home, nur, ... }: {
    nixosConfigurations.work = nixos.lib.nixosSystem
      {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = [ nix.overlay nur.overlay ]; }
          home.nixosModules.home-manager
          ./home
          ./hosts/work
          ./system/nixos
        ];
      };
  };
}
