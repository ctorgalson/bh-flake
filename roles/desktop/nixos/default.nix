{ allowedUnfreePackages, inputs, lib, pkgs, stylix, ... }:

{
  imports = [
    ./environment
    ./i18n
    ./networking
    ./nix
    ./nixpkgs
    ./programs
    ./security
    ./services
    ./system
    ./time
    ./users
    ./virtualisation
  ];  

  stylix = {
    enable = true;

    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      monospace = {
        name = "UbuntuMono Nerd Font";
        package = pkgs.nerd-fonts.ubuntu-mono;
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 8;
        terminal = 11;
      };
    };

    image = ../../../images/IMG_0952.jpg;

    targets = {
      gnome = {
        enable = true;
      };

      grub = {
        enable = true;
        useWallpaper = true;
      };

      nixos-icons = {
        enable = true;
      };

      plymouth = {
        enable = true;
      };
    };

    # Tmux (?)

    # Zed

    # Zellij
  };
}
