{ ... }:
{
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    openssh.enable = true;
    mullvad-vpn.enable = true;
  };
}
