{
  description = "madeline's nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    t480-fingerprint = {
      url = "github:viktor-grunwaldt/t480-fingerprint-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      lanzaboote,
      disko,
      caelestia-shell,
      ...
    }@inputs:
    {
      nixosConfigurations =
        let
          makeNixosConfiguration =
            name: modules:
            nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = { inherit inputs; };
              modules = [
                (
                  { ... }:
                  {
                    networking.hostName = name;
                  }
                )

                ./system
              ] ++ modules;
            };
        in
        {
          fallback = makeNixosConfiguration "fallback" [ ];
          vanilla = makeNixosConfiguration "vanilla" [
            ./system/vanilla

            lanzaboote.nixosModules.lanzaboote
            disko.nixosModules.disko
            inputs.t480-fingerprint.nixosModules."06cb-009a-fingerprint-sensor"
          ];
        };
      homeConfigurations =
        let
          makeHomeConfiguration =
            modules:
            home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
              extraSpecialArgs = { inherit inputs; };
              modules = [
                ./home

                caelestia-shell.homeManagerModules.default
              ] ++ modules;
            };
        in
        {
          "madeline" = makeHomeConfiguration [ ];
          "madeline@vanilla" = makeHomeConfiguration [ ];
        };
  };
}
