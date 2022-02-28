# Non-Nix macOS apps
{ pkgs, lib, ... }:
let
  # Makes a Nix package from a macOS app
  pkgFromApp =
    { name
    , appName ? name
    , version
    , src
    , description
    , homepage
    , buildInputs ? [ ]
    , unpackPhase ? ""
    , postInstall ? ""
    , sourceRoot ? "${appName}.app"
    , ...
    }:
    pkgs.stdenv.mkDerivation {
      name = "${name}-${version}";
      version = "${version}";
      inherit src;
      inherit sourceRoot;
      buildInputs = with pkgs; [ undmg unzip ] ++ buildInputs;
      phases = [ "unpackPhase" "installPhase" ];
      inherit unpackPhase;
      installPhase = ''
        mkdir -p "$out/Applications/${appName}.app"
        cp -pR * "$out/Applications/${appName}.app"
      '' + postInstall;
      meta = with lib; {
        inherit description;
        inherit homepage;
        maintainers = with maintainers; [ ];
        platforms = platforms.darwin;
      };
    };

  chromium = pkgFromApp rec {
    name = "Chromium";
    version = "101.0.4904.0";
    revision = "973630";
    sourceRoot = "chrome-mac/Chromium.app";
    src = builtins.fetchurl {
      url = "https://storage.googleapis.com/chromium-browser-snapshots/Mac_Arm/${revision}/chrome-mac.zip";
      sha256 = "16qk18xydaf69xwz5shdz3p4h4ggrcgcmman3dhd2xbhnksf1cgd";
    };
    description = "Chromium web browser";
    homepage = "https://chromium.org";
  };

  docker-desktop = pkgFromApp rec {
    name = "Docker";
    version = "4.5.0";
    revision = "74594";
    src = builtins.fetchurl {
      url = "https://desktop.docker.com/mac/main/arm64/${revision}/Docker.dmg";
      sha256 = "0161vncg3aq1xlakr0wxsw3lnbxjxc8frqrv6lx9h9cr8rwz7sr4";
    };
    description = "Docker desktop client";
    homepage = "https://docker.com";
  };

  fig = pkgFromApp rec {
    name = "Fig";
    version = "1.0.55";
    revision = "383";
    src = builtins.fetchurl {
      name = "fig-${version}.dmg";
      url = "https://versions.withfig.com/fig%20${revision}.dmg";
      sha256 = "0y2njjwqvli4vj6sxwmsri0ckj8wja36r6gdwkxdfagmyyvmiay4";
    };
    description = "Terminal autocompletion";
    homepage = "https://fig.io";
  };

  mos = pkgFromApp rec {
    name = "Mos";
    version = "3.3.2";
    src = builtins.fetchurl {
      url = "https://github.com/Caldis/Mos/releases/download/${version}/Mos.Versions.${version}.dmg";
      sha256 = "1n6bfwp3jg0izr5ay8li7mp23j9win775a4539z4b4604a8bpy2z";
    };
    description = "Mouse improvements";
    homepage = "https://mos.caldis.me";
  };

  rectangle = pkgFromApp rec {
    name = "Rectangle";
    version = "0.51";
    src = builtins.fetchurl {
      url = "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
      sha256 = "1fx5ndyhyrxs98n9rp5wzr3rz1gvz08iccyibq4kq7s76i31w37d";
    };
    description = "Window snapping and management";
    homepage = "https://rectangleapp.com";
  };

  yubico-authenticator = pkgFromApp rec {
    name = "Yubico-Authenticator";
    appName = "Yubico Authenticator";
    version = "5.1.0";
    src = builtins.fetchurl {
      url = "https://developers.yubico.com/yubioath-desktop/Releases/yubioath-desktop-${version}-mac.pkg";
      sha256 = "1iaq6z4fy0icrzmm41bici9jpyp8dlm0hj3sc0jbdk9b3rw6b3zp";
    };
    description = "Yubico TOTP generator";
    homepage = "https://www.yubico.com/products/yubico-authenticator";
    buildInputs = with pkgs; [ libarchive p7zip ];
    unpackPhase = ''
      7z x $src
      bsdtar -xf Payload~
    '';
  };
in
{
  # Install non-Nix macOS apps
  home.packages = [
    # chromium
    docker-desktop
    fig
    # mos
    rectangle
    # yubico-authenticator
  ];
}
