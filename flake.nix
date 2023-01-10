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
          dplyr
          tidyr
          purrr
          ggplot2
          lubridate
          janitor
          fs
          glue
          quarto
          vars
          stargazer
          ipeadatar
          deflateBR
        ];
      };
    in {
      devShell."${system}" = pkgs.mkShell {
        buildInputs = with pkgs; [
          bashInteractive
          coreutils
          git
          which
          curl
          pandoc
          quarto
          renv
          direnv
        ];
      };
    };
}
