{ pkgs, ... }: {
  # Define users.
  users = {
    users.opeik = {
      shell = pkgs.fish;
    };
  };
}
