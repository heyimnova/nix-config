{ stdenv
, lib
, fetchurl
, autoPatchelfHook
, dpkg
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "quickgui";
  version = "1.2.8";

  src = fetchurl {
    url = "https://github.com/quickemu-project/quickgui/releases/download/v1.2.8/quickgui_1.2.8-1_lunar1.0_amd64.deb";
    sha256 = "sha256-crnV7OWH5UbkMM/TxTIOlXmvqBgjFmQG7RxameMOjH0=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
  ];

  buildInputs = [
    wrapGAppsHook
  ];

  unpackCmd = "dpkg-deb -x $curSrc source";

  installPhase = ''
    runHook preInstall
    
    mv usr $out

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace "Exec=/usr/bin/quickgui" "Exec=${pname}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "A Flutter frontend for quickemu";
    homepage = "https://github.com/quickemu-project/quickgui";
    maintainers = [ maintainers.heyimnova ];
    platforms = platforms.linux;
  };
}
