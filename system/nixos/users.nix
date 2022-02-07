{ pkgs, lib, ... }: {
  home-manager.users.peter.imports = [ ../../home ];
  users.users.peter = {
    home = "/home/peter";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "dialout" ];
  };
}
