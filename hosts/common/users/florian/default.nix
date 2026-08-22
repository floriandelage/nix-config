{
    pkgs,
    lib,
    config,
    ...
}: {
    users.mutableUsers = false;
    users.users.florian = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = ["networkmanager" "wheel"];

        openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/florian/ssh.pub);
        hashedPasswordFile = config.sops.secrets.florian-password.path;
    };

    environment.pathsToLink = ["/share/zsh"];
    programs.zsh = {
        enable = true;
        enableGlobalCompInit = false;
    };

    sops.secrets = {
        florian-password = {
            sopsFile = ../../secrets.yaml;
            neededForUsers = true;
        };
    };

    home-manager.users.florian = import ../../../../home/florian/${config.networking.hostName}.nix;
}
