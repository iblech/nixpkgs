{ stdenv, fetchsvn, autoconf, automake, libsndfile, libtool, pkgconfig, libuuid }:

stdenv.mkDerivation rec {
  name = "libgig-svn-${version}";
  version = "2334";

  src = fetchsvn {
    url = "https://svn.linuxsampler.org/svn/libgig/trunk";
    rev = "${version}";
    sha256 = "0i7sj3zm6banl5avjdxblx0mlbxxzbsbr4x5hsl2fhrdsv5dnxhc";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ autoconf automake libsndfile libtool libuuid ];

  preConfigure = "make -f Makefile.cvs";

  meta = with stdenv.lib; {
    homepage = https://www.linuxsampler.org;
    description = "Gigasampler file access library";
    license = licenses.gpl2;
    maintainers = [ maintainers.goibhniu ];
    platforms = platforms.linux;
  };
}
