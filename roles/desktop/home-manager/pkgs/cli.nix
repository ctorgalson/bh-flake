{ config, pkgs, home, unstable-pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      # Github
      act                         # local Github Actions runner
      gh                          # Github cli tool

      # Automation
      ansible                     # server provision + automation

      # Communications
      signal-cli                  # Cli version of Signal for sending msgs

      # Development
      bruno-cli                   # cli for Bruno API tester
      gh-dash                     # Github cli dashboard
      go                          # go language
      golangci-lint               # golang linting tool
      httpie                      # curl-like tool
      imagemagick                 # image-manipulation
      jq                          # json query + manipulation tool
      nodejs_22                   # nodejs 22
      python314                   # python 3.14
      scc                         # Go-based code counter
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
      unstable-pkgs.moor          # less replacement (not in 25.05 stable)
      riffdiff                    # diff replacement w/syntax highlighting etc.

      # Other cli
      emoji-picker                # cli emoji picker
      figlet                      # ascii fonts
      diffpdf                     # pdf diff tool
      dmidecode                   # bios info utility
      ffmpeg                      # media convertor
      gcc                         # c compiler
      links2                      # cli (text-only) browser
      qrencode                    # QR code generator
      rpi-imager                  # Raspberry Pi imager
      tldr                        # simplified man pages
      pdftk                       # cli PDF editor
      tree                        # list contents of directories in tree form
      unzip                       # Unzip files/directories
      wl-clip-persist             # Wayland clipboard contents "preserver"
      wl-clipboard                # Wayland clipboard manager
      zip                         # Compress files/directories to .zip

      # AI cli
      # aider-chat                  # Coding-focused AI Asssistant
      # ollama                      # local LLM model
      # See ./claude-code/
      #claude-code                 # Package for Claude in the terminal

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
      sysstat                     # performance monitoring tools

      # Nix-specific
      colmena                     # NixOS deployment tool
      nh                          # Nix cli utilities
      nixos-icons                 # icons of the Nix logo

      # VMs
      qemu                        # VM emulator (includes ARM support)
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
