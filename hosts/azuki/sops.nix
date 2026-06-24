{ inputs, flakeRoot, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = flakeRoot + /secrets/azuki.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      singbox_ip = { };
      singbox_uuid = { };
      singbox_pubkey = { };
      singbox_shortid = { };
    };
  };
}
