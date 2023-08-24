# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

with lib;

{
  imports =
    [
      ./cachix.nix # cachix use nix-community; needed for emacs
      ./hardware-configuration.nix
      <home-manager/nixos>
      <nixos-hardware/common/gpu/intel>
      <nixos-hardware/common/pc/laptop>
    ];

  # Fonts

  fonts = {
    fontconfig = {
      hinting.enable = false;
      defaultFonts = {
        serif = ["PT Serif"];
        sansSerif = ["Fira Sans"];
        monospace = ["Fira Mono"];
      };
    };
    packages = with pkgs; [
      paratype-pt-sans paratype-pt-serif
      source-sans-pro
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-code-pro
      cm_unicode
      inter
      corefonts
      nerdfonts
      fira fira-go fira-mono fira-code
    ];
  };

  # Packages

  environment.systemPackages = with pkgs; [
    # Utils
    powertop
    s-tui
    minicom
    lxqt.pavucontrol-qt
    androidenv.androidPkgs_9_0.platform-tools
    silver-searcher
    git-lfs
    zoxide
    jq
    strongswanNM

    # Runtimes
    #steam-run-native
    (appimage-run.override {
      extraPkgs = pkgs: [ pkgs.icu ];
    })
    steam
    gnome3.zenity
    jdk
    leiningen

    # VM
    virtmanager
    docker-compose

    # Multimedia
    firefox
    brave
    chromium
    google-chrome
    (deadbeef-with-plugins.override {
      plugins = with deadbeefPlugins; [ mpris2 ];
    })
    amarok
    nicotine-plus # soulseek
    lollypop
    evolution
    lilypond
    musescore
    obsidian
    #kalendar
    #korganizer
    #kmail
    filelight
    zotero
    mpv
    yt-dlp
    gimp
    darktable
    audacity
    inkscape
    xsane
    obs-studio
    qjackctl
    pulseaudio # for pacmd
    easyeffects

    spotify

    reaper
    yabridge yabridgectl

    # GUI
    wl-clipboard
    kitty
    pop-gtk-theme
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    yaru-theme yaru-remix-theme
    gnomeExtensions.pop-shell
    adwaita-qt
    libsForQt5.qtstyleplugin-kvantum

    # random
    home-manager

    # Messengers
    element-desktop
    tdesktop
    tdlib
    mumble_git
    zoom-us

    # Haskell
    irony-server
    cabal-install
    haskellPackages.haskell-language-server
    #jupyterEnvironment
    ghc
    # stack
    cabal2nix

    # lsp
    nodePackages_latest.vscode-langservers-extracted

    ripgrep fd direnv fzf
    glslang
    llvmPackages_latest.clang
    clang-tools
    pyright
    sbcl
    python3
    git
    sshfs-fuse
    vim

    gnome.gnome-boxes

    screen
    parallel
    poke

    # Network
    aria2
    deluge
    wget
    openvpn
    update-resolv-conf
    shadowsocks-libev
    tor
    pass
    browserpass

    # Documents
    libreoffice
    anki

    # Monitors
    htop
    iotop
    ftop
    nethogs
    psmisc
    lsof

    texlive.combined.scheme-full
    pandoc

    # Hardware
    dmidecode
    lm_sensors
    pciutils
    usbutils
    hdparm
    ethtool
    smartmontools

    # Files
    gptfdisk
    zip
    unzip
    tree
    rsync
    file
    pv
    dos2unix

    # Wine
    wineWowPackages.staging
    wineWowPackages.waylandFull
    winetricks
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.systemd.enable = true;
  boot.plymouth = {
    enable = true;
    extraConfig = ''
      DeviceScale=2
    '';
  };
  boot.kernelParams = [
    "quiet"
    "splash"
    "i915.fastboot=1"
    "i915.enable_fbc=1"
    "i915.enable_psr=2"
    "mem_sleep_default=deep"
    "nvme.noacpi=1"
  ];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "C.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # DE
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.windowManager.exwm = {
    enable = false;
    enableDefaultConfig = true;
  };
  # services.xserver.desktopManager.mate.enable = true;
  xdg.portal.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us,ru";
    xkbOptions = concatStringsSep "," [
      "grp:caps_toggle"
      "grp_led:caps"
      "terminate:ctrl_alt_bksp"
      "compose:ralt"
      "misc:typo"
    ];
    enableCtrlAltBackspace = true;
    dpi = 277;
  };

  services.kmscon = {
    enable = true;
    hwRender = true;
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = pkgs.emacs29-pgtk;
  };

  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  hardware.opengl = {
    enable = true;
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.k60 = {
      isNormalUser = true;
      description = "Vanya Klimenko";
      extraGroups = [ "networkmanager" "wheel" "libvirt" "adbusers" ];
      packages = with pkgs; [
        firefox
      ];
    };
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "k60";

  services.strongswan.enable = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    adb.enable = true;
    steam.enable = true;
    gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
     pinentryFlavor = "gnome3";
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
    dconf.enable = true;
    bash = {
      vteIntegration = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      # enableSysbox = true;
    };
    libvirtd.enable = true;
    virtualbox.host.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  networking = {
    hostName = "mate";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager_strongswan
      ];
    };
    firewall.enable = false;
    wireguard.enable = true;
  };

  services.zerotierone.enable = false;
  services.syncthing = {
    enable = true;
    user = "k60";
    dataDir = "/home/k60";
    configDir = "/home/k60/.config/syncthing";
    relay.enable = true;
  };

  services.colord.enable = true;

  # Nix the package manager
  nix = {
    # package = pkgs.nixUnstable;
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedPriority = 4;

    gc = {
      automatic = true;
      dates = "weekly";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  # home-manager.useGlobalPkgs = true;

  system.stateVersion = "22.11"; # Did you read the comment?

  powerManagement.powertop.enable = true;
  services.throttled.enable = false; # 2 much heat!

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #   }))
  # ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  nixpkgs.config.firefox.enableBrowserpass = true;

  # bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
