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
                "/var/lib/systemd/timers"
                "/var/log"
                "/etc/NetworkManager/system-connections"
            ];

            users.florian = {
                files = [
                    ".zsh_history"
                ];

                directories = [
                    ".nix-config"

                    "Documents"
                    "Downloads"
                    "Pictures"
                    "Videos"
                    "Music"

                    ".local/share/zinit"
                    ".local/share/zoxide"

                    ".local/state/nvf"

                    ".config/discord"
                    ".config/spotify"
                    ".config/zen"
                ];
            };
        };
    };
}
