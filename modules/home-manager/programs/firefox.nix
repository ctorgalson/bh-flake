{ config, pkgs, programs, ... }:

{
  config = {
    programs.firefox = {
      enable = true;

      profiles = {
        default = {
          isDefault = true;
          search = {
            force = true;
            default = "DuckDuckGo";
            privateDefault = "DuckDuckGo";
            order = [ "DuckDuckGo" "Google" ];
          };
          settings = {
            "browser.startup.homepage" = "about:home";
            "browser.shell.checkDefaultBrowser" = false;
            "browser.shell.defaultBrowserCheckCount" = 1;
          };
        };
        work = {
          search = {
            force = true;
            default = "DuckDuckGo";
            privateDefault = "DuckDuckGo";
            order = [ "DuckDuckGo" "Google" ];
          };
          settings = {
            "browser.startup.homepage" = "about:home";
            "browser.shell.checkDefaultBrowser" = false;
            "browser.shell.defaultBrowserCheckCount" = 1;
          };
        };
      };
    };
  };
}
