{pkgs, ...}: {
    programs.tmux = {
        enable = true;

        plugins = [
            pkgs.tmuxPlugins.sensible
            pkgs.tmuxPlugins.vim-tmux-navigator
        ];

        extraConfig = ''
            set -g default-terminal "tmux-256color"
            set -as terminal-overrides ',xterm-kitty:Tc'
            set -g mouse on

            unbind C-b
            set -g prefix C-space
            bind C-space send-prefix

            bind -n M-H previous-window
            bind -n M-L next-window

            bind '"' split-window -v -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"

            set -g base-index 1
            set -g pane-base-index 1

            set -g status-position top
            set -g status 2

            set -g status-position top
            set -g status 2

            set -g 'status-format[0]' \
            '#[align=left]#{E:status-left}#{W:#{E:window-status-format},#{E:window-status-current-format}}#[align=right]#{E:status-right}'

            set -g 'status-format[1]' \
            '#[bg=#282828] '

            set -g status-style "bg=#282828,fg=#ebdbb2"

            set -g status-left-length 80
            set -g status-right-length 100

            set -g status-left \
            "#[bg=#d65d0e,fg=#282828,bold] #S "

            set -g window-status-separator ""

            set -g window-status-format \
            "#[bg=#3c3836,fg=#a89984] #I #[fg=#ebdbb2]#W "

            set -g window-status-current-format \
            "#[bg=#83a598,fg=#282828,bold] #I #[fg=#282828]#W "

            set -g status-right \
            "#[bg=#d79921,fg=#282828]  #{b:pane_current_path} \
            #[bg=#98971a,fg=#282828]  #{pane_current_command} \
            #[bg=#458588,fg=#282828] 󰥔 %H:%M "

            set -g pane-border-style "fg=#504945"
            set -g pane-active-border-style "fg=#d79921"

            set -g message-style "bg=#d79921,fg=#282828,bold"
        '';
    };
}
