{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    import-tree.url = "github:denful/import-tree";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [
          inputs.nur.overlays.default
          inputs.yazi.overlays.default
          (import ./packages)
        ];
      };

      inherit (nixpkgs) lib;

      getNixFiles =
        dir:
        if builtins.pathExists dir then
          builtins.filter (path: lib.hasSuffix ".nix" path) (lib.fileset.toList dir)
        else
          [ ];

      commonModules = getNixFiles ./hosts/common;

      makeNixosConfiguration =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            inherit inputs;
            flakeRoot = ./.;
          };
          modules = (getNixFiles (./hosts + "/${hostname}")) ++ commonModules;
        };

      hostDirs = nixpkgs.lib.filterAttrs (name: type: type == "directory" && name != "common") (
        builtins.readDir ./hosts
      );
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs' (hostname: _: {
        name = hostname;
        value = makeNixosConfiguration hostname;
      }) hostDirs;

      homeConfigurations.madeline = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          flakeRoot = ./.;
        };
        modules = [
          (inputs.import-tree ./home)
        ];
      };
    };
}
