{inputs, ...}: {
    imports = [
        inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
        hideMounts = true;

        directories = [
            "/var/lib/nixos"
            "/var/lib/systemd"
            "/var/log"
        ];

        files = [
            "/etc/machine-id"
        ];

        users.florian = {
            directories = [
                ".nix-config"
            ];
        };
    };

    boot.initrd.systemd.suppressedUnits = [
        "systemd-machine-id-commit.service"
    ];

    systemd.suppressedSystemUnits = [
        "systemd-machine-id-commit.service"
    ];

    security.sudo.extraConfig = ''
        Defaults lecture = never
    '';
}
