{
    console.keyMap = "fr";

    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            timeout = 0;
        };

        kernelParams = [
            "quiet"
            "loglevel=3"
            "udev.log_level=3"
            "rd.udev.log_level=3"
            "systemd.show_status=auto"
            "rd.systemd.show_status=auto"
            "vt.global_cursor_default=0"
        ];

        consoleLogLevel = 3;
        initrd.verbose = false;
    };
}
