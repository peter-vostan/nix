{ pkgs, lib, ... }: {
  imports = [ ./user.nix ];

  nix = {
    # Use flakes for **maximum hermeticism**.
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      # Uses more disk space but speeds up nix-direnv.
      keep-keep-derivations = true
      keep-outputs = true
      # Trigger garbage collection when <= 1GB is free.
      min-free = ${toString (1000 * 1000 * 1000)}
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
  environment.systemPackages = with pkgs; [ ];

  # Setup `home-manager`.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.opeik.imports = [ ../home ];
  };

  # Integrate Nix with shells.
  programs = {
    zsh.enable = true;
    fish.enable = true;
  };
}
