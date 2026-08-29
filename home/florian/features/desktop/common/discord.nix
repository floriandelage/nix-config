{
    programs.discord = {
        enable = true;
    };

    home.persistence."/persist".directories = [
        ".config/discord"
    ];
}
