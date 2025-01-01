{ config, pkgs, home, ... }:

{
  imports = [
    ./atuin.nix 
    ./eza.nix
    ./firefox.nix
    ./fzf.nix
    ./git.nix
    ./joplin-desktop.nix
    # ./neovim.nix
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./zed-editor.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
