{ pkgs, ... }:
{
  systemd.user.services.cliphist = {
    Unit = {
      Description = "clipboard history service";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
