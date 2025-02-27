{ lib, config, pkgs, ... }:

{
  config.users.users."ctorgalson" = {
    description = "Christopher";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARjoOuzp5vkg05GYXcvGSqwH+TPMtEWjWx6AQo+QofY"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIL8NdyEZwj8stFcSA+y6kXeP2a5reIjtPF5g3E5WkOFcAAAABHNzaDo="
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDtpZtMLS2NxNgLu+jNA5mufLH2shsKottATkgQZ0DyEAAAABHNzaDo="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDK1/S0Q2E46Pi34Q4a0/o8Y7pljVnpBfNUeLcDk/KPMHKEFwqy1WSo3eBnI8gZtA7r5tNBctFC3FPnDx+oHlmEOz/mBKmQMLyxM1+5cfP6AjpYJ17WZMtt/xdASD4EbYNhGvk1lVaaj4+wTN2gTKiP1tdp8F2kPYjbXVqJv8BstLvloC5dF+XPPdlA0/sEQOGETGzcUywqSqpQ0DDHZbN+3n24UBJWBy6bJnI973wybt3qCaWiEyyqHZxIu1+gY03Y9dH82MdIeqGVv4PsHT5x3ziIvYo/2s0AR9s236sb/fiyd4ok/YSv34F3lyIFC3NM3RtOaGOmckfloUUZp2ed+728N4XMXLOo0JXszjui0/wxyE/jiFXtM8Pmb7npzLWsPjoOwCA7acy6XYuaOl30jmKXYBfobGvfnhTmjPzQvRAZextkG+nJE5R31P0q86BaJx/zY6EOrL1vJ1vCM9eNYMOg57gI5AuRyu/grRBxpEzQp/OU72SAqUCxkqGq/sYZpoBPdIlw/9153WnvodJUpFL8SQLA3+0FDRHOK2y0b24AVqXeRhOxONAFMGwKmTFb3HrkrUSGAFEdk3JS7RNi1bym04irBx/ODPGyFoIicxfa1F8HED7rkklG9XKJXGW6hyK/Pbs5kZhv8ZSgbjD0Grh9ZGmmLr3VTz4ipwO4Gw=="
    ];
    shell = pkgs.zsh;
  };
}
