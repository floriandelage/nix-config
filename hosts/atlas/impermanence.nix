{inputs, ...}: {
    imports = [
        inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
        directories = [
            "/etc/nixos"
            "/var/lib/nixos"

            {
                directory = "/etc/NetworkManager/system-connections";
                mode = "0700";
            }

            {
                directory = "/etc/ssh";
                mode = "0700";
            }
        ];

        files = [
            "/etc/machine-id"
        ];

        users.florian = {
            files = [
                ".zsh_history"
            ];

            directories = [
                "Desktop"
                "Documents"
                "Downloads"
                "Music"
                "Pictures"
                "Projects"
                "Public"
                "Templates"
                "Videos"

                ".nix-config"

                ".local/state/home-manager"
                ".local/state/nix/profiles"
                ".local/share/nix"

                ".local/share/zinit"
                ".local/share/zoxide"

                ".local/state/nvf"
                ".local/state/noctalia"

                ".config/discord"
                ".config/spotify"
                ".config/zen"
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
