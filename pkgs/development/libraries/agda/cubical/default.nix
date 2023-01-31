{ lib, mkDerivation, fetchFromGitHub, ghc }:

mkDerivation rec {
  pname = "cubical";
  version = "0.5prea010f7";

  src = fetchFromGitHub {
    repo = pname;
    owner = "agda";
    rev = "a010f731b441f453af3aad3cd0ee6598bca07c5f";
    hash = "sha256-x3of0gKZ7i5TOo0Q4Mj0CYY0CO0kgFN9b/vHcuRfiP0=";
  };

  # The cubical library has several `Everything.agda` files, which are
  # compiled through the make file they provide.
  nativeBuildInputs = [ ghc ];
  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  meta = with lib; {
    description =
      "A cubical type theory library for use with the Agda compiler";
    homepage = src.meta.homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ alexarice ryanorendorff ncfavier ];
  };
}
