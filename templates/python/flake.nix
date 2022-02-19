{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # OPTION 1 : Python environment via withPackages
        pythonEnv = pkgs.python3.withPackages
          (ps: with ps; [ numpy toolz ]);

        # OPTION 2: Build python package if not available in nixpkgs
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

            empy # Built within the let statement above

            # OPTION 3: Python packages from nixpkgs.python3Packages
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
