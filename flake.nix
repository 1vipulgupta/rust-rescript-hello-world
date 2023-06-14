{
    description = "Will it work";
    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs";
        };
        flake-parts = { url = "github:hercules-ci/flake-parts"; inputs.nixpkgs-lib.follows = "nixpkgs"; };
        flake-utils = { url = "github:numtide/flake-utils"; };
    };
    outputs = {self, nixpkgs, ...}: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    # inputs.flake-parts.lib.mkFlake { inherit inputs; }
    {
        foo = "bar";
        packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
        packages.x86_64-linux.default = self.packages.x86_64-linux.hello; #need to point it to rust, so can build rust by default.
        # devShells.default = nixpkgs.mkShell {
        #     packages = [ pkgs.rustc pkgs.coreutils ];

        #     inputsFrom = [ ];

        #     shellHook = ''
        #         export DEBUG=1
        #         rustc hello.rs
        #     '';
        # };
    };
}
