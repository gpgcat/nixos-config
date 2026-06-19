{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ayugram-desktop
    vesktop-wayland
    helium-wayland

    yazi
    fzf
    wl-clipboard

    nerd-fonts.jetbrains-mono
  ];
}
