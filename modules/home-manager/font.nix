{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  packages = with pkgs; [
    julia-mono
    (nerdfonts.override {
      fonts = [ "FiraCode" "Meslo" ];
    })
  ];
}
