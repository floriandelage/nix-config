{
    description = "Florian Delage's nix configuration for NixOS";

    nixConfig = {
        extra-substituters = [
            "https://nix-community.cachix.org"
            "https://noctalia.cachix.org"
        ];
        extra-trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
    };

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        nixos-hardware = {
            url = "github:NixOS/nixos-hardware";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        impermanence = {
            url = "github:nix-community/impermanence";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        noctalia = {
            url = "github:noctalia-dev/noctalia/cachix";
        };
        spicetify-nix = {
            url = "github:Gerg-L/spicetify-nix";
        };
        noctalia-greeter = {
            url = "github:noctalia-dev/noctalia-greeter";
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
        zen-browser = {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        ...
    } @ inputs: let
        inherit (self) outputs;

        systems = [
            "x86_64-linux"
        ];

        forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
        packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
        formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
        devShells = forAllSystems (system: import ./shell.nix nixpkgs.legacyPackages.${system});
        overlays = import ./overlays {inherit inputs outputs;};
        nixosModules = import ./modules/nixos;
        homeManagerModules = import ./modules/home-manager;

        nixosConfigurations = {
            atlas = nixpkgs.lib.nixosSystem {
                modules = [./hosts/atlas];
                specialArgs = {inherit inputs outputs;};
            };
            hermes = nixpkgs.lib.nixosSystem {
                modules = [./hosts/hermes];
                specialArgs = {inherit inputs outputs;};
            };
	    
        };
    };
}
