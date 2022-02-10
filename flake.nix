{
  description = "peter's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    macos = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
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
          ./hosts/work-dell
          ./system/nixos
          cachix.nixosModules.declarative-cachix
          home.nixosModules.home-manager
          {
            home-manager.users.peter = {
              imports = [
                ./home/default.nix
                ./home/fish.nix
                ./home/git.nix
                ./home/ssh.nix
                ./home/vscode.nix
              ];
              programs.git.userName = "Peter Vostan";
              # Removed from global config to force it to be set explicitly in each repo (to separate work and personal)
              # programs.git.userEmail = ""; 
            };

            users.users.peter = {
              home = "/home/peter";
              isNormalUser = true;
              extraGroups = [ "wheel" "networkmanager" "dialout" "docker" ];
              openssh.authorizedKeys.keys = [
                #   "ssh-ed25519 AAAAAA"
              ];
            };
          }
        ];
      };

      darwinConfigurations.work-mac = macos.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./system/macos
          cachix.nixosModules.declarative-cachix
          home.darwinModules.home-manager
          {
            home-manager.users.petervostan = {
              imports = [
                ./home/default.nix
                ./home/fish.nix
                ./home/git.nix
                ./home/ssh.nix
                ./home/vscode.nix
              ];
              programs.git.userName = "Peter Vostan";
              # Removed from global config to force it to be set explicitly in each repo (to separate work and personal)
              # programs.git.userEmail = ""; 
            };

            users.users.petervostan = {
              shell = nixpkgs.fish;
              home = "/Users/petervostan";
            };
          }
        ];
      };
    };
}
