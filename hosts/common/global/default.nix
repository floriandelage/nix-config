{inputs, ...}: {
    imports = [
        inputs.home-manager.nixosModules.home-manager

        ./locale.nix
        ./nix.nix
        ./openssh.nix
        ./sops.nix
    ];

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs;};
    };

    nixpkgs = {
        overlays = [
            inputs.self.overlays.additions
            inputs.self.overlays.modifications
            inputs.self.overlays.unstable-packages
        ];

        config = {
            allowUnfree = true;
        };
    };
}
