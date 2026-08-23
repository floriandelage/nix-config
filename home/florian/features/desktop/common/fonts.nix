{pkgs, ...}: {
    home.packages = with pkgs; [
        iosevka
        nerd-fonts.iosevka
        noto-fonts-color-emoji
    ];

    fonts.fontconfig = {
        enable = true;

        defaultFonts = {
            sansSerif = ["Iosevka"];
            serif = ["Iosevka"];
            monospace = ["Iosevka"];
            emoji = ["Noto Color Emoji"];
        };
    };
}
