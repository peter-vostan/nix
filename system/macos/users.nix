{ pkgs, lib, ... }: {
  home-manager.users.petervostan.imports = [ ../../home ];
  users.users.petervostan = {
    shell = pkgs.fish;
    home = "/Users/petervostan";
  };
}
