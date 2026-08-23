{
    imports = [
        ./hardware-configuration.nix

        ../common/global
        ../common/users/florian

        ../common/optional/niri.nix
        ../common/optional/pipewire.nix
        ../common/optional/systemd-boot.nix
        ../common/optional/wireless.nix
        ../common/optional/power-management.nix
    ];

    networking.hostName = "atlas";

    system.stateVersion = "26.05";
}
