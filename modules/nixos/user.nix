{ pkgs, ... }: {
  # Define users.
  users = {
    users.opeik = {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
}
