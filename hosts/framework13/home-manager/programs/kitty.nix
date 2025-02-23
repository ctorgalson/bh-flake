{ config, lib, pkgs, programs, ... }:

{
  home-manager.users."ctorgalson".config.programs.kitty.font.size = lib.mkForce 13;
}
