{ config, pkgs, programs, ... }:

{
  config = {
    programs.ssh = {
      enable = true;
      matchBlocks = {
      	"r2" = {
          hostname = "135.181.200.94";
          user = "ctorgalson";
          forwardAgent = true;
	};
      };
      # extraConfig = [];
    };
  };
}

