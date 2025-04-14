{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    profileExtra = ''
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

    envExtra = ''
      export DISPLAY=:0
      [ -z "$TMUX" ] && export TERM=xterm-256color || export TERM=screen-256color
    '';

    shellAliases = {
      ls = "exa";
      l = "exa --long --icons --sort=type --group";
      la = "l --all --header";
      ll = "l --header";
      nh = "nix profile history --profile /nix/var/nix/profiles/system";
      nhd = "sudo nix-collect-garbage -d";
      lg = "lazygit";
      ldk = "lazydocker";
      nrb = "sudo nixos-rebuild --flake ~/.config/nixos";
      nrbv = "sudo nixos-rebuild --flake ~/.config/nixos --show-trace --print-build-logs --verbose";
      ndiff = ''
        nrb build && mv result result.old && nix flake update && nrb build &&
        nix store diff-closures ./result.old ./result && rm result.old result
      '';
      t = ''[[ $(tmux ls 2>/dev/null | rg -v attached | wc -l) -gt 0 ]] && tmux attach -t $(tmux ls | rg -v attach | cut -d":" -f1 | tr "\n" " " | cut -d" " -f1) || tmux -u new-session -s main'';
      tl = "tmux ls 2>/dev/null";
      docker = "/usr/bin/docker";
    };
  };
}
