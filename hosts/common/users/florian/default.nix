{ config, ... }: {
	users.users.florian = {
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" ];
	};

	home-manager.users.florian = import ../../../../home/florian/${config.networking.hostName}.nix;
}
