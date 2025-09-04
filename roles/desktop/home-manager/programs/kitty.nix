{ config, lib, pkgs, programs, ... }:

{
  config = {
    # @see https://mynixos.com/home-manager/options/programs.kitty
    # @see https://home-manager-options.extranix.com/?query=kitty&release=release-24.11
    # @see https://sw.kovidgoyal.net/kitty/_downloads/433dadebd0bf504f8b008985378086ce/kitty.conf
    programs.kitty = {
      enable = true;
      keybindings = {
        # Resize panes.
        "ctrl+left" = "resize_window narrower";
        "ctrl+right" = "resize_window wider";
        "ctrl+up" = "resize_window taller";
        "ctrl+down" = "resize_window shorter";
        # Open panes in the same ******* directory.
        "ctrl+shift+enter" = "launch --cwd=current";
        "ctrl+shift+f" = "launch --stdin-source=@screen_scrollback --type=overlay --overlay-main-ratio=0.8 fzf --reverse --no-sort --border=rounded";
      };
      # Also touched by stylix
      font.name = "UbuntuMono Nerd Font";
      font.size = 16;
      # @see https://sw.kovidgoyal.net/kitty/conf/
      settings = {
        allow_hyperlinks = true;
        enable_audio_bell = false;
        hide_window_decorations = true;
        notify_on_cmd_finish = "unfocused 5";
        remember_window_size = true;
        shell_integration = "no-title";
        scrollback_lines = 10000;
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}{tab.active_oldest_wd.split('/')[-1]}";
        # Rather than unsetting the default $TERM value, xterm-kitty, run this
        # against any server that complains: 
        #
        # infocmp -x | ssh YOUR-SERVER -- tic -x -
        #
        # @see https://ghostty.org/docs/help/terminfo
        # term = "xterm";
        update_check_interval = 0;
        window_padding_width = 2;
      };
      shellIntegration.enableZshIntegration = true;
      # Also touched by stylix
      themeFile = "Catppuccin-Mocha";
    };
  };
}
