{ config, home, pkgs, programs, ... }:

{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "hello-terminal" (builtins.readFile ./hello-terminal.sh))
      (writeShellScriptBin "set-tab-title" (builtins.readFile ./set-tab-title.sh))
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      envExtra = ''
      '';
      initContent = ''
      hello-terminal "bonjour"
      # These don't work--presumably because they are not the last items in
      # the composed .zshrc.
      # DISABLE_AUTO_TITLE="true"
      # precmd() { set-tab-title }
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
        dig = "doggo";
        top = "gtop";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
