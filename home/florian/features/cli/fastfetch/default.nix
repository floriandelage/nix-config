{
    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                type = "builtin";
                source = "nixos_small";
                padding.right = 2;
            };

            display.separator = "  ";

            modules = [
                "title"
                "separator"

                {
                    type = "os";
                    key = "os";
                }
                {
                    type = "wm";
                    key = "wm";
                }
                {
                    type = "terminal";
                    key = "term";
                }
                {
                    type = "shell";
                    key = "shell";
                }

                "break"

                {
                    type = "colors";
                    symbol = "circle";
                }
            ];
        };
    };
}
