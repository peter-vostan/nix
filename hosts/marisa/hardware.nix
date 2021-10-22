{ pkgs, config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Kernel settings.
  boot.kernelPackages = pkgs.linuxPackages_5_4;
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Initial RAM disk.
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];

  # Power management.
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Graphics hardware.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  # Filesystems.
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  # Swap devices.
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];
}
