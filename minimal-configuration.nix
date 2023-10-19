# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vex = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
     tree
     curl
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    xfce.thunar
    sxiv
    celluloid
    rofi
    pkgs.gnome-text-editor
    polkit
    lxsession
    lxappearance
    picom
    pkgs.gnome.adwaita-icon-theme
    shared-mime-info
    papirus-icon-theme
    nitrogen
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
    android-file-transfer
    gvfs
    mtpfs
    python3Full
    pkgs.python310Packages.pip
    opentabletdriver
    xournalpp
    appimage-run
    networkmanagerapplet
    dracula-theme
    bibata-cursors
    papirus-folders
    papirus-icon-theme
  ];


  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  #DO NOT CHANGE !!
  system.stateVersion = "23.05"; # Did you read the comment?

}
