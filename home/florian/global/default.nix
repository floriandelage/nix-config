{config, ...}: {
    imports = [
        ./sops.nix
        ./ssh.nix
    ];

    home = {
        username = "florian";
        homeDirectory = "/home/${config.home.username}";
        stateVersion = "26.05";
    };
}
