{ config, home, pkgs, programs, ... }:

{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "hello-terminal" (builtins.readFile ./hello-terminal.sh))
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      envExtra = ''
      '';
      initContent = ''
        hello-terminal "bonjour"
        export SSH_AUTH_SOCK="''${HOME}/.bitwarden-ssh-agent.sock"
      '';
      plugins = [
        # {
        #   name = "zsh-git-alias";
        #   file = "zsh-git-alias.zsh";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "vanesterik";
        #     repo = "zsh-git-alias";
        #     rev = "main";
        #     sha256 = "sha256-hXk8+Vg6J1X+y0O8+i4cJydKJM//Bob8hrJ7jDW6kBQ=";
        #   };
        # }
      ];
      shellAliases = {
        dig = "doggo";
        top = "gtop";
        vi = "nvim";
        vim = "nvim";
        #gcz = "gcofzf";
        forgit_log = "glo";
        forgit_reflog = "grl";
        forgit_diff = "gd";
        forgit_show = "gso";
        forgit_add = "ga";
        forgit_reset_head = "grh";
        forgit_ignore = "gi";
        forgit_attributes = "gat";
        forgit_checkout_file = "gcf";
        forgit_checkout_branch = "gcb";
        forgit_branch_delete = "gbd";
        forgit_checkout_tag = "gct";
        forgit_checkout_commit = "gco";
        forgit_revert_commit = "grc";
        forgit_clean = "gclean";
        forgit_stash_show = "gss";
        forgit_stash_push = "gsp";
        forgit_cherry_pick = "gcp";
        forgit_rebase = "grb";
        forgit_blame = "gbl";
        forgit_fixup = "gfu";
        forgit_squash = "gsq";
        forgit_reword = "grw";
      };
    };
  };
}
