{ pkgs }:

pkgs.symlinkJoin {
  name = "helium-wayland";
  paths = [ pkgs.nur.repos.Ev357.helium ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/helium \
      --add-flags "--ozone-platform=wayland" \
      --add-flags "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
  '';

  meta.mainProgram = "helium";
}
