{ pkgs, ... } :

{

fonts = {
  enableDefaultFonts = true;
  fonts = with pkgs; [ 
    powerline-fonts
    vazir-fonts
  ];

  fontconfig = {
    defaultFonts = {
      serif = [ "Vazirmatn" "JetBrainsMono" ];
      sansSerif = [ "Vazirmatn" "JetBrainsMono" ];
      monospace = [ "JetBrainsMono" ];
    };
  };
};

  environment.systemPackages = with pkgs; [

    #core
    llvmPackages.bintools
    killall
    brightnessctl
    light
    xdg-utils
    cmatrix
    lavat

    #gui
    alacritty
    firefox
    celluloid
    rofi
    emacs29
    evince
    gnome.gnome-calculator
    gnome.nautilus
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
    trash-cli
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
    yad
    tldr
    duf
    dunst
    bash-completion
    networkmanagerapplet

    #programming
    python3Full
    gnumake
    cmake
    pyright
    rnix-lsp

    # sys libs 
    nix-index
    xorg.xev
    libtool

    # Drawing
    opentabletdriver
    xournalpp
    openboard

    # appimages
    appimage-run

  ];
}
