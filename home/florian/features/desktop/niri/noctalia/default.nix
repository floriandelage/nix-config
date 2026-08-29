{inputs, ...}: {
    imports = [
        inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
        enable = true;
        settings = ./config.toml;
    };

    home.persistence."/persist".directories = [
        ".local/state/noctalia"
    ];
}
