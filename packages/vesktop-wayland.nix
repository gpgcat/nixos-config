{ pkgs }:

pkgs.symlinkJoin {
  name = "vesktop-wayland";
  paths = [ pkgs.vesktop ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/vesktop \
      --add-flags "--ozone-platform=wayland" \
      --add-flags "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
  '';
}
