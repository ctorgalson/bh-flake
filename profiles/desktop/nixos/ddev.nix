{ config, lib, pkgs, ... }:

let
  # DDEV projects
  ddevProjects = [
    # Add your project names here, e.g.:
    # "myproject"
    # "anotherproject"
  ];
in
{
  # Enable Docker for DDEV
  virtualisation.docker.enable = true;
  # Pin to docker_29: nixos-25.11's `pkgs.docker` alias still points at the
  # now-insecure docker_28. Revisit when upgrading to a newer stable channel.
  virtualisation.docker.package = pkgs.docker_29;

  # Install DDEV system-wide
  environment.systemPackages = with pkgs; [
    ddev
  ];

  # Generate /etc/hosts entries for DDEV projects
  networking.extraHosts = lib.concatMapStringsSep "\n"
    (project: "127.0.0.1 ${project}.ddev.site")
    ddevProjects;
}
