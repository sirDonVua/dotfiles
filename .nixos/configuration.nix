{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #hardware suoport
  nixpkgs.config.allowUnfree = true; 
  hardware.enableAllFirmware = true;
  hardware.opentabletdriver.enable = true;

  # Nvidia Drivers
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #network
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  
  #bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;  
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kuwait";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "${import ./sddm-sugar-dark.nix {inherit pkgs;}}";

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  #enable automount
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      curl
    ];
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # base utils
    alacritty
    brave
    xfce.thunar
    xfce.thunar-archive-plugin
    sxiv
    celluloid
    rofi
    emacs29
    nitrogen
    evince
    betterlockscreen
    feh
    zoom-us
    
    # windowmanager stuff
    polkit
    lxsession
    picom-jonaburg

    #home-manager
    home-manager
    dconf

    #distrobox
    distrobox
    podman
    xorg.xhost

    # Themeing
    pkgs.gnome.adwaita-icon-theme
    shared-mime-info
    papirus-icon-theme
    dracula-theme
    bibata-cursors
    papirus-folders
    papirus-icon-theme
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects

    # tui & cli
    sxhkd
    vim
    vifm
    btop
    lsd
    bat
    stow
    zoxide
    pfetch
    neofetch
    starship
    wget 
    plocate
    cbatticon
    aria2
    pamixer
    flameshot
    bashmount
    redshift
    unzip
    git
    gh
    dunst
    bash-completion
    networkmanagerapplet

    # android
    android-file-transfer
    gvfs
    mtpfs

    #wine
    wineWowPackages.stable
    wineWowPackages.staging
    winetricks

    #programming
    python3Full
    nodejs
    gnumake
    cmake

    # sys libs 
    nix-index
    xorg.xev
    libtool
    vulkan-tools

    # Drawing
    opentabletdriver
    xournalpp

    # appimages
    appimage-run
    
  ];
  
  # appimages
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  #flatpak
  services.flatpak.enable = true;
  xdg.portal= {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Podman for distrobox
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  }; 

  environment.shellInit = ''
    [ -n "$DISPLAY" ] && xhost +si:localuser:$USER || true
    '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  #picom
  services.picom.enable = true;

  # dbus
  services.dbus.enable = true;

  # nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #DO NOT CHANGE !!
  system.stateVersion = "23.05"; # Did you read the comment?

}
