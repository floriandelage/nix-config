{
    programs.zsh = {
        enable = true;

        enableCompletion = false;

        shellAliases = {
            v = "nvim";
            c = "clear";
        };

        initContent = ''
            ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
            [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
            [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

            source "''${ZINIT_HOME}/zinit.zsh"

            zinit light zsh-users/zsh-syntax-highlighting
            zinit light zsh-users/zsh-completions
            zinit light zsh-users/zsh-autosuggestions

            autoload -Uz compinit
            compinit

            zinit cdreplay -q

            source <(fzf --zsh)
            eval "$(zoxide init --cmd cd zsh)"

            zinit light Aloxaf/fzf-tab

            bindkey -v

            bindkey -M viins '^?' backward-delete-char
            bindkey -M viins '^H' backward-delete-char
            bindkey -M viins '^[[3~' delete-char
            bindkey -M viins '^F' autosuggest-accept
            bindkey -M viins '^P' history-search-backward
            bindkey -M viins '^N' history-search-forward

            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
            zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
            zstyle ':completion:*' menu no

            zstyle ':fzf-tab:complete:cd:*' \
                fzf-preview 'ls --color $realpath'

            zstyle ':fzf-tab:complete:__zoxide_cd:*' \
                fzf-preview 'ls --color $realpath'

            if [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
                exec tmux new-session -A -s main
            fi

            fastfetch
        '';

        history = {
            size = 5000;
            save = 5000;
            path = "$HOME/.zsh_history";

            append = true;
            share = true;

            ignoreAllDups = true;
            expireDuplicatesFirst = true;
        };
    };
}
