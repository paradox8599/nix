# set OPENAI_API_KEY in ~/.env
{
  inputs,
  pkgs,
  config,
  ...
}:
let
  pkgs-aider = inputs.nixpkgs-aider.legacyPackages.${pkgs.system};
in
{
  home = {
    packages = [
      (pkgs-aider.aider-chat.passthru.withOptional {
        withPlaywright = true;
        withHelp = true;
      })
    ];

    file.".aider.conf.yml".source = config.lib.file.mkOutOfStoreSymlink (
      "${config.home.homeDirectory}/.config/nix/configs/aider/.aider.conf.yml"
    );

    file.".aider.model.metadata.json".source = config.lib.file.mkOutOfStoreSymlink (
      "${config.home.homeDirectory}/.config/nix/configs/aider/.aider.model.metadata.json"
    );

    file.".aider.model.settings.yml".source = config.lib.file.mkOutOfStoreSymlink (
      "${config.home.homeDirectory}/.config/nix/configs/aider/.aider.model.settings.yml"
    );
  };
}
