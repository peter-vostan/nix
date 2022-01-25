{ ... }: {
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "peter" ];

  # virtualisation.podman.enable = true;
  # virtualisation.podman.dockerCompat = true; # Create a `docker` alias for podman, to use it as a drop-in replacement

  # virtualisation.libvirtd.enable = true;
  # boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  # users.extraGroups.qemu-libvirtd.members = [ "peter" ];
  # users.extraGroups.libvirtd.members = [ "peter" ];

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # users.extraGroups.vboxusers.members = [ "peter" ];
}
