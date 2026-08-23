{osConfig, ...}: {
    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings = {
            "*" = {
                ControlMaster = "auto";
                ControlPersist = "1m";
            };

            "github.com" = {
                HostName = "github.com";
                User = "git";
                IdentitiesOnly = true;
                IdentityFile = [
                    osConfig.sops.secrets."ssh/id_ed25519".path
                ];
            };
        };
    };
}
