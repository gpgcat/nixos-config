{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ayugram-desktop
    vesktop-wayland
    helium-wayland
    waybar

    yazi
    awww
    fzf
    wl-clipboard

    nerd-fonts.jetbrains-mono
  ];
}
