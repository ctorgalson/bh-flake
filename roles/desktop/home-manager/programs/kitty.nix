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

        # Navigate between panes.
        "ctrl+shift+h" = "neighboring_pane left";
        "ctrl+shift+j" = "neighboring_pane down";
        "ctrl+shift+k" = "neighboring_pane up";
        "ctrl+shift+l" = "neighboring_pane right";
      };
      # Taken over by stylix
      # font.name = "UbuntuMono Nerd Font Mono";
      # font.size = 15;
      # @see https://sw.kovidgoyal.net/kitty/conf/
      settings = {
        allow_hyperlinks = true;
        enable_audio_bell = false;
        hide_window_decorations = true;
        notify_on_cmd_finish = "unfocused 5";
        remember_window_size = true;
        scrollback_lines = 10000;
        # Rather than unsetting the default $TERM value, xterm-kitty, run this
        # against any server that complains: 
        #
        # infocmp -x | ssh YOUR-SERVER -- tic -x -
        #
        # @see https://ghostty.org/docs/help/terminfo
        # term = "xterm";
        update_check_interval = 0;
      };
      shellIntegration.enableZshIntegration = true;
      # Taken over by stylix
      # themeFile = "Catppuccin-Mocha";
    };
  };
}
