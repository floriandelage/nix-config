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

        hashedPasswordFile = config.sops.secrets.florian-password.path;
        openssh.authorizedKeys.keyFiles = [
            ../../../../home/florian/ssh.pub
        ];
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
