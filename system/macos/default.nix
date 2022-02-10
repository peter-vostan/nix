{ pkgs, ... }: {

  # https://github.com/LnL7/nix-darwin

  imports = [
    ../default.nix
    ./users.nix
    ./pam.nix # pam.enableSudoTouchIdAuth = true;
  ];

  # Currently requiring manual setup
  # Edge: Teams / Outlook
  # Rectangle

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

    # skhd = {
    #   enable = true;
    #   package = pkgs.skhd;
    #   skhdConfig = ''
    #     # move window
    #     shift + cmd - h : chunkc tiling::window --warp west
    #     shift + cmd - j : chunkc tiling::window --warp south
    #     shift + cmd - k : chunkc tiling::window --warp north
    #     shift + cmd - l : chunkc tiling::window --warp east
    #     ctrl + alt - c : code
    #   '';
    # };

    # yabai = {
    #   enable = true;
    #   enableScriptingAddition = true;
    #   package = pkgs.yabai;
    #   config = {
    #     auto_balance = "on";
    #     layout = "bsp";
    #     bottom_padding = 48;
    #     left_padding = 18;
    #     right_padding = 18;
    #     top_padding = 18;
    #     window_gap = 18;
    #     mouse_follows_focus = "on";
    #     mouse_modifier = "fn";
    #     split_ratio = "0.50";
    #     window_placement = "second_child";
    #     window_topmost = "off";
    #     window_opacity = "off";
    #     window_shadow = "on";
    #     window_border = "off";
    #   };
    # };
  };
}
