{config, ...}: {
    imports = [
        ./ssh.nix
    ];

    home = {
        username = "florian";
        homeDirectory = "/home/${config.home.username}";
        stateVersion = "26.05";
    };
}
