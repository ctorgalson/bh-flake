{ config, lib, pkgs, programs, ... }:

{
  config = {
    # @see https://mynixos.com/home-manager/options/programs.kitty
    # @see https://home-manager-options.extranix.com/?query=kitty&release=release-24.11
    # @see https://sw.kovidgoyal.net/kitty/_downloads/433dadebd0bf504f8b008985378086ce/kitty.conf
    programs.kitty = {
      enable = true;
      keybindings = {
        # "ctrl+c" = "copy_or_interrupt";
        # "ctrl+f&gt;2" = "set_font_size 20";

        # Resize panes.
        "ctrl+left" = "resize_window narrower";
        "ctrl+right" = "resize_window wider";
        "ctrl+up" = "resize_window taller";
        "ctrl+down" = "resize_window shorter";

        # Open panes in the same ******* directory.
        "ctrl+shift+enter" = "launch --cwd=current";
      };
      # Taken over by stylix
      font.name = "UbuntuMono Nerd Font";
      font.size = 16;
      # @see https://sw.kovidgoyal.net/kitty/conf/
      settings = {
        # active_border_color = "#fab387";
        # inactive_border_color = "#313244";
        allow_hyperlinks = true;
        enable_audio_bell = false;
        hide_window_decorations = true;
        notify_on_cmd_finish = "unfocused 5";
        remember_window_size = true;
        scrollback_lines = 10000;
        # Stylix is overriding this override :(
        # tab_bar_background = "#313244";
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
      # Taken over by stylix
      themeFile = "Catppuccin-Mocha";
    };
  };
}
