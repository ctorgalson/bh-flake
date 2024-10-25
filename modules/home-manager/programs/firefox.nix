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

      profiles = {
        # home = {
        #   id = 0;
        #   name = "Home";
        # # name = "default";
        #   search = {
        #     force = true;
        #     default = "DuckDuckGo";
        #     privateDefault = "DuckDuckGo";
        #     order = [ "DuckDuckGo" "Google" ];
        #   };
        #   settings = {
        #     "browser.startup.homepage" = "about:home";
        #     "browser.shell.checkDefaultBrowser" = false;
        #     "browser.shell.defaultBrowserCheckCount" = 1;
        #   };
        # };
        # work = {
        #   id = 200;
        #   name = "work";
        #   search = {
        #     force = true;
        #     default = "DuckDuckGo";
        #     privateDefault = "DuckDuckGo";
        #     order = [ "DuckDuckGo" "Google" ];
        #   };
        #   settings = {
        #     "browser.startup.homepage" = "about:home";
        #     "browser.shell.checkDefaultBrowser" = false;
        #     "browser.shell.defaultBrowserCheckCount" = 1;
        #   };
        # };
      };
    };
  };
}
