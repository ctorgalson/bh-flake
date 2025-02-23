{ config, pkgs, programs, ... }:

{
  config = {
    # @see https://home-manager-options.extranix.com/?query=kitty&release=release-24.11
    programs.kitty = {
      enable = true;
      font.name = "UbuntuMono Nerd Font Mono";
      font.size = 15;
      # @see https://sw.kovidgoyal.net/kitty/conf/
      settings = {
        enable_audio_bell = false;
        hide_window_decorations = true;
        remember_window_size = true;
        scrollback_lines = 10000;
        update_check_interval = 0;
      };
      shellIntegration.enableZshIntegration = true;
      themeFile = "Catppuccin-Mocha";
    };
  };
}
