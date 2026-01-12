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
      profiles = {
        newwork = {
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
          name = "Home";
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
        work = {
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
          name = "Work";
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
