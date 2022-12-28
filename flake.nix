{
  description = "Time Series Analysis Project";
  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-22.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.unstable.legacyPackages.${system};
      renv = pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          tidyverse
          zip
          fs
          forecast
          lmtest
        ];
      };
    in {
      devShell."${system}" = pkgs.mkShell {
        buildInputs = with pkgs; [
          coreutils
          git
          glibcLocales
          which
          curl
          pandoc
          renv
        ];
        shellHook = ''
          mkdir -p "$(pwd)/_libs"
          export R_LIBS_USER="$(pwd)/_libs"
        '';
      };
    };
}
