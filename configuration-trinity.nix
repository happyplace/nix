# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      ./base.nix
      ./nix-ld.nix
      ./extended.nix
      ./plasma.nix
    ];

    fileSystems."/home" =
    { device = "/dev/disk/by-uuid/89b3290d-4c42-4044-8175-182327c9ae46";
        fsType = "btrfs";
    };

    boot.initrd.luks.devices."home".device = "/dev/disk/by-uuid/734e1574-77cb-4f81-9792-7a0e085d53c1";

    services.udev.packages = [
      (pkgs.writeTextFile {
        name = "disable_laptop_webcam";
        text = ''
          ACTION=="add", ATTR{idVendor}=="04f2", ATTR{idProduct}=="b685", RUN="/bin/sh -c 'echo 1 >/sys/\$devpath/remove'"
        '';
        destination = "/etc/udev/rules.d/00-disable-laptop-webcam.rules";
      })
    ];

    networking.hostName = "trinity";
    environment.systemPackages = with pkgs; [
      intel-gpu-tools
      epson-escpr
      tailscale
    ];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # Intel GPU
        intel-media-driver
        intel-compute-runtime # opencl
      ];
    };

    powerManagement.enable = true;
    services.power-profiles-daemon.enable = true;

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "26.05"; # Did you read the comment?
}
