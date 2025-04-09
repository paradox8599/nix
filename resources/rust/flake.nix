{
  description = "A proxy server that handles rotation of socks5 proxies and auth tokens for LLM providers.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
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
        name = "lift-proxy";
        version = "0.1.0";

        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };

        nightly = false;
        extensions = [
          "clippy"
          "rustfmt"
          "rust-src"
          "rust-docs"
          "rust-analyzer"
        ];

        rustToolchain =
          if nightly then
            pkgs.rust-bin.selectLatestNightlyWith (
              toolchain: toolchain.default.override { inherit extensions; }
            )
          else
            pkgs.rust-bin.stable."1.85.0".default.override {
              inherit extensions;
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
            pkgs.openssl
            pkgs.pkg-config
            pkgs.cargo-shuttle
            pkgs.sqlx-cli
          ];

          shellHook = '''';
        };

        packages.default = rustPlatform.buildRustPackage {
          pname = name;
          inherit version;
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;

          nativeBuildInputs = [
            pkgs.pkg-config
          ];

          buildInputs = [
            pkgs.openssl
          ];
        };

        nixConfig = {
          extra-substituters = [
            "https://paradox8599.cachix.org"
          ];
          extra-trusted-public-keys = [
            "paradox8599.cachix.org-1:FSZWbtMzDFaWlyF+hi3yCl9o969EQkWnh33PTgnwNEg="
          ];
        };
      }
    );
}
