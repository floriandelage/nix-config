{pkgs, ...}: {
    imports = [
        ./discord.nix
        ./firefox.nix
        ./fonts.nix
        ./gtk.nix
        ./qt.nix
        ./spotify.nix
        ./xdg.nix
        ./zen-browser.nix
    ];

    home.packages = with pkgs; [
        nautilus
    ];
}
