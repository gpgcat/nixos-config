{ config, lib, flakeRoot, ... }:
let
  dotfilesPath = "${flakeRoot}/dotfiles";
  dotfilesDir = builtins.readDir ../dotfiles;
  mkSymlink = name: type: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${name}";
  };
in
{
  xdg.configFile = lib.mapAttrs mkSymlink dotfilesDir;
}
