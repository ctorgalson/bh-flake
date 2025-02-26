{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      age
      ansible
      # bitwarden-cli
      ddev
      diceware
      diffpdf
      fd
      ffmpeg
      gcc
      glow                        # markdown reader
      gtop                        # modern top replacement
      hddtemp
      httpie                      # http client
      imagemagick                 # image-creation, manipulation utility
      jq                          # for querying, slicing and dicing yaml
      # https://superuser.com/questions/1027608/how-to-read-an-acsm-file-on-linux#1775619
      #
      # # Use your username and password from https://account.adobe.com
      # This registers your device so only needs to be done once.
      # adept_activate -u user -p pass
      #
      # Download the ACSM file
      # acsmdownloader -f myfile.acsm
      #
      # Decrypt
      # adept_remove file.pdf
      libgourou                   # for downloading and decrypting ebooks
      lm_sensors
      lynis                       # security scanning utility
      nodejs_22                   # up-to-date-ish version of node
      orpie
      pciutils
      platformsh                  # platform.sh cli tool
      python313                   # up-to-date-ish version of python
      #quickemu
      rich-cli
      shellcheck                  # for linting bash scripts
      sops                        # for secrets management via sops(-nix)
      sqlite
      # tmux
      tree                        # for displaying directory structure
      tree-sitter                 # for neovim usage
      unison
      unzip                       # basic unzipping utility
      wl-clipboard
      yq                          # for querying, slicing and dicing yaml
      yt-dlp                      # for downloading Youtube & other videos
      yubikey-manager             # newer Yubikey customization tool 
      yubikey-personalization     # older Yubikey customization tool
      zip                         # basic zip-creation utility
      # for use with npm pkg glyphhanger
      brotli
      python313Packages.fonttools
      zopfli
    ];
  };
}
