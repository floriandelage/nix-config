{
    inputs,
    pkgs,
    ...
}: {
    home.packages = [
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    home.persistence."/persist".directories = [
        ".config/zen"
    ];
}
