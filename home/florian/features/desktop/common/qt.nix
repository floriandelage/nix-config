{pkgs, ...}: {
    home.packages = with pkgs; [
        libsForQt5.qtstyleplugin-kvantum
        kdePackages.qtstyleplugin-kvantum
    ];

    qt = {
        enable = true;

        kvantum = {
            enable = true;
            themes = with pkgs; [
                gruvbox-kvantum
            ];
            settings = {
                General.theme = "Gruvbox-Dark-Brown";
            };
        };

        platformTheme.name = "gtk3";
        style.name = "kvantum";
    };
}
