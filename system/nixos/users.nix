{ pkgs, ... }: {
  users.users.peter = {
    shell = pkgs.fish;
    home = "/home/peter";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };
}
