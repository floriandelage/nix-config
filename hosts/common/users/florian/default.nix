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

    sops.secrets = {
        "florian-password" = {
            sopsFile = ../../secrets.yaml;
            neededForUsers = true;
        };

        "ssh/id_ed25519" = {
            sopsFile = ../../secrets.yaml;
            owner = "florian";
            mode = "0600";
        };
    };

    home-manager.users.florian = import ../../../../home/florian/${config.networking.hostName}.nix;
}
