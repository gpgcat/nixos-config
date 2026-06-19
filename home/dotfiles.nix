{
  config,
  lib,
  flakeRoot,
  ...
}:
let
  dotfilesPath = toString flakeRoot + "/dotfiles";
  dotfilesDir = builtins.readDir ../dotfiles;

  mkSymlink = name: type: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${name}";
  };
in
{
  xdg.configFile = lib.mapAttrs mkSymlink dotfilesDir;
}
