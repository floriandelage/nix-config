{config, ...}: {
    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings = {
            "hosts" = {
                host = "github.com";
                user = "git";
                identitiesOnly = true;
                identityFile = [
                    "/home/${config.home.username}/.ssh/id_florian"
                ];
            };
        };
    };
}
