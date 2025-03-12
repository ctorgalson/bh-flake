{ inputs, lib, pkgs, ... }:

{
  programs.git.enable = true;
  programs.ssh.startAgent = false;
  programs.steam.enable = true;
  programs.zsh.enable = true;
}
