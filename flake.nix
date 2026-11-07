{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (pkgs: rec {
      ansible-recap = pkgs.callPackage ./package.nix {};
      default = ansible-recap;
    });

    overlays.default = final: _prev: {
      ansible-recap = self.packages.${final.stdenv.hostPlatform.system}.ansible-recap;
    };
  };
}
