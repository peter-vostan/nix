# copied from https://github.com/jwiegley/nix-config/blob/master/overlays/30-apps.nix

self: super:
let installApplication =
  { name
  , appname ? name
  , version
  , src
  , description
  , homepage
  , postInstall ? ""
  , sourceRoot ? "."
  , ...
  }:
    with super; stdenv.mkDerivation {
      name = "${name}-${version}";
      version = "${version}";
      src = src;
      buildInputs = [ undmg unzip ];
      sourceRoot = sourceRoot;
      phases = [ "unpackPhase" "installPhase" ];
      installPhase = ''
        mkdir -p "$out/Applications/${appname}.app"
        cp -pR * "$out/Applications/${appname}.app"
      '' + postInstall;
      meta = with super.lib; {
        description = description;
        homepage = homepage;
        maintainers = with maintainers; [ ];
        platforms = platforms.darwin;
      };
    };
in
{
  Docker = installApplication rec {
    name = "Docker";
    version = "4.4.2";
    sourceRoot = "Docker.app";
    src = super.fetchurl {
      url = https://desktop.docker.com/mac/main/arm64/Docker.dmg;
      sha256 = "gVuxll6U9tfzEs0gBGpNvQfz2xljFVfeHUlXAt3CmM0=";
    };
    description = ''
      Docker CE for Mac is an easy-to-install desktop app for building,
      debugging, and testing Dockerized apps on a Mac
    '';
    homepage = https://docs.docker.com/desktop/mac/apple-silicon/;
  };

  Rectangle = installApplication rec {
    name = "Rectangle";
    version = "0.50";
    sourceRoot = "Rectangle.app";
    src = super.fetchurl {
      url = https://github.com/rxhanson/Rectangle/releases/download/v0.50/Rectangle0.50.dmg;
      sha256 = "sTI3IXldokAXNqYLMARy0NbGcn9QcpktJ+eUMVVWRnw=";
    };
    description = ''
      Move and resize windows in macOS using keyboard shortcuts or snap areas
    '';
    homepage = https://rectangleapp.com;
  };
}
