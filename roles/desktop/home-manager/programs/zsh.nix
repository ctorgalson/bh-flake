{ config, pkgs, programs, ... }:

{
  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      envExtra = ''
        # Searches for existing session and attaches to the first in the list.
        #
        # @see https://zellij.dev/documentation/integration.html#autostart-on-shell-creation
        if [[ -z "$ZELLIJ" ]]; then
          # Get the first non-EXITED session.
          last_session="$(zellij list-sessions | grep -v 'EXITED' | head -1 | cut -d' ' -f1)"
          
          # If we found one, attach to it. Otherwise, just start Zellij.
          if [[ -n "$last_session" ]]; then
            zellij attach "$last_session"
          else
            zellij
          fi

          if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
            exit
          fi
        fi
      '';
      plugins = [
        {
          name = "zsh-git-alias";
          file = "zsh-git-alias.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "vanesterik";
            repo = "zsh-git-alias";
            rev = "main";
            sha256 = "sha256-hXk8+Vg6J1X+y0O8+i4cJydKJM//Bob8hrJ7jDW6kBQ=";
          };
        }
      ];
      shellAliases = {
        top = "gtop";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
