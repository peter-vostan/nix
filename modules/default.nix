{ pkgs, lib, system, ... }: {
  imports = [ ./user.nix ];

  nix = {
    # Use flakes for **maximum hermeticism**.
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
      # Uses more disk space but speeds up nix-direnv.
      keep-derivations = true
      keep-outputs = true
    '';
    # Automatically collect garbage.
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  # Allow proprietary packages.
  nixpkgs.config.allowUnfree = true;
  # System-wide packages.
  environment.systemPackages = with pkgs; [
    unstable.gnomeExtensions.dash-to-dock # Makes gnome *usable*
  ];

  # Setup `home-manager`.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.opeik.imports = [ ../home ];
  };

  # Integrate with shells.
  programs = {
    zsh.enable = true;
    fish.enable = true;
  };
}
