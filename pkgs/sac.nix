{ stdenv, lib, makeWrapper, fetchurl, pcsclite, glib, gnome2, atk, gdk_pixbuf,
  cairo, freetype, fontconfig }:
stdenv.mkDerivation rec {
  name = "sac-core-${version}";
  version = "9.1";

  src = /home/anton/tmp/sac/sac.deb;
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
