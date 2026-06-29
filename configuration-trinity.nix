# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      ./base.nix
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
    ];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # Intel GPU
        intel-media-driver
      ];
    };

    powerManagement.enable = true;
    services.power-profiles-daemon.enable = true;
}
