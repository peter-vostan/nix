{ pkgs, ... }: {

  # https://github.com/LnL7/nix-darwin

  imports = [
    ./pam.nix # pam.enableSudoTouchIdAuth = true;
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ (import ./overlays/apps.nix) ];
  };

  nix = {
    package = pkgs.nix_2_4; # Needed for flake support
    extraOptions = ''
      experimental-features = nix-command flakes
      # Uses more disk space but speeds up nix-direnv.
      keep-derivations = true
      keep-outputs = true
      auto-optimise-store = true
    '';
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Currently requiring manual setup
  # MS Edge: for Teams / Outlook PWA (only nice way to use on M1 at present)

  # https://github.com/LnL7/nix-darwin/tree/master/modules/environment
  environment = {
    shells = [ pkgs.fish ]; # Add additional allowed shells. Set using `chsh -s /run/current-system/sw/bin/fish`.
    systemPackages = with pkgs; [
      Docker
      Rectangle
    ];
  };

  # https://github.com/LnL7/nix-darwin/tree/master/modules/system/defaults
  system = {
    stateVersion = 4; # macOS (`nix-darwin`) verison.
    defaults = {
      screencapture = { location = "/tmp"; };
      dock = {
        autohide = false;
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

  # https://github.com/LnL7/nix-darwin/tree/master/modules/programs
  programs = {
    zsh.enable = true;
    fish.enable = true;
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

  cachix = [
    { name = "nix-community"; sha256 = "00lpx4znr4dd0cc4w4q8fl97bdp7q19z1d3p50hcfxy26jz5g21g"; }
  ];
}
