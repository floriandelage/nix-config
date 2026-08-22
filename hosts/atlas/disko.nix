{inputs, ...}: {
    imports = [
        inputs.disko.nixosModules.default
        ../common/optional/ephemeral-btrfs.nix
    ];

    disko.devices.disk.main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Force_MP510_203982920001288759DA";

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

                            umount "$MNTPOINT"
                            rmdir "$MNTPOINT"
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
}
