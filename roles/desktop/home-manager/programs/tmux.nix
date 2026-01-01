{ pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      tmuxPlugins.catppuccin
    ];

    programs.tmux = {
      baseIndex = 1;
      clock24 = true;
      enable = true;
      escapeTime = 0;
      extraConfig = ''
        detach-on-destroy = off
        renumber-windows = on

        unbind s
        unbind S
        bind s split-window -v -c "#{pane_current_path}"
        bind S split-window -h -c "#{pane_current_path}"
        bind F run-shell 'tmux list-sessions -F "#{session_name}" | fzf --reverse --prompt="Sessions> " | xargs -r -I{} tmux switch-client -t {}'
      '';
      keyMode = "vi";
      mouse = true;
      newSession = true;
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          # extraConfig = ''
          # set -g @catppuccin_flavor "mocha"
          # set -g @catppuccin_window_status_style "basic"
          # set -g @catppuccin_flavor "macchiato"
          # # set -g @catppuccin_status_background "none" # none == default
          # set -g @catppuccin_pane_status_enabled "off"
          # set -g @catppuccin_pane_border_status "off"
          # set -ga status-right "#[fg=#{@thm_lavender},bg=default]"
          # # set -ga status-right " #{?#{e|>:#{window_width},95}, %Y-%m-%d,} "
          # # set -ga status-right "#{E:#{@custom_separator}}"
          # '';
        }
      ];
      terminal = "tmux-256color";
    };
  };
}
