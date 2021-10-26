{ pkgs, lib, ... }: {
  # Define users.
  users.users.opeik = lib.mkMerge [
    {
      shell = pkgs.fish;
    }
    (lib.mkIf pkgs.stdenv.isDarwin {
      home = "/Users/opeik";
    })
    (lib.mkIf pkgs.stdenv.isLinux {
      home = "/home/opeik";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    })
  ];
}
