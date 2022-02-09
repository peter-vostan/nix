{ pkgs, ... }: {
  home-manager.users.petervostan = {
    imports = [
      ../../home/default.nix
      ../../home/fish.nix
      ../../home/git.nix
      ../../home/ssh.nix
      ../../home/vscode.nix
    ];
  };

  users.users.petervostan = {
    shell = pkgs.fish;
    home = "/Users/petervostan";
  };
}
