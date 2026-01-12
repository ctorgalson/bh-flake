{ config, pkgs, programs, ... }:

{
  config = {
    # References
    #
    # - https://github.com/Misterio77/nix-config/blob/main/home/gabriel/features/desktop/common/firefox.nix
    # - https://home-manager-options.extranix.com/?query=firefox&release=release-24.05
    # - https://github.com/nix-community/home-manager/blob/master/modules/programs/firefox.nix
    # - https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
    programs.firefox = {
      enable = true;
      enableGnomeExtensions = true;
      languagePacks = [
        "en-CA"
        "en"
        "fr"
      ];
      #profiles = {
      #  # default = {
      #  #   id = 0;
      #  #   name = "Home";
      #  #   search = {
      #  #     force = true;
      #  #     default = "DuckDuckGo";
      #  #     privateDefault = "DuckDuckGo";
      #  #     order = [ "DuckDuckGo" "Google" ];
      #  #   };
      #  #   settings = {
      #  #     "browser.startup.homepage" = "about:home";
      #  #     "browser.shell.checkDefaultBrowser" = false;
      #  #     "browser.shell.defaultBrowserCheckCount" = 1;
      #  #   };
      #  # };
      #  # work = {
      #  #   id = 200;
      #  #   name = "work";
      #  #   search = {
      #  #     force = true;
      #  #     default = "DuckDuckGo";
      #  #     privateDefault = "DuckDuckGo";
      #  #     order = [ "DuckDuckGo" "Google" ];
      #  #   };
      #  #   settings = {
      #  #     "browser.startup.homepage" = "about:home";
      #  #     "browser.shell.checkDefaultBrowser" = false;
      #  #     "browser.shell.defaultBrowserCheckCount" = 1;
      #  #   };
      #  # };
      #};

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
          #
          # TODO: do this in a way that works...
          "{68f3538d-3881-45f4-aa73-288b010b39a1}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-latte-blue-theme/latest.xpi";
            installation_mode = "force_installed";
          };

          # Catppuccin Mocha - Blue.
          #
          # TODO: do this in a way that works...
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

        OfferToSaveLogins = false;
      };

      profiles = {
        newhome = {
          containers = {
            apple = {
              color = "red";
              icon = "circle";
              id = 11;
              name = "Apple";
            };
            banking = {
              color = "green";
              icon = "dollar";
              id = 1;
              name = "Banking";
            };
            facebook = {
              color = "blue";
              icon = "fence";
              id = 2;
              name = "Facebook";
            };
            google = {
              color = "pink";
              icon = "circle";
              id = 3;
              name = "Google";
            };
            housing = {
              color = "red";
              icon = "vacation";
              id = 4;
              name = "Housing search";
            };
            infrastructure = {
              color = "purple";
              icon = "circle";
              id = 5;
              name = "Infrastructure";
            };
            linkedin = {
              color = "blue";
              icon = "circle";
              id = 10;
              name = "Linkedin";
            };
            media = {
              color = "yellow";
              icon = "fence";
              id = 6;
              name = "Media";
            };
            personal = {
              color = "blue";
              icon = "fingerprint";
              id = 7;
              name = "Personal";
            };
            proton = {
              color = "purple";
              icon = "circle";
              id = 8;
              name = "Proton";
            };
            shopping = {
              color = "yellow";
              icon = "cart";
              id = 9;
              name = "Shopping";
            };
          };
          containersForce = true;
          id = 0;
          name = "Home (new)";
          search = {
            default = "ddg";
            force = true;
            engines = {
              nix-packages = {
                name = "Nix Packages";
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nix" ];
              };
            };
            order = [
              "ddg"
              "google"
            ];
            privateDefault = "ddg";
          };
          settings = {
            "extensions.activeThemeID" = "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}";
            browser = {
              startup = {
                homepage = "about:home";
              };
              shell = {
                checkDefaultBrowser = false;
                defaultBrowserCheckCount = 1;
              };
            };
          };
        };
        newwork = {
          containers = {
            anrt = {
              color = "blue";
              icon = "briefcase";
              id = 1;
              name = "ANRT";
            };
            apple = {
              color = "red";
              icon = "circle";
              id = 7;
              name = "Apple";
            };
            obs = {
              color = "orange";
              icon = "cart";
              id = 2;
              name = "OBS";
            };
            ul = {
              color = "green";
              icon = "tree";
              id = 3;
              name = "UL";
            };
            google = {
              color = "pink";
              icon = "circle";
              id = 4;
              name = "Google";
            };
            infrastructure = {
              color = "purple";
              icon = "circle";
              id = 5;
              name = "Infrastructure";
            };
            lgd = {
              color = "turquoise";
              icon = "vacation";
              id = 6;
              name = "LGD";
            };
          };
          containersForce = true;
          id = 1;
          name = "Work (new)";
          # Todo: search engines
          # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.search.engines
          search = {
            default = "ddg";
            force = true;
            engines = {
              nix-packages = {
                name = "Nix Packages";
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nix" ];
              };
            };
            order = [
              "ddg"
              "google"
            ];
            privateDefault = "ddg";
          };
          settings = {
            "extensions.activeThemeID" = "{68f3538d-3881-45f4-aa73-288b010b39a1}";
          };
        };
      };
    };
  };
}
