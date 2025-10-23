{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      # Github
      act                         # local Github Actions runner
      gh                          # Github cli tool

      # Automation
      ansible                     # server provision + automation

      # Development
      ddev                        # dev servers
      httpie                      # curl-like tool
      go                          # go language
      golangci-lint               # golang linting tool
      imagemagick                 # image-manipulation
      jq                          # json query + manipulation tool
      nodejs_22                   # nodejs 22
      python314                   # python 3.14
      shellcheck                  # shell script analysis tool
      sqlite                      # Small, fast SQL db
      upsun                       # upsun (formerly platform.sh) cli tool
      yq                          # yaml query + manipulation tool

      # Modern cli
      doggo                       # dig replacement
      duf                         # df replacement
      dust                        # du replacement
      fd                          # find replacement
      glow                        # markdown reader
      gtop                        # top replacement
      moor                        # less replacement
      riffdiff                    # diff replacement w/syntax highlighting etc.

      # Other cli
      figlet                      # ascii fonts
      diffpdf                     # pdf diff tool
      dmidecode                   # bios info utility
      ffmpeg                      # media convertor
      gcc                         # c compiler
      links2                      # cli (text-only) browser
      tree                        # list contents of directories in tree form
      unzip                       # Unzip files/directories
      wl-clip-persist             # Wayland clipboard contents "preserver"
      wl-clipboard                # Wayland clipboard manager
      zip                         # Compress files/directories to .zip

      # AI cli
      # aider-chat                  # Coding-focused AI Asssistant
      # ollama                      # local LLM model
      claude-code                 # Package for Claude in the terminal

      # Security
      age                         # encryption utility
      bitwarden-cli               # bw command
      diceware                    # passphrase generator
      lynis                       # security audit and hardening tool
      openssl                     # SSL and TLS protocols
      sops                        # Secrets management tool

      # Hardware
      hddtemp                     # hard drive temperature monitor
      lm_sensors                  # Temp, voltage, fan monitoring tools

      # System
      catppuccin-plymouth         # boot utility theme
      plymouth                    # boot utility

      # Nix-specific
      nixos-icons                 # icons of the Nix logo

      # VMs
      quickemu                    # VM puller, runner

      # Media
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
      libgourou                   # Adobe Editions fulfillment
      yt-dlp                      # Youtube/video-downloader
    ];
  };
}
