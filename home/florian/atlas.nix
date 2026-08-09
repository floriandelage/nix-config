{ pkgs, ...}: {
	imports = [
		./global
		
		./features/desktop/niri
		./features/desktop/noctalia
		./features/cli
	];

	

	home.packages = with pkgs; [
		vim	
		git
		kitty
	];
	
	programs.firefox.enable = true;
}
