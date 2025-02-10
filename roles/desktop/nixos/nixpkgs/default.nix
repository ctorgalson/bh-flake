{ allowedUnfreePackages, inputs, lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowedUnfreePackages;
  };
}
