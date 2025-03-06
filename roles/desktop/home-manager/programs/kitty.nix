{ config, pkgs, programs, ... }:

{
  config = {
    # @see https://home-manager-options.extranix.com/?query=kitty&release=release-24.11
    # @see https://sw.kovidgoyal.net/kitty/_downloads/433dadebd0bf504f8b008985378086ce/kitty.conf
    programs.kitty = {
      enable = true;
      font.name = "UbuntuMono Nerd Font Mono";
      font.size = 15;
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
      themeFile = "Catppuccin-Mocha";
    };
  };
}
