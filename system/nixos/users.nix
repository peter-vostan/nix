{ pkgs, ... }: {
  home-manager.users.peter = {
    imports = [
      ../../home/default.nix
      ../../home/fish.nix
      ../../home/git.nix
      ../../home/ssh.nix
      ../../home/vscode.nix
    ];
  };

  users.users.peter = {
    home = "/home/peter";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "dialout" ];
  };
}
