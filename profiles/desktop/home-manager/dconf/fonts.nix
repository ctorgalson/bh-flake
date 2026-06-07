{ config, lib, programs, ... }:

{
  options = {
    fonts.enable = lib.mkEnableOption "enable dconf fonts module";

    fonts.fontName = lib.mkOption {
      default = "Cantarell 10";
      description = ''
        default interface font and size
      '';
    };

    fonts.documentFontName = lib.mkOption {
      default = "Cantarell 10";
      description = ''
        default document font and size
      '';
    };

    fonts.monospaceFontName = lib.mkOption {
      default = "Source Code Pro 10";
      description = ''
        default monospace font and size
      '';
    };
  };

  config = lib.mkIf config.fonts.enable {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        font-name = "${config.fonts.fontName}";
        document-font-name = "${config.fonts.documentFontName}";
        monospace-font-name = "${config.fonts.monospaceFontName}";
      };
    };
  };
}
