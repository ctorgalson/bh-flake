{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      age                         # encryption utility
      ansible                     # server provision + automation
      bitwarden-cli               # bw command
      dwt1-shell-color-scripts    # Colour scripts and tools
      ddev                        # dev servers
      diceware                    # passphrase generator
      diffpdf                     # pdf diff tool
      dmidecode                   # bios info utility
      doggo                       # dig replacement
      fd                          # find replacement
      ffmpeg                      # media convertor
      figlet                      # ascii fonts
      gcc                         # c compiler
      glow                        # markdown reader
      gnome-screenshot            # for reports.sh
      go                          # go language
      golangci-lint
      # goose-cli                   # Local LLM runner: WRETCHEDLY frustrating.
      gtop                        # top replacement
      hddtemp                     # hard drive temperature monitor
      httpie                      # curl-like tool
      imagemagick                 # image-manipulation
      jq                          # json query + manipulation tool
      # https://superuser.com/questions/1027608/how-to-read-an-acsm-file-on-linux#1775619
      #
      # # Use your username and password from https://account.adobe.com
      # This registers your device so only needs to be done once.
      #
      # adept_activate -u user -p pass
      #
      # Download the ACSM file
      # acsmdownloader -f myfile.acsm
      #
      # Decrypt
      # adept_remove file.pdf
      lazygit
      libgourou
      lm_sensors
      lynis
      moar                        # less replacement
      nixos-icons
      nodejs_22
      ollama                      # local LLM model
      orpie
      pciutils
      platformsh                  # platform.sh cli tool
      plymouth
      python314
      #quickemu
      riffdiff                    # diff replacement w/syntax highlighting etc.
      shellcheck
      sops
      sqlite
      # timewarrior
      # tmux
      tree
      tree-sitter
      unison
      unzip
      wl-clip-persist             # Wayland clipboard contents "preserver"
      wl-clipboard                # Wayland clipboard manager
      yq
      yt-dlp
      # yubikey-manager
      # yubikey-personalization
      # yubioath-flutter
      zip
      zsh-forgit                  # A utility tool powered by fzf for using git interactively.
    ];
  };
}
