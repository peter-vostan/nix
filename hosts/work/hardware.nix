{ pkgs, config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Kernel settings.
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Initial RAM disk.
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];

  # Power management.
  powerManagement.cpuFreqGovernor = "ondemand";

  # Graphics hardware.
  services.xserver.videoDrivers = [ "intel" ];
  
  # Filesystems.
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  # Encrypted drives.
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # Swap devices.
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];
}