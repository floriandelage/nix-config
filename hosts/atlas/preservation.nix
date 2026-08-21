{inputs, ...}: {
    imports = [inputs.preservation.nixosModules.default];

    preservation = {
        enable = true;

        preserveAt."/persistent" = {
            files = [
                {
                    file = "/etc/machine-id";
                    inInitrd = true;
                }
                {
                    file = "/etc/ssh/ssh_host_ed25519_key";
                    inInitrd = true;
                }

                "/etc/ssh/ssh_host_ed25519_key.pub"
            ];
            directories = [
                "/var/lib/nixos"
                "/var/lib/systemd"
                "/var/log"
                "/etc/NetworkManager/system-connections"
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
    };

    systemd.services.systemd-machine-id-commit = {
        unitConfig.ConditionPathIsMountPoint = [
            ""
            "/persistent/etc/machine-id"
        ];
        serviceConfig.ExecStart = [
            ""
            "systemd-machine-id-setup --commit --root /persistent"
        ];
    };
}
