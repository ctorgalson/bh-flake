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

      # Prepare, enable, and configure Catppuccin theme.
      #
      # Configure the Catppuccin plugin
      # set -g @catppuccin_flavor "mocha"
      # set -g @catppuccin_window_status_style "basic"

      # Load the plugin.
      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux

      # Configure the Catppuccin plugin
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "basic"

      set -g @catppuccin_flavour 'frappe'
      set -g @catppuccin_window_tabs_enabled on
      set -g @catppuccin_date_time "%H:%M"

      # # Make the status line pretty and add some modules
      # set -g status-right-length 100
      # set -g status-left-length 100
      # set -g status-left ""

      # # set -g status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '
      # set -gF status-right '#[fg=#{@thm_crust},bg=#ff9900] session: #S '
      # set -agF status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] ##H '

      set -ag status-right "#{E:@catppuccin_status_application}"
      # # set -ag status-right "#{E:@catppuccin_status_session}"
      # # set -ag status-right "#{E:@catppuccin_status_uptime}"

      # # # set -agF status-right "#{E:@catppuccin_status_cpu}"
      # # # set -agF status-right "#{E:@catppuccin_status_battery}"
      # # # run ~/.config/tmux/plugins/tmux-plugins/tmux-cpu/cpu.tmux
      # # # run ~/.config/tmux/plugins/tmux-plugins/tmux-battery/battery.tmux
      '';
    };
  };
}
