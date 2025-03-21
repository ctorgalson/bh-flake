{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/freedesktop/tracker/miner/files" = {
        index-recursive-directories = [
          "&DOCUMENTS"
          "&MUSIC"
          "&VIDEOS"
          "/home/ctorgalson/Storage/Dev"
          "/home/ctorgalson/Storage/Documents"
          "/home/ctorgalson/Storage/Nextcloud"
        ];

        index-single-directories = [
          "$HOME"
        ];
      };
    };
  };
}
