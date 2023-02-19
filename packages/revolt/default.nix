{ stdenv
, lib
, fetchurl
, appimageTools
, makeWrapper
, electron
}:

stdenv.mkDerivation rec {
  pname = "revolt-desktop";
  version = "1.0.6";

  src = fetchurl {
    url = "https://github.com/revoltchat/desktop/releases/download/v${version}/Revolt-linux.AppImage";
    sha256 = "sha256-Wsm6ef2Reenq3/aKGaP2yzlOuLKaxKtRHCLLMxvWUUY=";
  };

  appimageContents = appimageTools.extractType2 {
    name = "${pname}-${version}";
    inherit src;
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/{applications,${pname}}

    cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
    cp -a ${appimageContents}/revolt-desktop.desktop $out/share/applications/${pname}.desktop
    cp -a ${appimageContents}/usr/share/icons $out/share

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/share/${pname}/resources/app.asar
  '';

  meta = {
    description = "An open source user-first chat platform";
    homepage = "https://revolt.chat/";
    changelog = "https://github.com/revoltchat/desktop/compare/v1.0.5...v1.0.6";
    license = lib.licenses.agpl3Only;
    maintainers = [ lib.maintainers.heyimnova ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "revolt-desktop";
  };
}
