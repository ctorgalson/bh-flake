{ config, host, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/freedesktop/tracker/miner/files" = {
        index-recursive-directories = [
          "&DOCUMENTS"
          "&MUSIC"
          "&VIDEOS"
          "/home/${host.username}/Storage/Dev"
          "/home/${host.username}/Storage/Documents"
          "/home/${host.username}/Storage/Nextcloud"
        ];

        index-single-directories = [
          "$HOME"
        ];
      };
    };
  };
}
