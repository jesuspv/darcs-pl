# From https://ertt.ca/nix/shell-scripts/
{
  description = "git log --pretty mimic for darcs";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url     = "nixpkgs";

  outputs = { self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        bin  = pkgs.writeScriptBin name (builtins.readFile ./${name});
        name = "darcs-pl";
        path = bin.overrideAttrs(old: {
            buildCommand = "${old.buildCommand}\n patchShebangs $out";
            });
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        overlays.default  = self.overlays.${system}.${name};
        overlays.darcs-pl = final: prev: {
          darcs-pl = self.packages.${system}.default;
        };

        packages.default  = self.packages.${system}.${name};
        packages.darcs-pl = pkgs.symlinkJoin {
          name        = name;
          paths       = [ path pkgs.coreutils pkgs.gawk pkgs.darcs ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild   = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
        };
      }
    );
}
