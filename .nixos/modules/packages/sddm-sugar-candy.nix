{ pkgs } :
let
  imgLink = "https://raw.githubusercontent.com/sirDonVua/wallpapers/main/14.jpg";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-O+pfjVo/dym8aMZGspGKUdGwEbdJ3J9Aq6JLJtz8l58=";
  };
in

pkgs.stdenv.mkDerivation{
  name = "sddm-sugar-candy";
  src = pkgs.fetchFromGitHub {
    owner = "Kangie";
    repo = "sddm-sugar-candy";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
'';

}
