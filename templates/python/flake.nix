{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    flake-utils.url = "github:numtide/flake-utils";

    mach-nix.url = "mach-nix/3.4.0";
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # OPTION 1 : Python environment via withPackages
        pythonEnv = pkgs.python3.withPackages
          (ps: with ps; [ pillow numpy requests ]);

        # OPTION 2 : use mach-nix (UNTESTED)
        # https://github.com/DavHau/mach-nix/blob/master/examples.md
        pythonEnv_MachNix = mach-nix.lib."${system}".mkPython
          {
            requirements = ''
              pillow
              numpy
              requests
            '';
          };

        # OPTION 3: Build python package directly if not available in nixpkgs
        empy = with pkgs.python3Packages; buildPythonPackage rec {
          pname = "empy";
          version = "3.3.4";
          src = fetchPypi {
            inherit pname version;
            sha256 = "1cq1izl6l87i5i3vj0jcqfksh10kpiwpr2m19vgpj530bdw4kb3k";
          };
          doCheck = false;
        };
      in
      rec
      {
        # `nix develop`
        devShell = with pkgs; mkShell ({
          buildInputs = [
            pythonEnv # Defined in let above
            pythonEnv_MachNix # Defined in let above

            empy # Built within the let statement above

            # OPTION 4: Python packages from nixpkgs.python3Packages
            python3
            (with pkgs.python3Packages; [
              numpy
              future
            ])
          ];
        });
      }
    );
}
