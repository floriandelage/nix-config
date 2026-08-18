{
    nix = {
        settings = {
            trusted-users = ["florian "];

            substituters = [
                "https://cache.nixos.org"
            ];

            trusted-public-keys = [
            ];

            experimental-features = ["nix-command" "flakes"];
            warn-dirty = false;
        };
        gc = {
            automatic = true;
            dates = "daily";
            options = "--delete-older-than 7d";
        };
    };
}
