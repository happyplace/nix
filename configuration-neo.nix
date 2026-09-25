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
      ./plasma.nix
    ];

  boot.initrd.luks.devices."root".crypttabExtraOpts = [ "tpm2-device=auto" ];

  networking.hostName = "neo";
  environment.systemPackages = with pkgs; [
    # AMD GPU
    amdgpu_top
  ];

  hardware.amdgpu.opencl.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # AMD GPU
      mesa
      # For NVIDIA: nvidia-vaapi-driver
    ];
  };
}
