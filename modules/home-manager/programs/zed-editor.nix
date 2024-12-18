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
      userKeymaps = [
        {
          context = "Editor && vim_mode == normal";
          bindings = {
            "space e" = "workspace::ToggleLeftDock";
            "space s" = "pane::SplitDown";
            "space v" = "pane::SplitRight";
            "ctrl-h" = ["workspace::ActivatePaneInDirection" "Left"];
            "ctrl-l" = ["workspace::ActivatePaneInDirection" "Right"];
            "ctrl-k" = ["workspace::ActivatePaneInDirection" "Up"];
            "ctrl-j" = ["workspace::ActivatePaneInDirection" "Down"];
          };
        }
      ];
      userSettings = {
        telemetry = {
          metrics = false;
        };
        node = {
          path = "${pkgs.nodejs}/bin/node";
          npm_path = "${pkgs.nodejs}/bin/npm";
        };
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
          env = { };
        };
        font_family = "Inconsolata Nerd Font Mono";
        font_features = null;
        font_size = null;
        line_height = "comfortable";
        shell = "system";
        working_directory = "current_project_directory";
        vim_mode = true;
        theme = {
          mode = "dark";
          light = "Solarized Light";
          dark = "Solarized Dark";
        };
        ui_font_size = 16;
        ui_font_family = "Inconsolata Nerd Font Mono";
        buffer_font_size = 16;
        buffer_font_family = "Inconsolata Nerd Font Mono";
        ssh_connections = [
          {
            host = "nx";
            # projects = {
            #   dcc = "~/Projects/dublin-city-council";
            # };
          }
        ];
      };
    };
  };
}
