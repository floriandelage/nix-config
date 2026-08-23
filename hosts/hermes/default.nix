{
    imports = [
        ./hardware-configuration.nix

        ../common/global
        ../common/users/florian

        ../common/optional/bluetooth.nix
        ../common/optional/greeter.nix
        ../common/optional/networkmanager.nix
        ../common/optional/niri.nix
        ../common/optional/pipewire.nix
        ../common/optional/power.nix
        ../common/optional/systemd-boot.nix
        ../common/optional/zsh.nix
    ];

    networking.hostName = "hermes";

    system.stateVersion = "26.05";
}
