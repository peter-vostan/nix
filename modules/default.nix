{ pkgs, ... }: {
  imports = [ ./user.nix ];

  # Use flakes for **maximum hermeticism**.
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
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
