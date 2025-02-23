{ config, inputs, lib, pkgs, ... }: 

{
  imports = [
    ./dconf
    ./programs
  ];
}
