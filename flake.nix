{
    description = "Will it work";
    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs";
        };
        # flake-parts = { url = "github:hercules-ci/flake-parts"; inputs.nixpkgs-lib.follows = "nixpkgs"; };
        flake-utils.url = "github:numtide/flake-utils";
    };
    outputs = {self, inputs}: let
    pkgs = inputs.nixPkgs.legacyPackages.x86_64-linux;
    in
    # inputs.flake-parts.lib.mkFlake { inherit inputs; }
    {
        foo = "bar";
        # devShells.default = inputs.nixPkgs.mkShell {
        #     packages = [ pkgs.rustc pkgs.coreutils ];

        #     inputsFrom = [ ];

        #     shellHook = ''
        #         export DEBUG=1
        #         rustc hello.rs
        #     '';
        # };
    };
}