{ pkgs, ... }:
let
  sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXOS_OZONE_WL = "1";
  };
in
{
  home = {
    username = "madeline";
    homeDirectory = "/home/madeline";
    stateVersion = "26.05";

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Classic";
      size = 48;
      package = pkgs.bibata-cursors;
    };
  };

  home.sessionVariables = sessionVariables;
  systemd.user.sessionVariables = sessionVariables;
}
