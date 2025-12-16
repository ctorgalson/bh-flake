{ pkgs, ... }:

{
  config = {
    # @see https://mynixos.com/home-manager/options/programs.floorp
    # @see https://mynixos.com/home-manager/option/programs.floorp.profiles.%3Cname%3E.search.engines
    programs.floorp = {
      enable = true;
      enableGnomeExtensions = true;
      languagePacks = [
        "en-CA"
        "en"
        "fr"
      ];

      policies = {
        BlockAboutConfig = true;

        DefaultDownloadDirectory = "\${home}/Downloads";

        ExtensionSettings = {
          # 1password.
          "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };

          # AXE Devtools.
          "@axe-firefox-devtools" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/axe-devtools/latest.xpi";
            installation_mode = "force_installed";
          };

          # Bitwarden.
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };

          # Catppuccin Latte - Blue.
          "{68f3538d-3881-45f4-aa73-288b010b39a1}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-latte-blue-theme/latest.xpi";
            installation_mode = "force_installed";
          };

          # Catppuccin Mocha - Blue.
          "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-blue-theme/latest.xpi";
            installation_mode = "force_installed";
          };

          # Firefox Multi-Account Containers.
          "@testpilot-containers" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
            installation_mode = "force_installed";
          };

          # Obsidian Web Clipper.
          "clipper@obsidian.md" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/web-clipper-obsidian/latest.xpi";
            installation_mode = "force_installed";
          };

          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
        };
      };

      profiles = {
        home = {
          id = 0;
          name = "Home";
          settings = {
            "extensions.activeThemeID" = "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}";
          };
        };
        work = {
          containers = {
            ANRT = {
              color = "blue";
              icon = "briefcase";
              id = 1;
              name = "ANRT";
            };
            OBS = {
              color = "orange";
              icon = "cart";
              id = 2;
              name = "OBS";
            };
            UL = {
              color = "green";
              icon = "tree";
              id = 3;
              name = "UL";
            };
          };
          containersForce = true;
          id = 1;
          name = "Work";
          settings = {
            "extensions.activeThemeID" = "{68f3538d-3881-45f4-aa73-288b010b39a1}";
          };
        };
      };
    };
  };
}
