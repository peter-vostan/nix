{ pkgs, lib, ... }: {
  users.users.peter = lib.mkMerge [
    {
      shell = pkgs.fish;
    }
    (lib.mkIf pkgs.stdenv.isDarwin {
      home = "/Users/petervostan";
    })
    (lib.mkIf pkgs.stdenv.isLinux {
      home = "/home/peter";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "dialout" ];
    })
  ];
}
