{pkgs, ...}: {
    imports = [
        ../common
    ];

    home.packages = with pkgs; [
        bibata-cursors
        wl-clipboard
        xwayland-satellite
    ];

    xdg.configFile."niri/config.kdl".source = pkgs.runCommand "niri-config-checked"
    {
        nativeBuildInputs = [pkgs.niri];
    }
    ''
        niri validate --config ${./config.kdl}
        cp ${./config.kdl} $out
    '';
}
