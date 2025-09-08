{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    outputs = { self, nixpkgs }: {
        devShell.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.mkShell {
            buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
                hugo
            ];
        };
    };
}
