{ ... }:
{
  programs.caelestia = {
    enable = true;
    systemd.enable = false;
    settings = {
      paths.wallpaperDir = "~/pictures/wallpapers";
      services.showLyrics = false;
    };
    cli.enable = true;
  };
}
