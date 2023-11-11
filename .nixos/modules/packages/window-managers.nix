{ config, pkgs, ... }:

{
  # enable xserver and some window managers
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.windowManager.openbox.enable = true;
  services.xserver.windowManager.awesome.enable = true;

  # sddm login manager
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "${import ./sddm-sugar-candy.nix {inherit pkgs;}}";
  };

  environment.systemPackages =  with pkgs; [
    
    betterlockscreen
    copyq
    nitrogen
    flameshot
    rofi-power-menu
    
    picom-jonaburg
    polkit
    lxsession
    openbox-menu
    polybar
    tint2
    plank

    android-file-transfer
    gvfs
    mtpfs
    
  ];
}
