{ pkgs, lib, ... }: {
  # Awful hack since `home-manager` isn't symliking apps properly on macOS.
  # See: https://github.com/nix-community/home-manager/issues/1341.
  home.activation = {
    copyApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      appsSrc="$newGenPath/home-path/Applications/"
      baseDir="$HOME/Applications/Home Manager"
      rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
      $DRY_RUN_CMD mkdir -p "$baseDir"
      $DRY_RUN_CMD ${pkgs.rsync}/bin/rsync ''${VERBOSE_ARG:+-v} $rsyncArgs "$appsSrc" "$baseDir"
    '';
  };
}
