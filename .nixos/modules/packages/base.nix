{ pkgs, ... } :

{
  environment.systemPackages = with pkgs; [

  alacritty
  brave
  celluloid
  rofi
  emacs
  evince
  gnome.gnome-calculator
  gnome.eog # gnome photos
  zoom-us

  #home-manager
  home-manager
  dconf

  #distrobox
  distrobox
  podman
  xorg.xhost

  # Themeing
  gnome.adwaita-icon-theme
  shared-mime-info
  papirus-icon-theme
  dracula-theme
  bibata-cursors
  papirus-folders
  papirus-icon-theme
  libsForQt5.qt5.qtquickcontrols2   
  libsForQt5.qt5.qtgraphicaleffects


  # cli & tui
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
  bashmount
  redshift
  unzip
  git
  gh
  dunst
  bash-completion
  networkmanagerapplet

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
  ];}
