{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      aider-chat.withPlaywright
    ];

    file.".aider.conf.yml" = {
      enable = true;
      source = ../../configs/aider/.aider.conf.yml;
    };

    file.".aider.model.metadata.json" = {
      enable = true;
      source = ../../configs/aider/.aider.model.metadata.json;
    };

    file.".aider.model.settings.yml" = {
      enable = true;
      source = ../../configs/aider/.aider.model.settings.yml;
    };
  };
}
