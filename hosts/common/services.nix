{ pkgs, lib, ... }:
{
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet} --time --remember --asterisks --remember-user-session --cmd niri-session";
          user = "greeter";
        };
      };
    };

    openssh.enable = true;
    mullvad-vpn.enable = true;
  };
}
