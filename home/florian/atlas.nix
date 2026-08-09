{ pkgs, ...}: {
	imports = [
		./global
	];

	home.packages = with pkgs; [
		vim	
		git
	];
}
