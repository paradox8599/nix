{ pkgs, ... }:
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

      if [ -t 1 ] && [ -z "$TMUX" ]; then
        cd ~
      fi
    '';

    envExtra = ''
      export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
      export PATH="/usr/bin:$PATH"
      [ -z "$TMUX" ] && export TERM=xterm-256color || export TERM=screen-256color

      # Source local environment variables if the file exists
      [ -f "$HOME/.zsh_local" ] && . "$HOME/.zsh_local"

    '';

    shellAliases = {
      l = "eza --long --icons --sort=type --group";
      la = "l --all --header";
      ll = "l --header";
      nh = "nix profile history --profile /nix/var/nix/profiles/system";
      nhd = "sudo nix-collect-garbage -d";
      lg = "lazygit";
      lq = "lazysql";
      ldk = "lazydocker";
      nr = "sudo nixos-rebuild --flake ~/.config/nix";
      nrv = "sudo nixos-rebuild --flake ~/.config/nix --show-trace --print-build-logs --verbose";
      nrup = ''
        sudo rm -f ./result.old ./result &&
        nr build && mv ./result ./result.old && nix flake update && nr build &&
        nix store diff-closures ./result.old ./result && sudo rm -f result.old result
      '';
      dr = "sudo darwin-rebuild --flake ~/.config/nix#darwin";
      drv = "sudo darwin-rebuild --flake ~/.config/nix#darwin --show-trace --print-build-logs --verbose";
      drup = ''
        sudo rm -f ~/.config/nix/result.old ~/.config/nix/result &&
        dr build &&
        mv result result.old && nix flake update &&
        dr build &&
        nix store diff-closures ~/.config/nix/result.old ~/.config/nix/result &&
        sudo rm -f ~/.config/nix/result.old ~/.config/nix/result
      '';
      ta = "tmux -u attach -t";
      tn = "tmux -u new -s";
      t = ''[[ $(tmux ls 2>/dev/null | rg -v attached | wc -l) -gt 0 ]] && tmux attach -t $(tmux ls | rg -v attach | cut -d":" -f1 | tr "\n" " " | cut -d" " -f1) || tmux -u new-session'';
      tl = "tmux ls 2>/dev/null";
      ga = "git add . && aider --commit";
      vi = "nvim";
    };
  };

  home.packages = with pkgs; [
    zimfw
  ];
}
