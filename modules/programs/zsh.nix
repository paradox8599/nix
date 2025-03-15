{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    profileExtra = ''
        export DISPLAY=:0
        # export TERM=xterm-256color

        # yazi set cwd when navigate
        function y() {
      	  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      	  yazi --cwd-file="$tmp"
      	  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      		  builtin cd -- "$cwd"
      	  fi
      	  rm -f -- "$tmp"
        }

        rm -f ~/.nix-profile

        [ -z "$TMUX" ] && cd ~
    '';

    shellAliases = {
      ls = "exa";
      l = "exa --long --icons --sort=type --group";
      la = "l --all --header";
      ll = "l --header";
      nh = "nix profile history --profile /nix/var/nix/profiles/system";
      lg = "lazygit";
      ldk = "lazydocker";
      rb = "sudo nixos-rebuild --flake ~/.config/nixos";
      rbv = "sudo nixos-rebuild --flake ~/.config/nixos --show-trace --print-build-logs --verbose";
      t = ''[[ $(tmux ls 2>/dev/null | rg -v attached | wc -l) -gt 0 ]] && tmux attach -t $(tmux ls | rg -v attach | cut -d":" -f1 | tr "\n" " " | cut -d" " -f1) || tmux -u new-session -s main'';
      tl = "tmux ls 2>/dev/null";
      docker = "/usr/bin/docker";
    };
  };
}
