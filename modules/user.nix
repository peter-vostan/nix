{ pkgs, lib, ... }: {
  # Define users.
  users.users.peter = lib.mkMerge [
    {
      shell = pkgs.fish;
    }
    (lib.mkIf pkgs.stdenv.isDarwin {
      home = "/Users/peter";
    })
    (lib.mkIf pkgs.stdenv.isLinux {
      home = "/home/peter";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    })
  ];
}
