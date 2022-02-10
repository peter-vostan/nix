{ ... }: {
  virtualisation.docker.enable = true;

  # virtualisation.podman.enable = true;
  # virtualisation.podman.dockerCompat = true; # Create a `docker` alias for podman, to use it as a drop-in replacement

  # Remember to add user to groups qemu-libvirtd and libvirtd
  # virtualisation.libvirtd.enable = true;
  # boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  # Remember to add user to group vboxusers
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
}
