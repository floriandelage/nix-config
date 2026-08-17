{pkgs, ...}: {
    home.packages = with pkgs; [
        iosevka
        nerd-fonts.iosevka
        noto-fonts-color-emoji

        libsForQt5.qtstyleplugin-kvantum
        kdePackages.qtstyleplugin-kvantum
    ];

    fonts.fontconfig = {
        enable = true;

        defaultFonts = {
            sansSerif = ["Iosevka"];
            serif = ["Iosevka"];
            monospace = ["Iosevka"];
            emoji = ["Noto Color Emoji "];
        };
    };

    gtk = {
        enable = true;

        colorScheme = "dark";

        font = {
            name = "Iosevka";
        };

        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };

        theme = {
            name = "Gruvbox-Dark";
            package = pkgs.gruvbox-gtk-theme;
        };
    };

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

    home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;

        gtk.enable = true;
        x11.enable = true;
    };
}
