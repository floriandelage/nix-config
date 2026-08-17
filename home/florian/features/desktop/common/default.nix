{pkgs, ...}: {
    imports = [
        ./discord
        ./spicetify
        ./theme
        ./zen-browser
    ];

    home.packages = with pkgs; [
        nautilus
    ];
}
