{pkgs, ...}: {
    imports = [
    ];

    home.packages = with pkgs; [
        spotify
    ];
}
