{ config, pkgs, home, ... }:

{
  imports = [
    ./atuin.nix 
    ./eza.nix
    ./fastfetch.nix
    ./firefox.nix
    ./fzf.nix
    ./git.nix
    ./joplin-desktop.nix
    ./kitty.nix
    ./neovim
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    #./zed-editor.nix
    ./zoxide.nix
    ./zsh
  ];
}
