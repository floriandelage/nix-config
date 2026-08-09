{ inputs, pkgs, ... }: {

	imports = [
		inputs.noctalia.homeModules.default
	];
	
	programs.noctalia.enable = true;

	xdg.configFile."noctalia/config.toml".source = ./config.toml;
}
