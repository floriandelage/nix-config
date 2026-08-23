{
    lib,
    stdenvNoCC,
    fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
    pname = "firefox-mod-blur";
    version = "v2.14";

    src = fetchFromGitHub {
        owner = "datguypiko";
        repo = "Firefox-Mod-Blur";
        rev = "refs/heads/master";
        hash = "sha256-1lt7nGS+Ufxu2MUIdSKf9KKW2k+8+RczsBNr5sg04xk=";
    };

    installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp -r ./* $out/

        cp "EXTRA MODS/Bookmarks Bar Mods/Bookmarks bar same color as toolbar/bookmarks_bar_same_color_as_toolbar.css" "$out/"

        runHook postInstall
    '';

    meta = {
        description = "Firefox Mod Blur";
        homepage = "https://github.com/datguypiko/Firefox-Mod-Blur";
        platforms = lib.platforms.all;
        license = lib.licenses.gpl3;
    };
}
