{
    description = "Basic flake with mkDerivation";
    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs";
        };
        flake-parts = { url = "github:hercules-ci/flake-parts"; inputs.nixpkgs-lib.follows = "nixpkgs"; };
        flake-utils = { url = "github:numtide/flake-utils"; };
    };
    outputs = {self, nixpkgs, flake-utils, ...}:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = nixpkgs.legacyPackages.${system};
            in
            {   # nix develop
                # defaultPackage = pkgs.mkShell { #create a new shell with hook > compiles main.rs as run ./main
                #                                 buildInputs = [ pkgs.cargo pkgs.rustc ];
                #                                 inputsFrom = [ ];
                #                                 shellHook = ''
                #                                     export DEBUG=1
                #                                     rustc main.rs
                #                                     ./main
                #                                     rm main
                #                                 '';
                #                               };
                packages.default = pkgs.stdenv.mkDerivation #nix run
                    {
                        name = "main";
                        builder = "${pkgs.bash}/bin/bash";
                        args = [ ./builder.sh ];
                        inherit (pkgs) rustc coreutils cargo;
                        src = ./.;
                        system = builtins.currentSystem;
                        PATH = "${pkgs.coreutils}/bin:${pkgs.rustc}/bin:${pkgs.gcc}/bin";
                    };
            });
}
