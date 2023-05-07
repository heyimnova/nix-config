{ stdenv
, lib
, fetchFromGitHub
, perl
, perl536Packages
, clamav
}:

stdenv.mkDerivation rec {
  pname = "clamtk";
  version = "6.15";

  src = fetchFromGitHub {
    owner = "dave-theunsub";
    repo = "clamtk";
    rev = "178c5f3d9ec6d6e7745f7741fa16a2df1e7e8335";
    sha256 = "sha256-VDZ4ipQyyAp2vtzPmy7uVDM2a9gzSgKCI33zeU7uj9k=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,share/{perl5/vendor_perl/ClamTk,pixmaps,applications}}
    mv lib/*.pm $out/share/perl5/vendor_perl/ClamTk
    mv images/* $out/share/pixmaps
    mv clamtk.desktop $out/share/applications
    chmod +x clamtk
    mv clamtk $out/bin

    # Manually add Perl libraries and fix FHS paths
    substituteInPlace $out/bin/clamtk \
      --replace "/usr" ${perl} \
      --replace "use utf8;" "use utf8;
    use lib '$out/share/perl5/vendor_perl';
    use lib '${perl536Packages.Glib}/lib/perl5/site_perl/5.36.0/x86_64-linux-thread-multi';
    use lib '${perl536Packages.LWP}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.HTTPMessage}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.URI}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.HTTPDate}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.TryTiny}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.LWPProtocolHttps}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.NetHTTP}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.IOSocketSSL}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.NetSSLeay}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.TextCSV}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.JSON}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.LocaleGettext}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.Gtk3}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.CairoGObject}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.Cairo}/lib/perl5/site_perl/5.36.0';
    use lib '${perl536Packages.GlibObjectIntrospection}/lib/perl5/site_perl/5.36.0';"

    substituteInPlace $out/share/perl5/vendor_perl/ClamTk/Analysis.pm \
      $out/share/perl5/vendor_perl/ClamTk/App.pm \
      $out/share/perl5/vendor_perl/ClamTk/Assistant.pm \
      $out/share/perl5/vendor_perl/ClamTk/GUI.pm \
      --replace "/usr/bin/clamtk" $out/bin/clamtk \
      --replace "/usr/share/pixmaps" $out/share/pixmaps \
      --replace "/usr/bin" "${clamav}/bin"

    runHook postInstall
  '';

  meta = {
    description = "A frontend for ClamAV";
    longDescription = "ClamTk is a frontend for ClamAV (Clam Antivirus). It is intended to be an easy to use, light-weight, on-demand scanner for Linux systems. 
    Please note that the ClamTk scheduler will not work on NixOS due to how it uses cron.";
    homepage = "https://gitlab.com/dave_m/clamtk/-/wikis/home";
    changelog = "https://github.com/dave-theunsub/clamtk/blob/v${version}/CHANGES";
    license = lib.licenses.gpl1Plus;
    maintainers = [ lib.maintainers.heyimnova ];
    platforms = lib.platforms.linux;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
    mainProgram = "clamtk";
  };
}
