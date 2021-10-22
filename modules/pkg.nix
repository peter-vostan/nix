{ pkgs, ... }: {
  # System-wide packages.
  environment.systemPackages = with pkgs; [
    fish
    git
    vim
  ];
}
