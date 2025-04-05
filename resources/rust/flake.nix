{
  description = "A rust project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      rust-overlay,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        name = "rust-project";
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rustToolchain = pkgs.rust-bin.stable."1.85.0".default.override {
          extensions = [
            "rust-analyzer"
            "clippy"
            "rustfmt"
          ];
        };
        rustPlatform = pkgs.makeRustPlatform {
          cargo = rustToolchain;
          rustc = rustToolchain;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          inherit name;
          buildInputs = [
            rustToolchain
            pkgs.pkg-config
            pkgs.openssl
          ];

          shellHook = '''';
        };

        packages.default = rustPlatform.buildRustPackage {
          pname = name;
          version = "0.1.0";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;

          nativeBuildInputs = [
            pkgs.pkg-config
          ];

          buildInputs = [
            pkgs.openssl
          ];
        };
      }
    );
}
