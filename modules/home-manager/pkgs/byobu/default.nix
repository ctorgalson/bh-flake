{ config, lib, pkgs, ... }:

{
  config = {
    # Install package.
    home.packages = with pkgs; [
      byobu
    ];

    home.file = {
      # Write dotfile.
      ".config/byobu/.tmux.conf".text = ''
      # Mouse support.
      set -g mouse on

      # Colour support.
      set -ga terminal-overrides ",xterm-256color:Tc"

      # Enable Catppuccin theme.
      # run-shell /nix/store/2wg26clcmn7fhi5kf9dfb5a446i9m3zp-tmuxplugin-catppuccin-unstable-2024-05-15/share/tmux-plugins/catppuccin/catppuccin.tmux
      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
      '';
    };
  };
}
