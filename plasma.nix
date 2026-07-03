{ config, lib, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  #environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #  konsole
  #];

  environment.systemPackages = with pkgs; [
    kdePackages.kcalc
    kdePackages.qtlocation
    kdePackages.krfb
    kdePackages.krdc
    kdePackages.kamera
    kdePackages.kdepim-addons
    kdePackages.kdepim-runtime
    kdePackages.kimageformats
    kdePackages.libkdepim
  ];
}
