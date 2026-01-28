{ config, host, lib, pkgs, programs, ... }:

let
  # Common Firefox settings for all profiles
  commonSettings = {
    "browser.startup.homepage" = "about:home";
    "browser.search.region" = "CA";
    "browser.search.isUS" = false;
    "distribution.searchplugins.defaultLocale" = "en-CA";
    "general.useragent.locale" = "en-CA";
    "browser.bookmarks.showMobileBookmarks" = true;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.shell.defaultBrowserCheckCount" = 1;

    # Theme
    "extensions.activeThemeID" = "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}";

    # Startup: Open previous windows and tabs
    # https://support.mozilla.org/en-US/kb/restore-previous-session
    "browser.startup.page" = 3;

    # Language: Set accept languages for web content
    # https://firefox-source-docs.mozilla.org/intl/locale.html
    "intl.accept_languages" = "en-CA,en-US,fr";

    # Language: Set default UI language
    # https://firefox-source-docs.mozilla.org/intl/locale.html
    "intl.locale.requested" = "en-CA";

    # Delete files downloaded in private browsing when all private windows are closed
    # https://chipp.in/news/firefox-how-to-delete-files-download-in-private-browsing-automatically/
    "browser.download.deletePrivate" = true;

    # Digital Rights Management (DRM) Content
    # https://support.mozilla.org/en-US/kb/enable-drm
    "media.eme.enabled" = true;

    # Home: Web Search
    # https://firefox-source-docs.mozilla.org/browser/extensions/newtab/docs/v2-system-addon/preferences.html
    "browser.newtabpage.activity-stream.showSearch" = true;

    # Home: Weather
    # https://firefox-source-docs.mozilla.org/browser/extensions/newtab/docs/v2-system-addon/preferences.html
    "browser.newtabpage.activity-stream.showWeather" = true;

    # Home: Shortcuts (Top Sites)
    # https://firefox-source-docs.mozilla.org/browser/extensions/newtab/docs/v2-system-addon/preferences.html
    "browser.newtabpage.activity-stream.feeds.topsites" = true;

    # Home: Recommended stories (Pocket) - disabled
    # https://firefox-source-docs.mozilla.org/browser/extensions/newtab/docs/v2-system-addon/preferences.html
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

    # Home: Support Firefox (snippets) - disabled
    # https://firefox-source-docs.mozilla.org/browser/extensions/newtab/docs/v2-system-addon/preferences.html
    "browser.newtabpage.activity-stream.feeds.snippets" = false;

    # Home: Recent Activity (Highlights)
    # https://firefox-source-docs.mozilla.org/browser/extensions/newtab/docs/v2-system-addon/preferences.html
    "browser.newtabpage.activity-stream.feeds.section.highlights" = true;

    # Privacy: Enhanced Tracking Protection - Strict
    # https://support.mozilla.org/en-US/kb/enhanced-tracking-protection-firefox-desktop
    "browser.contentblocking.category" = "strict";

    # Privacy: Tell websites to not sell or share my data (Global Privacy Control)
    # https://globalprivacycontrol.org/
    "privacy.globalprivacycontrol.enabled" = true;

    # Privacy: Passwords - disable Firefox password manager
    # Using 1Password/Bitwarden instead
    "signon.rememberSignons" = false;

    # Privacy: Payment methods - disable
    # https://support.mozilla.org/en-US/kb/credit-card-autofill
    "extensions.formautofill.creditCards.enabled" = false;

    # Privacy: Addresses and more - disable
    # https://support.mozilla.org/en-US/kb/autofill-address-forms-firefox
    "extensions.formautofill.addresses.enabled" = false;

    # Privacy: Firefox Data Collection and Use - mostly disabled
    # https://github.com/K3V1991/Disable-Firefox-Telemetry-and-Data-Collection
    # Allow ping-centre for Mozilla usage estimates
    "datareporting.healthreport.uploadEnabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.archive.enabled" = false;
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.ping-centre.telemetry" = true;  # Allow for usage estimates
    "toolkit.telemetry.bhrPing.enabled" = false;
    "toolkit.telemetry.firstShutdownPing.enabled" = false;
    "toolkit.telemetry.newProfilePing.enabled" = false;
    "toolkit.telemetry.shutdownPingSender.enabled" = false;
    "toolkit.telemetry.updatePing.enabled" = false;

    # DNS over HTTPS: TRR-first mode with fallback
    # https://firefox-source-docs.mozilla.org/networking/dns/dns-over-https-trr.html
    # Mode 2: TRR by default, fallback to native resolver if needed
    "network.trr.mode" = 2;
    # Default DoH provider (Mozilla/Cloudflare)
    "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
    # Alternative providers:
    # "network.trr.uri" = "https://dns.google/dns-query";
    # "network.trr.uri" = "https://dns.quad9.net/dns-query";

    # Sidebar: Enable new sidebar and show on hover (Firefox 136+)
    # https://www.askvg.com/tips-tweak-and-customize-firefox-sidebar-and-vertical-tabs-like-a-pro/
    "sidebar.revamp" = true;
    "sidebar.visibility" = "hide-sidebar";  # Show on hover

    # Firefox Sync: Sync dynamic user data only, not Nix-managed config
    # https://firefox-source-docs.mozilla.org/services/sync/
    "services.sync.engine.addons" = false;      # Extensions managed by Nix
    "services.sync.engine.prefs" = false;       # Settings managed by Nix
    "services.sync.engine.bookmarks" = true;    # User bookmarks
    "services.sync.engine.history" = true;      # Browsing history
    "services.sync.engine.tabs" = true;         # Open tabs
    "services.sync.engine.passwords" = false;   # Using 1Password/Bitwarden
    "services.sync.engine.addresses" = false;   # Already disabled
    "services.sync.engine.creditcards" = false; # Already disabled
  };

  # Common containers (based on newwork profile, minus work-specific ones)
  commonContainers = {
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
    msft = {
      color = "blue";
      icon = "circle";
      id = 8;
      name = "MSFT";
    };
  };
in
{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "homefox" ''
        firefox -P "Home (new)"
      '')
      (writeShellScriptBin "workfox" ''
        firefox -P "Work (new)"
      '')
    ];

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

      policies = {
        BlockAboutConfig = false;
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

          # Catppuccin Latte - Blue (Official).
          "{68f3538d-3881-45f4-aa73-288b010b39a1}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3989616/catppuccin_latte_blue_git-2.0.xpi";
            installation_mode = "force_installed";
          };

          # Catppuccin Mocha - Blue (Official).
          "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3989617/catppuccin_mocha_blue_git-2.0.xpi";
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

        # Lock sync engine preferences to prevent Firefox Sync from overriding them
        # https://mozilla.github.io/policy-templates/#preferences
        Preferences = {
          "services.sync.engine.addresses" = {
            Value = false;
            Status = "locked";
          };
          "services.sync.engine.creditcards" = {
            Value = false;
            Status = "locked";
          };
          "services.sync.client.name" = {
            Value = host.hostname;
            Status = "locked";
          };
        };

        OfferToSaveLogins = false;
      };

      profiles = {
        newhome = {
          containers = commonContainers // {
            # Home-specific containers
            banking = {
              color = "green";
              icon = "dollar";
              id = 1;
              name = "Banking";
            };
            facebook = {
              color = "blue";
              icon = "fence";
              id = 9;
              name = "Facebook";
            };
            housing = {
              color = "red";
              icon = "vacation";
              id = 10;
              name = "Housing search";
            };
            linkedin = {
              color = "blue";
              icon = "circle";
              id = 11;
              name = "Linkedin";
            };
            media = {
              color = "yellow";
              icon = "fence";
              id = 12;
              name = "Media";
            };
            proton = {
              color = "purple";
              icon = "circle";
              id = 13;
              name = "Proton";
            };
            shopping = {
              color = "yellow";
              icon = "cart";
              id = 14;
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
          settings = commonSettings // {
            "browser.newtabpage.pinned" = [
              {
                name = "bedlamhotel.com Proton Mail";
                url = "https://mail.proton.me/u/0/inbox";
              }
              {
                name = "torgalson.net Gmail";
                url = "https://mail.google.com/mail/u/0/#inbox";
              }
              {
                name = "torgalson.net Google Maps";
                url = "https://www.google.com/maps";
              }
            ];
          };
        };
        newwork = {
          containers = commonContainers // {
            # Work-specific containers
            anrt = {
              color = "blue";
              icon = "briefcase";
              id = 1;
              name = "ANRT";
            };
            lgd = {
              color = "turquoise";
              icon = "vacation";
              id = 6;
              name = "LGD";
            };
            hm = {
              color = "yellow";
              icon = "circle";
              id = 15;
              name = "HM";
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
          settings = commonSettings // {
            "browser.newtabpage.pinned" = [
              {
                name = "Annertech Teams";
                url = "https://teams.microsoft.com/v2/";
              }
              {
                name = "Annertech Gmail";
                url = "https://mail.google.com/mail/u/0/#inbox";
              }
              {
                name = "Annertech Teamwork";
                url = "https://projects.annertech.com";
              }
              {
                name = "Annertech Gitlab";
                url = "https://code.anner.ie";
              }
              {
                name = "Upsun";
                url = "https://upsun.com";
              }
            ];
          };
        };
      };
    };
  };
}
