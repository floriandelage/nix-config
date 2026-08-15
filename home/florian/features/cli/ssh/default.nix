{
    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings."github.com" = {
            IdentityFile = "/home/florian/.ssh/id_ed25519";
        };
    };
}
