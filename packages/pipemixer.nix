{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "pipemixer";
  version = "0.5.1";

  src = pkgs.fetchFromGitHub {
    owner = "heather7283";
    repo = "pipemixer";
    rev = "v${version}";
    hash = "sha256-dVw8x9c3DFSL5eLbBOe7ExNzeKsj3xB5Spl516XFqTQ=";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
  ];

  buildInputs = with pkgs; [
    inih
    ncurses
    pipewire
  ];

  meta = with pkgs.lib; {
    description = "an ncurses-based tui mixer for pipewire";
    homepage = "https://github.com/heather7283/pipemixer";
    license = licenses.gpl3Only;
    mainProgram = "pipemixer";
    platforms = platforms.linux;
  };
}
