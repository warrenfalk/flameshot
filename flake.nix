{
  description = "A flake for building flameshot";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "flameshot";
        version = "warrenfalk";
        src = self;
        nativeBuildInputs = [
          cmake
          qt5.wrapQtAppsHook
        ];
        cmakeFlags = [
          "-DUSE_WAYLAND_GRIM=true"
          "-DUSE_WAYLAND_GRIM_PATH=${grim}/bin/grim"
        ];
        buildInputs = [
          ## put the real dependencies here
          qt5.full
          libsForQt5.qt5.qtwayland
        ];
      };

  };
}
