{pkgs, ...}: {
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

    home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;

        gtk.enable = true;
        x11.enable = true;
    };
}
