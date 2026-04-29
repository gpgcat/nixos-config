# nixos config
## how to deploy!! (impure deps)
- generate keys
```sudo nix run nixpkgs#sbctl create-keys```
- enroll keys and microslop oem certs
```sudo nix run nixpkgs#sbctl -- enroll-keys --microsoft```
- enroll full-disk encryption
```sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+7+12 /dev/nvme0n1p2```
