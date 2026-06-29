{ config, lib, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    showtime
    gnome-text-editor
  ];

  environment.systemPackages = with pkgs; [
    ghostty
    ffmpegthumbnailer
    gnomeExtensions.caffeine
    gnomeExtensions.desktop-icons-ng-ding
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
    gnome-tweaks
    dconf-editor
  ];
}
