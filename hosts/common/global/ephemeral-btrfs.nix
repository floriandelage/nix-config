{
    lib,
    config,
    ...
}: let
    root = config.fileSystems."/";

    wipeScript = ''
        set -eu

        mkdir -p /tmp
        MNTPOINT=$(mktemp -d)

        (
          mount -t btrfs -o subvolid=5 ${root.device} "$MNTPOINT"
          trap 'umount "$MNTPOINT"' EXIT

          if [ -e "$MNTPOINT/dont-wipe" ]; then
            echo "Skipping root wipe"
          else
            echo "Deleting old root"
            btrfs subvolume delete -R "$MNTPOINT/root"

            echo "Restoring blank root"
            btrfs subvolume snapshot \
              "$MNTPOINT/root-blank" \
              "$MNTPOINT/root"
          fi
        )
    '';

    toSystemdDevice = device:
        lib.concatStringsSep "-"
        (
            lib.tail (
                map
                (lib.replaceString "-" "\\x2d")
                (lib.splitString "/" device)
            )
        )
        + ".device";
in {
    boot.initrd = {
        supportedFilesystems = ["btrfs"];

        systemd.services.restore-root = {
            description = "Restore blank Btrfs root";

            wantedBy = ["initrd.target"];

            requires = [
                (toSystemdDevice root.device)
            ];

            after = [
                (toSystemdDevice root.device)
            ];

            before = [
                "sysroot.mount"
            ];

            unitConfig.DefaultDependencies = "no";

            serviceConfig.Type = "oneshot";
            script = wipeScript;
        };
    };
}
