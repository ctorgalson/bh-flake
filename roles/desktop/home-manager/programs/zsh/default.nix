{ config, home, pkgs, programs, ... }:

{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "hello-terminal" (builtins.readFile ./hello-terminal.sh))
    ];

    programs.zsh = {
      defaultKeymap = "vicmd";
      enable = true;
      enableCompletion = true;
      envExtra = ''
      '';
      initContent = ''
        hello-terminal "bonjour"
        export SSH_AUTH_SOCK="''${HOME}/.bitwarden-ssh-agent.sock"
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
        df = "duf";
        diff = "riff";
        dig = "doggo";
        du = "dust";
        less = "moar";
        timelastmonth = "timew summary :annotations :ids :lastmonth";
        timelastweek = "timew summary :annotations :ids :lastweek";
        timemonth = "timew summary :annotations :ids :month";
        timetoday = "timew summary :annotations :ids :today";
        timeweek = "timew summary :annotations :ids :week";
        timeyesterday = "timew summary :annotations :ids :yesterday";
        top = "gtop";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
