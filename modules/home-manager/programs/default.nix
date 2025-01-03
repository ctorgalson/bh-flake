{ config, pkgs, home, ... }:

{
  imports = [
    ./atuin.nix 
    ./eza.nix
    ./firefox.nix
    ./fzf.nix
    ./git.nix
    ./joplin-desktop.nix
    ./neovim
    # ./nvchad
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./zed-editor.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
