{ pkgs, ... }:

{
  config = {
    programs = {
      lazygit = {
        enable = true;
        enableZshIntegration = true;
        # @see https://github.com/wimpysworld/nix-config/blob/8f4f0c72b686996d31616d5e02758b240dde8a13/home-manager/_mixins/development/git/default.nix#L31
        settings = {
          # Skip intro popups when opening lazygit
          disableStartupPopups = true;
          # Skip "Press enter to return to lazygit" after subprocesses
          # CUA-style keybindings
          keybinding = {
            universal = {
              quit = "<c-q>"; # Ctrl+Q to quit (CUA standard)
            };
          };
          promptToReturnFromSubprocess = false;
          # Nix manages the package, so disable update checks
          update.method = "never";

          git = {
            # Auto-fetch from remote periodically: No, too irritating with
            # ssh-confirmation required.
            autoFetch = false;
            # Use delta for diffs with side-by-side view (pagers is an array)
            pagers = [
              { pager = "${pkgs.delta}/bin/delta --dark --paging=never"; }
            ];
          };

          gui = {
            # Accordion effect - expand the focused side panel
            expandFocusedSidePanel = true;
            # Use fuzzy filtering when searching with '/'
            filterMode = "fuzzy";
            # Show Nerd Font icons (requires Nerd Font in terminal)
            nerdFontsVersion = "3";
            # Show keybindings in the bottom status line (like gitui does)
            showBottomLine = true;
            # Show jump-to-window keybindings (1-5) in window titles
            showPanelJumps = true;
            # Show a random tip in the command log when lazygit starts
            showRandomTip = true;
            # Show all branches log instead of dashboard (hides donate link)
            statusPanelView = "allBranchesLog";
            tabWidth = 2;

            theme = {
              # Use Catppuccin colours.
              # @see https://github.com/catppuccin/lazygit?tab=readme-ov-file#apply-the-theme
              activeBorderColor = [
                "#89b4fa"
                "bold"
              ];
              inactiveBorderColor = [
                "#a6adc8"
              ];
              optionsTextColor = [
                "#89b4fa"
              ];
              selectedLineBgColor = [
                "#313244"
              ];
              cherryPickedCommitBgColor = [
                "#45475a"
              ];
              cherryPickedCommitFgColor = [
                "#89b4fa"
              ];
              unstagedChangesColor = [
                "#f38ba8"
              ];
              defaultFgColor = [
                "#cdd6f4"
              ];
              searchingActiveBorderColor = [
                "#f9e2af"
              ];
            };
          };

          # gui:
          #  # Use the mocha catppuccin theme
          #  theme:
          #    activeBorderColor:
          #      - '#89b4fa'
          #      - bold
          #    inactiveBorderColor:
          #      - '#a6adc8'
          #    optionsTextColor:
          #      - '#89b4fa'
          #    selectedLineBgColor:
          #      - '#313244'
          #    cherryPickedCommitBgColor:
          #      - '#45475a'
          #    cherryPickedCommitFgColor:
          #      - '#89b4fa'
          #    unstagedChangesColor:
          #      - '#f38ba8'
          #    defaultFgColor:
          #      - '#cdd6f4'
          #    searchingActiveBorderColor:
          #      - '#f9e2af'

        };
      };
    };
  };
}
