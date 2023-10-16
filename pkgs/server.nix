{ stdenv
, jre6
, idrac
, makeDesktopItem
, idracOptions
, ...}:
let

  mkDesktop = idracOptions: makeDesktopItem {
    name = "iDRAC ${idracOptions.secret}";
    exec = "iDRAC-${idracOptions.secret}";
    comment = "Virtual Console for iDRAC based dell management controllers";
    desktopName = "iDRAC ${idracOptions.secret}";
    categories = [ "System" ];
    icon = ../src/share/icons/dell-logo.png;
  };

in stdenv.mkDerivation {
  name = "idrac-6";
  src = ../src;

  installPhase = ''
    mkdir -pv $out/share $out/bin
    cat <<EOT >> $out/bin/iDRAC-${idracOptions.secret}
    ${jre6}/bin/java -cp ${idrac}/share/java/avctKVM.jar com.avocent.idrac.kvm.Main -Djava.security.debug=properties -Djava.library.path=${idrac}/lib -Djava.security.properties==${idrac}/share/java/java.security ip=${idracOptions.host} kmport=${idracOptions.port} vport=${idracOptions.port} user=${idracOptions.user} passwd="\$(< ${idracOptions.pwFile})" apcp=1 version=2 vmprivilege=true "helpurl=https://${idracOptions.host}:443/help/contents.html"
    EOT

    chmod +x $out/bin/iDRAC-${idracOptions.secret}
    ln -s ${mkDesktop idracOptions}/share/applications $out/share/applications
  '';
}
