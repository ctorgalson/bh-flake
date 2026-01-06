{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
    tmuxPlugins.pain-control
    tmuxPlugins.tmux-fzf
    tmuxPlugins.tmux-which-key
  ];

  home.file = {
    ".config/tmux/tmux.conf".text = ''
      # ==============================================================================
      # CORE SETTINGS
      # ==============================================================================

      # Prefix configuration
      bind-key a send-prefix

      # General behavior
      set -g base-index 1                  # Start window indexing at 1
      set-option -g renumber-windows on    # Renumber windows when one is closed
      set -g detach-on-destroy off         # Don't detach when killing a session
      set -g mouse on                      # Enable mouse support
      set -s escape-time 0                 # No delay for escape key press
      set-option -g display-time 4000      # Duration of status messages
      set-option -g focus-events on        # Focus events enabled for terminals that support it
      setw -g mode-keys vi                 # Vi key bindings in copy mode
      setw -g aggressive-resize on         # Aggressive resize for shared sessions
      set -g main-pane-width 110           # Main pane width for specific layouts

      # Window naming - use git root directory name if in git repo, otherwise basename
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#(cd #{pane_current_path}; git rev-parse --show-toplevel 2>/dev/null | xargs basename || basename "#{pane_current_path}")'

      # Hook to ensure new windows get automatic rename enabled
      set-hook -g after-new-window 'set-window-option automatic-rename on'

      # ==============================================================================
      # TERMINAL & COLOR SUPPORT
      # ==============================================================================

      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",xterm-kitty:Tc:sitm=\E[3m"
      set-option -sa terminal-overrides ',xterm-256color:RGB'

      # Undercurl & Underscore colors support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      # ==============================================================================
      # CLIPBOARD
      # ==============================================================================

      set -g set-clipboard on

      # ==============================================================================
      # APPEARANCE
      # ==============================================================================

      # Catppuccin Configuration
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "rounded"
      set -g @catppuccin_window_text " #W"                         # Override default #T (title) with #W (name)
      set -g @catppuccin_window_default_text " #W"                 # Inactive: just name
      set -g @catppuccin_window_current_text " #{host_short}: #W"  # Active: hostname: name

      # Status Bar
      set -g status-style bg=#1e1e23
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      # Match Kitty
      set -g @catppuccin_status_module_bg_color "#1e1e2e"

      # Pane Borders
      set -g pane-active-border-style "fg=#fe640b,bg=#151515"
      set -g pane-border-lines "heavy"

      # ==============================================================================
      # KEY BINDINGS
      # ==============================================================================

      # Config Reload
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Navigation
      bind -n F11 previous-window
      bind -n F12 next-window
      bind m choose-tree

      # Swap Windows
      bind-key -n C-S-Left swap-window -d -t -1
      bind-key -n C-S-Right swap-window -d -t +1

      # Pane Resizing (Arrow keys)
      bind Left resize-pane -L 4
      bind Right resize-pane -R 4
      bind Up resize-pane -U 4
      bind Down resize-pane -D 4

      # Session Management
      bind $ command-prompt 'rename-session %%'
      bind N new-session
      # Create new session from current window
      bind B command-prompt -p "New session name:" "new-session -d -s '%%'; move-window -t '%%:'; switch-client -t '%%'"

      # Catppuccin plugin
      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux

      # Override Catppuccin's default status-right after it loads
      set -g status-right "#{E:@catppuccin_status_uptime}"
      set -ag status-right "#{E:@catppuccin_status_date_time}"

      # Additional plugins for status bar modules
      run-shell ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/main.tmux
      run-shell ${pkgs.tmuxPlugins.pain-control}/share/tmux-plugins/tmux-pain-control/pain_control.tmux
      run-shell ${pkgs.tmuxPlugins.tmux-which-key}/share/tmux-plugins/tmux-which-key/plugin.sh.tmux
    '';
  };
}
