{ ... }:

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
          "uBlock0@raymondhill.net" = {
            default_area = "menupanel";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
        };
      };
    };
  };
}
