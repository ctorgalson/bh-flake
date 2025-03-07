{ config, lib, pkgs, ... }:

{
  imports = [
    ./dconf
    ./file
    ./pkgs
    ./programs
    ./services
  ];

  config = {
    home = {
      activation = {
        directories = lib.hm.dag.entryAfter ["WriteBoundary"] ''
          # Directories relative to $HOME.
          declare -a directories=(
            ".config/sops/age"
            "Storage/Dev/AT"
            "Storage/Dev/BH"
            "Storage/Documents"
            "Storage/Nextcloud"
          )

          if [[ -d "$HOME/Storage" && -d "$HOME/.config" ]]; then
            for directory in "''${directories[@]}"
            do
              mkdir -p "$directory"
            done
          fi

        '';
      };
      username = "ctorgalson";
      homeDirectory = "/home/ctorgalson";

      sessionVariables = {
        VISUAL = "nvim";
        GIT_EDITOR="vim -c 'set buftype='";
      };

      stateVersion = "24.05";
    };

    programs.home-manager.enable = true;
  };
}
