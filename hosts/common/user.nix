{ pkgs, ... }:
{
  users.users.madeline = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
}
