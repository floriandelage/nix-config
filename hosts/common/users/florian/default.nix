{
    config,
    pkgs,
    ...
}: {
    sops.secrets.florian-password.neededForUsers = true;
    users.mutableUsers = false;

    environment.pathsToLink = ["/share/zsh"];
    programs.zsh = {
        enable = true;
        enableGlobalCompInit = false;
    };

    users.users.florian = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.florian-password.path;
        extraGroups = ["networkmanager" "wheel"];
        shell = pkgs.zsh;

        openssh.authorizedKeys.keys = [
            (builtins.readFile ./keys/id_florian.pub)
        ];
    };

    home-manager.users.florian = import ../../../../home/florian/${config.networking.hostName}.nix;
}
