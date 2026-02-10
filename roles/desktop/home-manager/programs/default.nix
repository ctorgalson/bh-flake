{ config, pkgs, home, unstable-pkgs, ... }:

{
  imports = [
    ./atuin.nix 
    ./eza.nix
    ./fastfetch.nix
    ./firefox.nix
    ./fzf.nix
    ./git.nix
    ./kitty.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./zed-editor.nix
    ./zoxide.nix
    ./zsh
  ];
}
