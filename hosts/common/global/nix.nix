{
    nix = {
        settings = {
            trusted-users = [
                "root"
                "florian"
            ];

            substituters = [
                "https://cache.nixos.org"
            ];

            trusted-public-keys = [
            ];

            auto-optimise-store = true;
            experimental-features = ["nix-command" "flakes"];
            warn-dirty = false;
        };
        gc = {
            automatic = true;
            dates = "daily";
            options = "--delete-older-than 7d";
        };
    };

    environment.persistence."/persist" = {
        users.root = {
            directories = [
                ".local/share/nix"
            ];
        };
    };
}
