{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ayugram-desktop
    helium-wayland

    yazi
    fzf
    wl-clipboard

    nerd-fonts.jetbrains-mono
  ];
}
