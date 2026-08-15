{
    console = {
        keyMap = "fr";
    };

    boot.loader = {
        systemd-boot = {
            enable = true;
        };
        efi.canTouchEfiVariables = true;
    };
}
