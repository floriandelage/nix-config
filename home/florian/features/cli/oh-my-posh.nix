{
    programs.oh-my-posh = {
        enable = true;
        enableZshIntegration = true;

        settings = {
            version = 4;
            final_space = true;

            blocks = [
                {
                    type = "prompt";
                    alignment = "left";
                    newline = true;

                    segments = [
                        {
                            type = "path";
                            style = "plain";
                            background = "transparent";
                            foreground = "blue";
                            template = "{{ .Path }}";

                            properties = {
                                style = "full";
                            };
                        }
                        {
                            type = "git";
                            style = "plain";
                            background = "transparent";
                            foreground = "grey";
                            template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";

                            properties = {
                                branch_icon = "";
                                commit_icon = "@";
                                fetch_status = true;
                            };
                        }
                    ];
                }
                {
                    type = "rprompt";
                    overflow = "hidden";

                    segments = [
                        {
                            type = "executiontime";
                            style = "plain";
                            background = "transparent";
                            foreground = "yellow";
                            template = "{{ .FormattedMs }}";

                            properties = {
                                threshold = 5000;
                            };
                        }
                    ];
                }
                {
                    type = "prompt";
                    alignment = "left";
                    newline = true;

                    segments = [
                        {
                            type = "text";
                            style = "plain";
                            background = "transparent";
                            foreground_templates = [
                                "{{if gt .Code 0}}red{{end}}"
                                "{{if eq .Code 0}}green{{end}}"
                            ];
                            template = "❯";
                        }
                    ];
                }
            ];

            transient_prompt = {
                background = "transparent";
                foreground_templates = [
                    "{{if gt .Code 0}}red{{end}}"
                    "{{if eq .Code 0}}green{{end}}"
                ];
                template = "❯ ";
            };

            secondary_prompt = {
                background = "transparent";
                foreground = "green";
                template = "❯❯ ";
            };
        };
    };
}
