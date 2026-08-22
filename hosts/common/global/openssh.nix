{
    outputs,
    lib,
    config,
    ...
}: let
    # Every NixOS host, mapped to its commited SSH host public key.
    hostKeyFiles = lib.genAttrs
    (lib.attrNames outputs.nixosConfigurations)
    (hostname: ../../${hostname}/ssh_host_ed25519_key.pub);

    # With impermanence, use the real persistent SSH key directly.
    hasOptinPersistence =
        config.environment.persistence ? "/persist";
in {
    services.openssh = {
        enable = true;
        openFirewall = true;

        settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = ["florian"];
            MaxAuthTries = 3;

            PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
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
