{ inputs, pkgs, ... }: {
	imports = [
		inputs.noctalia-greeter.nixosModules.default
	];

	programs.noctalia-greeter = {
		enable = true;
		settings = {
			appearance = {
				scheme = "Gruvbox";
				hide_logo = true;
			};
			cursor = {
				theme = "Bibata-Modern-Ice";
				size = 24;
				path = "${pkgs.bibata-cursors}/share/icons";
			};
			keyboard = {
				layout = "fr";
			};
		};
	};
}
