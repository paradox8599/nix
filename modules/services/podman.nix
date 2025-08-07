{ pkgs, username, ... }:
{
  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    runc
    conmon
    skopeo
    slirp4netns
    fuse-overlayfs

    podman-tui
  ];

  users.users.${username} = {
    isNormalUser = true;
    linger = true;
    # other user options...
  };
}
