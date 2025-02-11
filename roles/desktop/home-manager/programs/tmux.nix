{ config, pkgs, home, ... }:

{
  config = {
    programs.tmux = {
      enable = true;
      mouse = true;
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "basic"
          set -g @catppuccin_flavor "macchiato"
          # set -g @catppuccin_status_background "none" # none == default
          set -g @catppuccin_pane_status_enabled "off"
          set -g @catppuccin_pane_border_status "off"
          set -ga status-right "#[fg=#{@thm_lavender},bg=default]"
          # set -ga status-right " #{?#{e|>:#{window_width},95}, %Y-%m-%d,} "
          # set -ga status-right "#{E:#{@custom_separator}}"
          '';
        } 
      ];
    }; 
  };
}
