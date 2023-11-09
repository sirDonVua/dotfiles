{ pkgs, ... }:
{
  
  #installing gnome
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;
  services.xserver.displayManager.gdm.enable = true;

  # gnome settings deamon
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  #packages
  environment.systemPackages =  with pkgs.gnome; [

    geary # email reader
    baobab      # disk usage analyzer
    evince      # document viewer
    file-roller # archive manager
    nautilus # file manager
    gnome-tweaks # gnome tweak tool

    # gnome extensions
  ] ++ (with pkgs.gnomeExtensions; [
    dash-to-dock
    applications-menu
    blur-my-shell
    arc-menu
    gnome-40-ui-improvements
    clipboard-indicator-2
    quick-settings-tweaker
    coverflow-alt-tab
    just-perfection
    forge
    burn-my-windows
    
  ]);}
