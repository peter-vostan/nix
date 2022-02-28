{
  description = "peter's nix configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    cachix.url = "github:jonascarpay/declarative-cachix";
    macos = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, cachix, macos, home, ... }:
    let
      unstableOverlay = final: prev: {
        unstable = import unstable {
          system = prev.system;
          config.allowUnfree = true;
        };
      };
      overlays.nixpkgs.overlays = [ unstableOverlay ];
      commonModules = [
        overlays
        cachix.nixosModules.declarative-cachix
      ];
    in
    {
      nixosConfigurations.work-dell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ [
          ./hosts/work-dell
          ./system/nixos
          home.nixosModules.home-manager
          {
            home-manager.users.peter = {
              imports = [
                ./home
                ./home/fish.nix
                ./home/starship.nix
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
        modules = commonModules ++ [
          ./system/macos
          home.darwinModules.home-manager
          {
            home-manager.users.petervostan = {
              imports = [
                ./home
                ./home/macos
                ./home/fish.nix
                ./home/starship.nix
                ./home/git.nix
                ./home/ssh.nix
                ./home/vscode.nix
              ];
              macos = {
                manageAppDir = true; # Alias applications to ~/Applications
                shell = "/etc/profiles/per-user/petervostan/bin/fish"; # Set the user shell to fish
                terminal.font = "FiraCode Nerd Font"; # Set the macOS Terminal.app font to Fira Code
              };
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
