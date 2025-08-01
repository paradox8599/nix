{
  pkgs,
  # config,
  ...
}:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    # newSession = true;
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
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set-option -g mouse on

      # yazi
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -g history-limit 100000
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
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
      bind 'h' split-window -h -c "#{pane_current_path}"

      # auto determine split direction
      bind 'i' run-shell " \
        if [ $(( \$(tmux display -p '8*#{pane_width}-20*#{pane_height}') )) -lt 0 ]; then \
          tmux splitw -v -c '#{pane_current_path}'; \
        else \
          tmux splitw -h -c '#{pane_current_path}'; \
        fi"

      # suggested by vim-tpipeline
      set -g focus-events on
      # set -g status-style bg=default
      # set -g status-left-length 90
      # set -g status-right-length 90
      # set -g status-justify centre
    '';
  };

}
