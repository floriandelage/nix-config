{
    inputs,
    pkgs,
    ...
}: let
    secretsPath = toString inputs.mysecrets;
in {
    imports = [inputs.sops-nix.nixosModules.sops];
    environment.systemPackages = with pkgs; [age sops];

    sops = {
        defaultSopsFile = "${secretsPath}/secrets.yaml";
        validateSopsFiles = false;

        age = {
            sshKeyPaths = ["/persistent/etc/ssh/ssh_host_ed25519_key"];
            keyFile = "/var/lib/sops-nix/key.txt";
            generateKey = true;
        };

        secrets = {
            "keys/age" = {
                owner = "florian";
                group = "users";
                mode = "0600";
                path = "/home/florian/.config/sops/age/keys.txt";
            };
        };
    };
}
