{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    limine-full
    neovim
    wget
    tree
    git
    home-manager
  ];

  fonts.packages = with pkgs; [
    inter
  ];

  programs = {
    niri.enable = true;
    fish.enable = true;
    nix-ld.enable = true;
    steam.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;

      direnvrcExtra = ''
        use_devenv() {
          eval "$(devenv direnvrc)"
          use devenv "$@"
        }
      '';
    };
  };
}
