{inputs, ...}: {
    imports = [
        inputs.home-manager.nixosModules.home-manager

        ./display-manager.nix
        ./gamemode.nix
        ./locale.nix
        ./nix.nix
        ./openssh.nix
        ./optin-persistence.nix
        ./sops.nix
        ./zsh.nix
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
