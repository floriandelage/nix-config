{
    lib,
    modulesPath,
    inputs,
    ...
}: {
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")

        inputs.nixos-hardware.nixosModules.common-cpu-amd
        inputs.nixos-hardware.nixosModules.common-pc-ssd

        inputs.disko.nixosModules.default
    ];

    boot = {
        initrd = {
			availableKernelModules = [
				"nvme"
				"ehci_pci"
				"xhci_pci_renesas"
				"xhci_pci"
				"usb_storage"
				"sd_mod"
				"rtsx_pci_sdmmc" 
			];
        };

        kernelModules = [
			"kvm-amd" 
        ];
    };

    disko.devices.disk.main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-PNY_CS1030_500GB_SSD_PNB31258024230500064";

        content = {
            type = "gpt";

            partitions = {
                ESP = {
                    name = "ESP";
                    size = "1G";
                    type = "EF00";

                    content = {
                        type = "filesystem";
                        format = "vfat";
                        mountpoint = "/boot";
                        mountOptions = ["umask=0077"];
                    };
                };

                root = {
                    size = "100%";

                    content = {
                        type = "btrfs";
                        extraArgs = ["-f"];

                        postCreateHook = ''
                            MNTPOINT=$(mktemp -d)

                            mount -t btrfs -o subvolid=5 "$device" "$MNTPOINT"
                            trap 'umount "$MNTPOINT"; rmdir "$MNTPOINT"' EXIT

                            if [ ! -e "$MNTPOINT/root-blank" ]; then
                              btrfs subvolume snapshot \
                                -r \
                                "$MNTPOINT/root" \
                                "$MNTPOINT/root-blank"
                            fi
                        '';

                        subvolumes = {
                            "/root" = {
                                mountpoint = "/";
                                mountOptions = ["compress=zstd" "noatime"];
                            };

                            "/nix" = {
                                mountpoint = "/nix";
                                mountOptions = ["compress=zstd" "noatime"];
                            };

                            "/persist" = {
                                mountpoint = "/persist";
                                mountOptions = ["compress=zstd" "noatime"];
                            };

                            "/swap" = {
                                mountpoint = "/swap";
                                swap.swapfile = {
                                    size = "6G";
                                };
                            };
                        };
                    };
                };
            };
        };
    };

    fileSystems."/persist".neededForBoot = true;

    hardware.graphics.enable = true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
