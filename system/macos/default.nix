{ pkgs, ... }: {

  # https://github.com/LnL7/nix-darwin

  imports = [
    ../default.nix
    ./pam.nix # pam.enableSudoTouchIdAuth = true;
  ];

  # Should this be added to home-manager instead??
  # Rectangle should ideally be started automatically
  nixpkgs.overlays = [ (import ./overlays/apps.nix) ];
  environment.systemPackages = with pkgs; [
    Docker
    Rectangle
  ];

  # Currently requiring manual setup
  # MS Edge: for Teams / Outlook PWA (only nice way to use on M1 at present)

  # https://github.com/LnL7/nix-darwin/tree/master/modules/system/defaults
  system = {
    stateVersion = 4; # macOS (`nix-darwin`) verison.
    defaults = {
      screencapture = { location = "/tmp"; };
      dock = {
        autohide = true;
        showhidden = true;
        mru-spaces = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = true;
      };
    };
    # https://github.com/LnL7/nix-darwin/blob/master/modules/system/keyboard.nix
    keyboard = {
      enableKeyMapping = true;
      userKeyMapping = [
        {
          HIDKeyboardModifierMappingSrc = 30064771299; # Left command
          HIDKeyboardModifierMappingDst = 30064771296; # Left control
        }
        {
          HIDKeyboardModifierMappingSrc = 30064771296; # Left control
          HIDKeyboardModifierMappingDst = 30064771299; # Left command
        }
      ];
    };
  };

  # https://github.com/LnL7/nix-darwin/tree/master/modules/environment
  environment = {
    shells = [ pkgs.fish ]; # Add additional allowed shells. Set using `chsh -s /run/current-system/sw/bin/fish`.
  };

  # https://github.com/LnL7/nix-darwin/tree/master/modules/programs
  programs = {
    zsh.enable = true; # Enable zsh otherwise things break.
  };

  # https://github.com/LnL7/nix-darwin/tree/master/modules/environment
  security = {
    pam.enableSudoTouchIdAuth = true;
  };

  # https://github.com/LnL7/nix-darwin/tree/master/modules/services
  services = {
    # Enable the Nix build daemon.
    nix-daemon.enable = true;
  };
}
