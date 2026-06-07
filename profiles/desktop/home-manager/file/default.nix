{ config, lib, pkgs, home, ... }:

{
  imports = [
    ./orca.nix
  ];

  config = {
    # home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    #   mount_path="/run/media/''${USER}/Storage"
    #   home_dirs=( 'Dev' 'Documents' 'Music' 'Nextcloud' 'Videos' )

    #   if [ -d "''${mount_path}" ]; then
    #     for home_dir in "''${home_dirs[@]}"; do
    #       src_path="''${mount_path}/''${home_dir}"
    #       dest_path="''${HOME}/''${home_dir}"

    #       # Ensure the source directory exists.
    #       mkdir -p "''${src_path}"
    #       
    #       # Is this a directory and NOT a symlink?
    #       if [ -d "''${dest_path}" ] && [ ! -L "''${dest_path}" ]; then
    #         if [ -z "$(\ls -A "''${dest_path}")" ]; then
    #           rmdir "''${dest_path}"
    #         else
    #           echo "Directory not empty (''${dest_path})"
    #           exit 1
    #         fi
    #       # Is this a nonexistent directory?
    #       elif [ ! -d "''${dest_path}" ]; then
    #         ln -s "''${src_path}" "''${dest_path}"
    #       fi
    #     done
    #   fi
    # '';
  };
}
