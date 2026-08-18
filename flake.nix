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

        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia.url = "github:noctalia-dev/noctalia/cachix";

        noctalia-greeter = {
            url = "github:noctalia-dev/noctalia-greeter";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nvf = {
            url = "github:NotAShelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        ...
    } @ inputs: let
        systems = [
            "x86_64-linux"
        ];

        forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
        packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
        formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
        overlays = import ./overlays {inherit inputs;};
        nixosModules = import ./modules/nixos;
        homeManagerModules = import ./modules/home-manager;

        nixosConfigurations = {
            atlas = nixpkgs.lib.nixosSystem {
                modules = [./hosts/atlas];
                specialArgs = {inherit inputs;};
            };
        };
    };
}
