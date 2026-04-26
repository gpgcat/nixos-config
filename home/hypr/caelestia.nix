{ ... }:
{
  programs.caelestia = {
    enable = true;
    systemd.enable = false;
    settings = {
      paths.wallpaperDir = "~/pictures/wallpapers";
    };
    cli.enable = true;
  };
}
