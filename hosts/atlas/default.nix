{
    inputs,
    lib,
    config,
    pkgs,
    ...
}: {
    imports = [
        ./hardware-configuration.nix
        ./disko.nix
        ./impermanence.nix

        ../common/global
        ../common/users/florian

        ../common/optional/niri.nix
        ../common/optional/pipewire.nix
        ../common/optional/systemd-boot.nix
        ../common/optional/wireless.nix
        ../common/optional/power-management.nix
        ../common/optional/noctalia-greeter.nix
        ../common/optional/nvidia.nix
    ];

    networking.hostName = "atlas";

    system.stateVersion = "26.05";
}
