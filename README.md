# nixos config
my experimental semi-dendritic nixos config :3

## how to have it
1. remove my machines from `hosts/` and `secrets/`
2. set your timezone, locale and username in `hosts/common/user.nix`
3. make a new directory in `hosts/` with the name you want for your hostname
4. put your `hardware-configuration.nix` in the directory (you can leave it as-is or rename it to `hardware.nix` to match my style)
5. run `git add .` so Nix can see the new files inside the flake sandbox
5. rebuild or install your system, passing the flake as `[flake path]#[hostname]`
6. profit!
