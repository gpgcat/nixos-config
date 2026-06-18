final: prev:

let
  packageFiles = prev.lib.filterAttrs (
    name: type:
    (type == "regular" || type == "symlink") && prev.lib.hasSuffix ".nix" name && name != "default.nix"
  ) (builtins.readDir ./.);

  mkPkgName = name: prev.lib.removeSuffix ".nix" name;
in
prev.lib.mapAttrs' (
  name: value: prev.lib.nameValuePair (mkPkgName name) (import (./. + "/${name}") { pkgs = final; })
) packageFiles
