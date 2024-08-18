{ config, pkgs, home, ... }:

{
  imports = [
    ./atuin.nix 
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./joplin-desktop.nix
    ./neovim.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
