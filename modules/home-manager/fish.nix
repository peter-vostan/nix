{ ... }: {
  programs = {
    fish.enable = true;

    # Enable the `starship` prompt.
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        hostname.ssh_only = false;
      };
    };

    # Provide suggestions when a binary isn't found.
    nix-index.enable = true;
  };
}
