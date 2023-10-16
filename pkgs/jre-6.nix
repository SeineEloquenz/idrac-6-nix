{ lib
, stdenv
, buildFHSUserEnv
, runCommand
, autoPatchelfHook
, alsa-lib, libX11, libXext, libXi, libXt, libXtst, libXrender, freetype, liberation_ttf, fontconfig
}:
stdenv.mkDerivation {
  name = "idrac-6-jre";
  src = builtins.fetchTarball {
    url = "https://cdn.azul.com/zulu/bin/zulu7.56.0.11-ca-jdk7.0.352-linux_x64.tar.gz";
    sha256 = "15xb1ahnqjmmi7688rspd8aqsqh9qcyfjqdj4yi2q2n9yk920rq3";
  };

  buildInputs = [
    autoPatchelfHook
    alsa-lib
    libX11
    libXext
    libXi
    libXt
    libXtst
    libXrender
    freetype
    liberation_ttf
    fontconfig
  ];

  # Adapation for https://github.com/NixOS/nixpkgs/pull/209870;
  # something similar will go upstream in nixpkgs for all
  # autoPatchelfHook users.  When it does, this can be dropped.
  preFixup = lib.optionalString (stdenv?cc.cc.libgcc) ''
    addAutoPatchelfSearchPath ${stdenv.cc.cc.libgcc}/lib
  '';

  installPhase = ''
    mkdir -p $out/jre/lib/fonts
    cp -r $src/* $out
    # Link fallback font
    ln -s ${liberation_ttf}/share/fonts/truetype $out/jre/lib/fonts/fallback
  '';
}
