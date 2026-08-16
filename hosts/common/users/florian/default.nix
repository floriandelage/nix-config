{
    config,
    pkgs,
    ...
}: {
    environment.pathsToLink = ["/share/zsh"];

    programs.zsh = {
        enable = true;
        enableGlobalCompInit = false;
    };

    users.users.florian = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel"];
        shell = pkgs.zsh;
    };

    home-manager.users.florian = import ../../../../home/florian/${config.networking.hostName}.nix;
}
