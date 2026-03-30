{
  description = "cozy flake inspired by Cozette font";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nvf,
      nur,
      stylix,
      zen-browser,
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
              ]
              ++ modules;
            };
        in
        {
          fallback = makeNixosConfiguration "fallback-hostname";

          qualia = makeNixosConfiguration "qualia" [
            ./system/qualia
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

		nvf.homeManagerModules.default
		nur.modules.homeManager.default
		stylix.homeModules.stylix
		zen-browser.homeModules.beta
	      ]
	      ++ modules;
	    };
        in
	{
	  "angel" = makeHomeConfiguration [ ];
	  "angel@qualia" = makeHomeConfiguration [ ];
	};
    };
}
