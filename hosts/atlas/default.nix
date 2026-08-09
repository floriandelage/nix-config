{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
	
	../common/global
	../common/users/florian

	../common/optional/pipewire.nix
	../common/optional/systemd-boot.nix
	../common/optional/wireless.nix
  ];

  networking.hostName = "atlas";

  system.stateVersion = "26.05";
}
