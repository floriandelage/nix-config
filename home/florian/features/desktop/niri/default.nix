{
    lib,
    config,
    pkgs,
    ...
}: let
    monitorKdl = lib.concatMapStringsSep "\n" (
        m:
            if m.enabled
            then ''
                output "${m.name}" {
                    mode "${toString m.width}x${toString m.height}@${toString m.refreshRate}"
                }
            ''
            else ''
                output "${m.name}" {
                    off
                }
            ''
    )
    config.monitors;

    niriConfig = pkgs.writeText "niri-config.kdl" ''
        ${builtins.readFile ./config.kdl}

        ${monitorKdl}
    '';
in {
    imports = [
        ../common
        ./noctalia
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
        niri validate --config ${niriConfig}
        cp ${niriConfig} $out
    '';
}
