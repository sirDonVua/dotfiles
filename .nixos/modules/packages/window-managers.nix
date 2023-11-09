{ config, pkgs, ... }:

{
  # enable xserver and some window managers
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.windowManager.openbox.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "${import ./sddm-sugar-dark.nix {inherit pkgs;}}";

  environment.systemPackages =  with pkgs; [
    
    xfce.thunar
    xfce.thunar-archive-plugin
    betterlockscreen
    copyq
    nitrogen
    flameshot
    
    picom
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
