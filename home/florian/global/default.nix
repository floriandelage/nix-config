{
    config,
    outputs,
    ...
}: {
    imports =
        [
        ]
        ++ (builtins.attrValues outputs.homeManagerModules);

    home = {
        username = "florian";
        homeDirectory = "/home/${config.home.username}";
        stateVersion = "26.05";
        persistence."/persist".directories = [
            ".nix-config"
            ".local/share/nix"
        ];
    };
}
