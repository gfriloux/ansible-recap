{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      src = ./.;

      snowfall = {
        namespace = "ansible-recap";
      };
      alias = {
        packages.default = "ansible-recap";
      };
    };

}
