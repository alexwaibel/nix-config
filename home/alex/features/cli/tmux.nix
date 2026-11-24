{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    escapeTime = 1;
    # Applies to both windows and panes
    baseIndex = 1;
    mouse = true;
    terminal = "screen-256color";
    sensibleOnTop = false;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      tokyo-night-tmux
    ];
    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:Tc"

      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Split panes with | and - which are easier to remember than % and "
      bind | split-window -h
      bind - split-window -v

      # Move between panes with Prefix h,j,k,l
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Quickly move between windows
      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+

      # Resize panes with Prefix H,J,K,L
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
    '';
  };
}
