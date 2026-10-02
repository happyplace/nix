{ config, lib, pkgs, inputs, ... }:

# needed to have a mix of unstable and stable packages
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config = { allowUnfree = true; };
  };
in
{
  # boot.kernelPackages = pkgs.linuxPackages; # LTS
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "loglevel=3" "splash" "quiet" ]; # "nosmt" "mitigations=auto" ];
  boot.plymouth.enable = true;
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;
  #hardware.xone.enable = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.resolvconf.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 10;
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  i18n.defaultLocale = "en_CA.UTF-8";

  # Optionally (BEWARE: requires a different format with the added /UTF-8)
  i18n.extraLocales = ["en_US.UTF-8/UTF-8"];

  # Optionally
  i18n.extraLocaleSettings = {
    LC_ALL = "en_CA.UTF-8";
    LC_CTYPE = "en_CA.UTF8";
    LC_ADDRESS = "en_CA.UTF-8";
    LC_MEASUREMENT = "en_CA.UTF-8";
    LC_MESSAGES = "en_CA.UTF-8";
    LC_MONETARY = "en_CA.UTF-8";
    LC_NAME = "en_CA.UTF-8";
    LC_NUMERIC = "en_CA.UTF-8";
    LC_PAPER = "en_CA.UTF-8";
    LC_TELEPHONE = "en_CA.UTF-8";
    LC_TIME = "en_CA.UTF-8";
    LC_COLLATE = "en_CA.UTF-8";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.caskaydia-cove
    cascadia-code
    corefonts # microsoft fonts
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  users.groups.andrew = {};
  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew Murray";
    group = "andrew";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
    packages = with pkgs; [
      fastfetch
      zsh
    ];
  };

  users.users.root.hashedPassword = "!";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.flatpak.enable = true;

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
  };

  services.syncthing = {
    enable = false;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    git-lfs
    tmux
    firefox-bin
    hunspell
    hunspellDicts.en-ca
    zed-editor
    ffmpeg-full
    yt-dlp
    python312Packages.yt-dlp-ejs # needed for deno maybe
    deno
    mpv
    logitech-udev-rules
    python3
    libva
    libva-utils
    xeyes
    btop
    killall
    google-chrome
    pulseaudio # pactl
    mc
    ntfs3g
    #eza
    #bat
    irssi
    efibootmgr
    syncthing
    keepassxc
    clinfo

    # Work
    #openfortivpn
    #openfortivpn-webview
    #parsec-bin

    # Codec
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi

    # Format Support
    arj
    lrzip
    lzop
    libheif
    libavif
    libraw
    p7zip
    unrar
    unzip

    # Games
    #chiaki-ng

    # bcachefs
    keyutils # needed for "keyctl link @u @s" to fix mounting encrypted
    bcachefs-tools

    # neovim kickstart
    ripgrep
    fd
    luaPackages.tree-sitter-cli

    # xbox one controller dongle
    #linuxPackages.xone # xbox controller dongle driver
    #linuxPackages_latest.xone # xbox controller dongle driver

    # Packages that are usually flatpaks
    protonup-qt
    pavucontrol
    qpwgraph
    spotify
    transmission-remote-gtk

    # unstable packages
    unstable.brave-origin
    unstable.openlogi
  ];

  nixpkgs.overlays = [
    (self: super: {
      brave = super.brave.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoDecodeLinuxGL"
        ];
      };
      brave-origin = super.brave-origin.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoDecodeLinuxGL"
        ];
      };
      google-chrome = super.google-chrome.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoDecodeLinuxGL"
        ];
      };
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # 53317 TCP,UDP - LocalSend
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
