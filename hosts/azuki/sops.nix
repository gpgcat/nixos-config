{ inputs, flakeRoot, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = toString flakeRoot + "/secrets/azuki.yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      placeholder = { }; # nothing to store yet lol
    };
  };
}
