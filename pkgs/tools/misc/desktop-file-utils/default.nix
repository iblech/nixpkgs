{ stdenv, fetchurl, pkgconfig, glib, libintlOrEmpty }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "desktop-file-utils-0.22";

  src = fetchurl {
    url = "http://www.freedesktop.org/software/desktop-file-utils/releases/${name}.tar.xz";
    sha256 = "1ianvr2a69yjv4rpyv30w7yjsmnsb23crrka5ndqxycj4rkk4dc4";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ glib libintlOrEmpty ];

  NIX_LDFLAGS = optionalString stdenv.isDarwin "-lintl";

  meta = {
    homepage = https://www.freedesktop.org/wiki/Software/desktop-file-utils;
    description = "Command line utilities for working with .desktop files";
    platforms = platforms.linux ++ platforms.darwin;
  };
}
