{ config, host, lib, pkgs, programs, ... }:

{
  home-manager.users."${host.username}".config.programs.kitty.font.size = lib.mkForce 13;
}
