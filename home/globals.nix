{ ... }:
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
  };

  home.sessionVariables = sessionVariables;
  systemd.user.sessionVariables = sessionVariables;
}
