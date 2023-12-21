{
  description = "A flake for building flameshot";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "flameshot";
        src = self;
        nativeBuildInputs = [
          #pkg-config

          cmake
          qt5.wrapQtAppsHook
          #libsForQt5.qt5.qmake
        ];
        cmakeFlags = [
          "-DUSE_WAYLAND_GRIM=true"
        ];
        buildInputs = [
          ## put the real dependencies here
          qt5.full
          libsForQt5.qt5.qtwayland

          # libsamplerate
          # libsndfile
          # fftw
        ];
        #buildPhase = "make -j $NIX_BUILD_CORES"
        shellHook = ''
          export PS1="(devenv) $PS1"
        '';
      };

  };
}
