{ pkgs, ... }:

{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    defaultCacheTtl = 3600;
  };
}
