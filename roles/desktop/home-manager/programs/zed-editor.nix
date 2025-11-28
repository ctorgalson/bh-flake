{ config, lib, pkgs, programs, unstable-pkgs, ... }:

{
  config = {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "basher"
        "catppuccin"
        "csv"
        "git-firefly"
        "html"
        "jinja2"
        "nix"
        "php"
        "sql"
        "toml"
        "twig"
      ];
      package = pkgs.zed-editor;
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
        {
          context = "Terminal";
          bindings = {
            "ctrl-\\" = "workspace::ToggleBottomDock";
          };
        }
      ];
      userSettings = {
        auto_update = false;
        # Taken over by stylix
        #buffer_font_family = "Ubuntu";
        #buffer_font_size = 16;
        eslint = {
          enabled = true;
          autoFixOnSave = true;
          autoFixOnFormat = true;
          autoFixOnFormatDelay = 1500;
        };
        file_types = {
          PHP = ["*.module" "*.theme"];
        };
        # Taken over by stylix
        # font_family = "Ubuntu";
        font_features = null;
        font_size = null;
        formatter = "prettier";
        git = {
          enabled = true;
          git_status = true;
          git_gutter = "tracked_files";
        };
        languages = {
          Python = {
            tab_size = 4;
          };
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
            projects = [
              {
                paths = [
                  "~/Projects/dublin-city-council/web/themes/custom/dcc_reference"
                  "~/Projects/dublin-city-council/web/themes/custom/weatherlab"
                ];
              }
              {
                paths = [
                  "~/Projects/galway-coco-lgd"
                  "~/Projects/galway-coco-lgd/web/themes/custom/lgd"
                  "~/Projects/gcoco-lgd-theme-old"
                ];
              }
            ];
            # @see https://github.com/zed-industries/zed/issues/22251
            # @see https://zed.dev/docs/remote-development?highlight=remote#configuration
          }
        ];
        tab_size = 2;
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
        # Taken over by stylix
        # theme = {
        #   # dark = "Solarized Dark";
        #   # light = "Solarized Light";
        #   dark = "Catppuccin Macchiato";
        #   light = "Cattpuccin Latte";
        #   mode = "dark";
        # };
        # ui_font_size = 16;
        # ui_font_family = "Ubuntu";
        vim_mode = true;
        working_directory = "current_project_directory";
      };
    };
  };
}
