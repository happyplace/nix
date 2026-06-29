{ config, lib, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages; # LTS
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "loglevel=3" "splash" "quiet" ];
  # boot.kernelParams = [ "nosmt" "mitigations=auto"];
  boot.plymouth.enable = true;
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;
  hardware.xone.enable = true;

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
    noto-fonts-color-emoji
    nerd-fonts.caskaydia-cove
    cascadia-code
    corefonts # microsoft fonts
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   autosuggestions.enable = true;
  #   syntaxHighlighting.enable = true;
  # };
  users.groups.andrew = {};
  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew Murray";
    group = "andrew";
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.bash;
    packages = with pkgs; [
      fastfetch
    ];
  };

  users.users.root.hashedPassword = "!";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

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
    solaar
    logitech-udev-rules # udev rules for solaar
    python314
    libva
    libva-utils
    xeyes
    btop
    killall
    google-chrome
    brave
    tailscale
    pulseaudio # pactl
    mc
    ntfs3g
    eza
    bat
    irssi
    efibootmgr
    syncthing
    unityhub
    keepassxc
    openfortivpn # vpn client used at behaviour
    openfortivpn-webview # vpn client used at behaviour

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
    chiaki-ng

    texliveFull # the FULL latex

    # bcachefs
    keyutils # needed for "keyctl link @u @s" to fix mounting encrypted
    bcachefs-tools

    # Vulkan Development
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools        # vulkaninfo
    shaderc             # GLSL to SPIRV compiler - glslc
    renderdoc           # Graphics debugger
    tracy               # profiler
    vulkan-tools-lunarg # vkconfig
    glslang

    # Development
    sdl3
    gdb
    gcc
    clang
    cmakeWithGui
    gnumake
    assimp
    rustup
    zig
    vscode
    qtcreator
    clang-tools

    # neovim kickstart
    ripgrep
    fd

    # Zsh shell
    # zsh
    # zsh-autosuggestions
    # zsh-completions
    # zsh-syntax-highlighting

    # xbox one controller dongle
    linuxPackages.xone # xbox controller dongle driver
    linuxPackages_latest.xone # xbox controller dongle driver

    # Packages that are usually flatpaks
    blender
    calibre
    darktable
    github-desktop
    discord
    handbrake
    kdePackages.kdenlive
    krita
    obs-studio
    protonup-qt
    qpwgraph
    spotify
    texstudio
    transmission-remote-gtk
    # moving this back to flatpak, it's using an old electron and it's complaining when I try to install
    #bitwarden-desktop
    pavucontrol
    parsec-bin
    localsend
    obsidian
  ];

  nixpkgs.overlays = [
    (self: super: {
      brave = super.brave.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoDecodeLinuxGL"
          "--password-store=gnome-libsecret"
        ];
      };
      google-chrome = super.google-chrome.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoDecodeLinuxGL"
          "--password-store=gnome-libsecret"
        ];
      };
    })
  ];

  environment.etc = {
    "ld.so.conf" = {
      text = ''/run/current-system/sw/share/nix-ld/lib'';
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd

      # My own additions
      libXcomposite
      libXtst
      libXrandr
      libXext
      libX11
      libXfixes
      libGL
      libva
      pipewire
      libxcb
      libXdamage
      libxshmfence
      libXxf86vm
      libelf

      # Required
      glib
      gtk2

      glibc

      # Inspired by steam
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
      networkmanager
      vulkan-loader
      libgbm
      libdrm
      libxcrypt
      coreutils
      pciutils
      zenity
      # glibc_multi.bin # Seems to cause issue in ARM

      # # Without these it silently fails
      libXinerama
      libXcursor
      libXrender
      libXScrnSaver
      libXi
      libSM
      libICE
      gnome2.GConf
      nspr
      nss
      cups
      libcap
      SDL2
      libusb1
      dbus-glib
      ffmpeg
      # Only libraries are needed from those two
      libudev0-shim

      # needed to run unity
      gtk3
      icu
      libnotify
      gsettings-desktop-schemas
      # https://github.com/NixOS/nixpkgs/issues/72282
      # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
      # log in /home/leo/.config/unity3d/Editor.log
      # it will segfault when opening files if you don’t do:
      # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
      # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed
      sqlite # unity3d visual scripting

      # Verified games requirements
      libXt
      libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew_1_10
      libidn
      tbb
      sdl3

      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_ttf
      SDL2_mixer
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      libXft
      libvdpau
      # ...
      # Some more libraries that I needed to run programs
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      alsa-lib
      expat
      # for blender
      libxkbcommon

      libxcrypt-legacy # For natron
      libGLU # For natron

      # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
      fuse
      e2fsprogs

      ffmpeg_4-full # boram
      mpv # boram
    ];
  };

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
  system.stateVersion = "25.11"; # Did you read the comment?
}
