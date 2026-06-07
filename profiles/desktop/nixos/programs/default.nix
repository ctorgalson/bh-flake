{ inputs, lib, pkgs, ... }:

{
  programs.git.enable = true;
  programs.steam.enable = true;
  programs.zsh.enable = true;
  # Find a better place for this.
  programs.fuse.userAllowOther = true;
}
