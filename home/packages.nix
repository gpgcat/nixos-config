{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ayugram-desktop
    helium-wayland

    yazi
    fzf
  ];
}
