{ ... }: {
  users.users.opeik = {
    home = "/home/opeik";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
