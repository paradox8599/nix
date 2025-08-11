{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    profileExtra = ''
      # Source local environment variables if the file exists
      if [ -f "$HOME/.zsh_local" ]; then
        . "$HOME/.zsh_local"
      fi

      # yazi set cwd when navigate
      function y() {
      	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      	yazi --cwd-file="$tmp"
      	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      		builtin cd -- "$cwd"
      	fi
      	rm -f -- "$tmp"
      }

      if [ -t 1 ] && [ -z "$TMUX" ] && [ -z "$NO_TMUX" ]; then
        cd ~ && ([[ $(tmux ls 2>/dev/null | rg -v attached | wc -l) -gt 0 ]] && tmux attach -t $(tmux ls | rg -v attach | cut -d":" -f1 | tr "\n" " " | cut -d" " -f1) || tmux -u new-session)
      fi
    '';

    envExtra = ''
      export PATH="/usr/bin:$PATH"
      [ -z "$TMUX" ] && export TERM=xterm-256color || export TERM=screen-256color
    '';

    shellAliases = {
      ls = "eza";
      l = "eza --long --icons --sort=type --group";
      la = "l --all --header";
      ll = "l --header";
      nh = "nix profile history --profile /nix/var/nix/profiles/system";
      nhd = "sudo nix-collect-garbage -d";
      lg = "lazygit";
      ldk = "lazydocker";
      nr = "sudo nixos-rebuild --flake ~/.config/nixos";
      nrv = "sudo nixos-rebuild --flake ~/.config/nixos --show-trace --print-build-logs --verbose";
      nrup = ''
        nr build && mv result result.old && nix flake update && nr build &&
        nix store diff-closures ./result.old ./result && rm result.old result
      '';
      t = ''[[ $(tmux ls 2>/dev/null | rg -v attached | wc -l) -gt 0 ]] && tmux attach -t $(tmux ls | rg -v attach | cut -d":" -f1 | tr "\n" " " | cut -d" " -f1) || tmux -u new-session'';
      tl = "tmux ls 2>/dev/null";
      ga = "aider --commit";
    };
  };
}
