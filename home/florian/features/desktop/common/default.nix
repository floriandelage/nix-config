{pkgs, ...}: {
    imports = [
        ./discord
        ./spicetify
        ./theme
        ./zen-browser
        ./xdg
    ];

    home.packages = with pkgs; [
        nautilus
    ];
}
