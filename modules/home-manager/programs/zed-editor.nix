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
      # https://www.reddit.com/r/ZedEditor/comments/1bd6ene/zed_editor_settings/
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
        auto_update = false;
        buffer_font_family = "Inconsolata Nerd Font Mono";
        buffer_font_size = 16;
        eslint = {
          enabled = true;
          autoFixOnSave = true;
          autoFixOnFormat = true;
          autoFixOnFormatDelay = 1500;
        };
        font_family = "Inconsolata Nerd Font Mono";
        font_features = null;
        font_size = null;
        formatter = "prettier";
        git = {
          enabled = true;
          git_status = true;
          git_gutter = "tracked_files";
        };
        line_height = "comfortable";
        linter = "eslint";
        hour_format = "hour24";
        node = {
          npm_path = "${pkgs.nodejs}/bin/npm";
          path = "${pkgs.nodejs}/bin/node";
        };
        preferred_line_length = 80;
        prettier = {
          printWidth = 80;
          semi = true;
          tabWidth = 2;
          trailingComma = "all";
          useTabs = false;
        };
        shell = "system";
        ssh_connections = [
          {
            host = "nx";
            # projects = {
            #   dcc = "~/Projects/dublin-city-council";
            # };
          }
        ];
        tabs = {
          file_icons = true;
          git_status = true;
        };
        telemetry = {
          metrics = false;
        };
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
        theme = {
          dark = "Solarized Dark";
          light = "Solarized Light";
          mode = "dark";
        };
        ui_font_size = 16;
        ui_font_family = "Inconsolata Nerd Font Mono";
        vim_mode = true;
        working_directory = "current_project_directory";
      };
    };
  };
}
