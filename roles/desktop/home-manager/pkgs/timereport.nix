{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "timereport" ''
        function print_help {
          printf "\nThis script accepts the following arguments:\n\n"
          printf "  -m / --month [required]: the numeric month to report on (e.g. 1, 01, 11)\n"
          printf "  -y / --year  [required]: the four-digit year to report on (e.g. 2024)\n"
          printf "  -f / --force [optional]: a boolean flag to force the script to overwrite\n"
          printf "                           existing files (requires no value)\n"
        }

        unset force

        # Take year and month as arguments.
        if [ $# -eq 0 ]; then
          print_help
          exit 1
        fi

        while [ $# -gt 0 ]; do
          case "$1" in
            --year*|-y*)
              if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no `=`
              year="''${1#*=}"
              ;;
            --month*|-m*)
              if [[ "$1" != *=* ]]; then shift; fi
              printf -v month "%02d" "''${1#*=}"
              ;;
            --force|-f)
              force=1
              ;;
            --help|-h)
              print_help
              exit 0
              ;;
            *)
              >&2 printf "Error: Invalid argument\n"
              exit 1
              ;;
          esac
          shift
        done

        if [[ ! -v year || ! -v month ]]; then
          print_help
          exit 1
        fi

        # Compute other date info.
        monthname=$(date -d "''${year}-''${month}-01" '+%B')
        lastmonthday=$(date -d "''${month}/1 + 1 month - 1 day" '+%d')

        # Set up filepaths and names.
        directorypath="''${HOME}/Storage/Documents/bh/''${year}/clients/AT/''${monthname,,}"
        jsonfilename="time-''${year}-''${month}.json"
        yamlfilename="timew-hours--''${year}-''${month}-01-to-''${year}-''${month}-''${lastmonthday}.yml"

        # Create directory.
        mkdir -p "$directorypath"

        # Write files.
        jsonfilepath="''${directorypath}/''${jsonfilename}"
        yamlfilepath="''${directorypath}/''${yamlfilename}"

        if [[ -f $jsonfilepath || -f $yamlfilepath ]] && [[ ! -v force ]]; then
          printf "\nOne or more files already exists for the given month.\n"
          printf "\nPlease check your -y/--year and -m/--month arguments, or re-run the command with -f/--force.\n"
          exit 1
        else
          timew export from "''${year}-''${month}-01T00:00:00" to "''${year}-''${month}-''${lastmonthday}T23:59:59" \
            | tee "$jsonfilepath" \
            | yq -y > "$yamlfilepath"

          printf "\nWrote the following files to disk:\n\n  - %s\n  - %s\n" "$jsonfilepath" "$yamlfilepath"
        fi

      '')
    ];
  };
}
