{ config, lib, pkgs, programs, ... }:

{
  config = {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "basher"
        "csv"
        "git-firefly"
        "html"
        "nix"
        "php"
        "git-firefly"
        "jinja2"
        "sql"
        "toml"
        "twig"
      ];
      # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zed-editor.userKeymaps
      userKeymaps = { };
      userSettings = {
        telemetry = {
          metrics = false;
        };
        # node = {
        #   path = lib.getExe pkgs.nodejs;
        #   npm_path = lib.getExe pkgs.nodejs "npm";
        # };
        hour_format = "hour24";
        auto_update = false;
        terminal = {
          alternate_scroll = "off";
          blinking = "off";
          copy_on_select = false;
          dock = "bottom";
          detect_venv = {
            on = {
              directories = [".env" "env" ".venv" "venv"];
              activate_script = "default";
            };
          };
          env = {
            TERM = "alacritty";
          };
          font_family = "UbuntuMono Nerd Font";
          font_features = null;
          font_size = null;
          line_height = "comfortable";
          shell = "system";
          working_directory = "current_project_directory";
          vim_mode = true;
          theme = {
            mode = "system";
            light = "Solarized Light";
            dark = "Solarized Dark";
          };
          ui_font_size = 16;
          buffer_font_size = 16;
        };
      };
    };
  };
}
