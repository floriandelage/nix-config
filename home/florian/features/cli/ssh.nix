{
    lib,
    osConfig,
    outputs,
    ...
}: let
    hostnames = builtins.attrNames outputs.nixosConfigurations;
in {
    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings = {
            "*" = {
                ControlMaster = "auto";
                ControlPersist = "1m";
            };

            "hosts" = {
                Host = lib.concatStringsSep " " hostnames;
                User = "florian";
                IdentitiesOnly = true;
                IdentityFile = [
                    osConfig.sops.secrets."ssh/id_ed25519".path
                ];
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
