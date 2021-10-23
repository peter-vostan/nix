{ pkgs, lib, ... }:
let
  user = {
    shell = pkgs.fish;
  };
  macosUser = {
    home = "/Users/opeik";
  };
  linuxUser = {
    home = "/home/opeik";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
in
{
  # Define users.
  users.users.opeik = user // (if pkgs.stdenv.isDarwin then macosUser else linuxUser);
}
