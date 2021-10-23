{ pkgs, ... }: {
  imports = [ ./user.nix ];

  # Use flakes for **maximum hermeticism**.
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Allow proprietary packages.
  nixpkgs.config.allowUnfree = true;

  # Setup `home-manager`.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.opeik.imports = [ ./home-manager ];
  };

  # System-wide packages.
  environment.systemPackages = with pkgs; [ ];

  # Shell integration.
  programs = {
    zsh.enable = true;
    fish.enable = true;
  };
}
