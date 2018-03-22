{ stdenv, lib, makeWrapper, fetchurl, pcsclite, glib, gnome2, atk, gdk_pixbuf,
  cairo, freetype, fontconfig }:
stdenv.mkDerivation rec {
  name = "sac-core-${version}";
  version = "9.1";

  src = fetchurl {
    url = "http://share.kaliwe.ru/SafenetAuthenticationClient-9.1.7-0_amd64.deb";
    sha256 = "55523666636a163fc6f53f9456d94ecc3c29c5fa92481c6cbc1743c5b452bd53";
  };
  sourceRoot = ".";
  unpackCmd = ''
    ar p "$src" data.tar.gz | tar xz
  '';

  buildPhase = ":";   # nothing to build

  installPhase = ''
    mkdir -p $out/bin
    cp -R ./* $out/
  '';
  preFixup = let
    libPath = lib.makeLibraryPath [
      pcsclite
      glib
      gnome2.gtk
      gnome2.pango
      atk
      gdk_pixbuf
      cairo
      freetype
      fontconfig
      stdenv.cc.cc.lib
    ];
  in ''
    patchelf --set-rpath "${libPath}" $out/lib/libeToken.so.9.1.7
  '';
}
