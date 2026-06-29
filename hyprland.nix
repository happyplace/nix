{ config, lib, pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  # if I ever switch to home manager this is needed to fix an error because I have kdePackages.plasma-workspace
  # stylix.targets.kde.enable = false;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

  services.udev.packages = [ pkgs.swayosd ];
  services.gvfs.enable = true;

  systemd.services.swayosd-libinput-backend = {
    description = "SwayOSD LibInput backend for listening to certain keys like CapsLock, ScrollLock, VolumeUp, etc.";
    documentation = [ "https://github.com/ErikReider/SwayOSD" ];
    wantedBy = [ "graphical.target" ];
    partOf = [ "graphical.target" ];
    after = [ "graphical.target" ];

    serviceConfig = {
      Type = "dbus";
      BusName = "org.erikreider.swayosd";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      Restart = "on-failure";
    };
  };

  fonts.packages = with pkgs; [
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
    # hyprland - dolphin
    # kdePackages.dolphin
    # kdePackages.kio
    # kdePackages.kio-fuse
    # kdePackages.kio-admin
    # kdePackages.kio-extras
    # kdePackages.ffmpegthumbs
    # kdePackages.kdegraphics-thumbnailers
    # kdePackages.kimageformats
    # kdePackages.qtimageformats
    # kdePackages.ark

    # hyprland - nautilus
    nautilus
    gvfs
    ffmpegthumbnailer

    # hyprland
    kitty
    ghostty
    evince
    gnome-keyring
    seahorse
    libsecret # needed for gnome-keyring
    hyprpaper
    hypridle
    hyprlock
    hyprcursor
    hyprpicker
    hyprsunset
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    xdg-desktop-portal-gtk
    kdePackages.xdg-desktop-portal-kde
    brightnessctl
    playerctl
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland # qt6-wayland
    libnotify
    power-profiles-daemon
    libayatana-appindicator
    libappindicator-gtk3 # need 32-bit as well
    libappindicator-gtk2 # need 32-bit as well
    kdePackages.kstatusnotifieritem
    wl-clipboard
    nwg-displays
    kanshi
    xclip
    waybar
    swww
    wofi
    imv
    clipse
    blueman
    satty
    grim
    slurp
    swaynotificationcenter
    shared-mime-info
    swayosd
    adwaita-icon-theme
    adwaita-icon-theme-legacy
    jq
    glib # needed for gsettings
    gum
    curlFull
  ];
}
