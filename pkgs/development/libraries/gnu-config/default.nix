{ stdenv, fetchurl }:

let
  rev = "6a82322dd05cdc57b4cd9f7effdf1e2fd6f7482b";

  # Don't use fetchgit as this is needed during Aarch64 bootstrapping
  configGuess = fetchurl {
    url = "http://git.savannah.gnu.org/cgit/config.git/plain/config.guess?id=${rev}";
    sha256 = "1yj9yi94h7z4z6jzickddv64ksz1aq5kj0c7krgzjn8xf8p3avmh";
  };
  configSub = fetchurl {
    url = "http://git.savannah.gnu.org/cgit/config.git/plain/config.sub?id=${rev}";
    sha256 = "1qsqdpla6icbzskkk7v3zxrpzlpqlc94ny9hyy5wh5lm5rwwfvb7";
  };
in
stdenv.mkDerivation rec {
  name = "gnu-config-${version}";
  version = "2016-12-31";

  buildCommand = ''
    mkdir -p $out
    cp ${configGuess} $out/config.guess
    cp ${configSub} $out/config.sub
  '';

  meta = with stdenv.lib; {
    description = "Attempt to guess a canonical system name";
    homepage = https://savannah.gnu.org/projects/config;
    license = licenses.gpl3;
    # In addition to GPLv3:
    #   As a special exception to the GNU General Public License, if you
    #   distribute this file as part of a program that contains a
    #   configuration script generated by Autoconf, you may include it under
    #   the same distribution terms that you use for the rest of that
    #   program.
    maintainers = [ maintainers.dezgeg ];
    platforms = platforms.all;
  };
}
