{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      sensible
      vim-tmux-navigator
      catppuccin
      yank
      resurrect
      continuum
    ];

    extraConfig = ''
      # set -g default-terminal "xterm-256color"
      # set -ga terminal-overrides ",*256col*:Tc"
      # set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      # set-environment -g COLORTERM "truecolor"

      set-option -g mouse on

      # yazi
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -g @catppuccin_flavour 'mocha' # frappe, macchiato, mocha, latte

      # hjkl to select and y to copy in copy mode
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind 'j' swap-pane -D
      bind 'k' swap-pane -U

      # split window at current path
      bind 'v' split-window -v -c "#{pane_current_path}"
      bind 'b' split-window -h -c "#{pane_current_path}"

      # suggested by vim-tpipeline
      set -g focus-events on
      # set -g status-style bg=default
      # set -g status-left-length 90
      # set -g status-right-length 90
      # set -g status-justify centre
    '';
  };
}
