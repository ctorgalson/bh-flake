{ config, pkgs, home, ... }:

{
  imports = [
    ./ssh-agent.nix
    ./syncthing.nix
  ];
}
