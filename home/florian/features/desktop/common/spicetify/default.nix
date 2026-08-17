{
    inputs,
    pkgs,
    ...
}: {
    imports = [
        inputs.spicetify-nix.homeManagerModules.default
    ];

    programs.spicetify = let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
            shuffle
        ];

        enabledCustomApps = with spicePkgs.apps; [
        ];

        enabledSnippets = with spicePkgs.snippets; [
        ];

        theme = spicePkgs.themes.onepunch;
    };
}
