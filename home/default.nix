{ ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.peter.imports = [ ./config ];
  };
}
