{
    outputs,
    lib,
    config,
    ...
}: let
    hostKeyFiles = lib.genAttrs
    (lib.attrNames outputs.nixosConfigurations)
    (hostname: ../../${hostname}/ssh_host_ed25519_key.pub);

    hasOptinPersistence =
        config.environment.persistence ? "/persist";
in {
    services.openssh = {
        enable = true;
        openFirewall = true;

        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };

        hostKeys = [
            {
                path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
                type = "ed25519";
            }
        ];
    };

    programs.ssh.knownHosts = lib.mapAttrs
    (hostname: publicKeyFile: {
        inherit publicKeyFile;

        extraHostNames = lib.optional
        (hostname == config.networking.hostName)
        "localhost";
    })
    hostKeyFiles;
}
