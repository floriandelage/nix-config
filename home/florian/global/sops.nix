{
    inputs,
    config,
    ...
}: let
    secretsPath = toString inputs.mysecrets;
in {
    imports = [
        inputs.sops-nix.homeManagerModules.sops
    ];

    sops = {
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

        defaultSopsFile = "${secretsPath}/secrets.yaml";
        validateSopsFiles = false;

        secrets = {
            "private_keys/florian" = {
                path = "/home/${config.home.username}/.ssh/id_florian";
            };
        };
    };
}
