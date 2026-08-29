{
    imports = [
        ./zsh.nix

        ./fastfetch.nix
        ./fd.nix
        ./fzf.nix
        ./kitty.nix
        ./nvf.nix
        ./oh-my-posh.nix
        ./ripgrep.nix
        ./ssh.nix
        ./tmux.nix
        ./zk.nix
        ./zoxide.nix
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
    };
}
