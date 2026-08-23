{pkgs, ...}: {
    imports = [
        ./global

        ./features/desktop/niri
        ./features/cli
    ];

    home.packages = with pkgs; [
        git
    ];

    monitors = [
        {
            name = "DP-1";
            primary = true;
            width = 1920;
            height = 1080;
            refreshRate = 60.0;
            enabled = true;
        }
    ];
}
