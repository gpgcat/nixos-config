{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ayugram-desktop
    vesktop
    helium-wayland

    yazi
    fzf
    wl-clipboard

    nerd-fonts.jetbrains-mono
  ];
}
