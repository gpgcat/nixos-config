{ config, ... }:

{
  sops.templates."sing-box.json" = {
    owner = "sing-box";
    content = builtins.toJSON {
      log = {
        level = "warn";
      };
      dns = {
        servers = [
          {
            tag = "dns-remote";
            type = "udp";
            server = "8.8.8.8";
          }
        ];
      };
      inbounds = [
        {
          type = "tun";
          tag = "tun-in";
          interface_name = "tun0";
          address = [ "172.19.0.1/30" ];
          auto_route = true;
          strict_route = true;
          stack = "gvisor";
          auto_redirect = true;
        }
      ];
      outbounds = [
        {
          type = "vless";
          tag = "vless-out";
          server = config.sops.placeholder.singbox_ip;
          server_port = 443;
          uuid = config.sops.placeholder.singbox_uuid;
          packet_encoding = "xudp";
          flow = "xtls-rprx-vision";
          tls = {
            enabled = true;
            server_name = "www.max.ru";
            utls = {
              enabled = true;
              fingerprint = "chrome";
            };
            reality = {
              enabled = true;
              public_key = config.sops.placeholder.singbox_pubkey;
              short_id = config.sops.placeholder.singbox_shortid;
            };
          };
        }
        {
          type = "direct";
          tag = "direct-out";
        }
      ];
      route = {
        rules = [
          {
            action = "sniff";
          }
          {
            protocol = "dns";
            action = "hijack-dns";
          }
          {
            ip_is_private = true;
            action = "route";
            outbound = "direct-out";
          }
        ];
        auto_detect_interface = true;
        final = "vless-out";
      };
    };
  };

  services.sing-box.enable = true;

  systemd.services.sing-box = {
    wants = [ "sops-nix.service" ];
    after = [ "sops-nix.service" ];

    serviceConfig = {
      ExecStart = [
        ""
        "${config.services.sing-box.package}/bin/sing-box -D /var/lib/sing-box run -c ${
          config.sops.templates."sing-box.json".path
        }"
      ];
    };
  };
}
