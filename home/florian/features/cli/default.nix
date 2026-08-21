{
    imports = [
        ./fastfetch
        ./fd
        ./fzf
        ./kitty
        ./nvim
        ./ripgrep
        ./tmux
        ./oh-my-posh
        ./zoxide
        ./zsh
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
    };
}
