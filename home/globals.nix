{ ... }:
let
  sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
in
  {
    home.username = "madeline";
    home.homeDirectory = "/home/madeline";
    home.stateVersion = "26.05";

    home.sessionVariables = sessionVariables;
    systemd.user.sessionVariables = sessionVariables;
  }
