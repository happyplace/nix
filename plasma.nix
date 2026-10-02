{ config, lib, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
   konsole
   kate
   discover
  ];

  environment.systemPackages = with pkgs; [
    kitty
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
