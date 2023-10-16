{ lib
, stdenv
}:

stdenv.mkDerivation rec {
  name = "idrac-6";
  src = ../src;

  installPhase = ''
    mkdir -pv $out/share $out/bin $out/lib
    cp -r ${src}/lib $out
    cp -r ${src}/share $out
  '';

  meta = with lib; {
    description = "Virtual Console client for iDRAC 6 Dell Management Controllers";
    homepage = "https://github.com/vinceliuice/Orchis-theme";
    platforms = platforms.linux;
  };
}
