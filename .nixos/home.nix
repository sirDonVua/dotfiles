{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vex";
  home.homeDirectory = "/home/vex";

  # Do not change !!
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "CascadiaCode" "Inconsolata" "Hermit" "JetBrainsMono" ]; })

  ];

  # gtk
  gtk = {
    enable = true;
    theme.name = "Dracula";
    iconTheme.name = "Papirus-Dark";
    font.name = "JetBrainsMono Nerd Font";
    font.size = 12;
  };

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  # global mouse cursor
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    size = 16;
    package = pkgs.bibata-cursors;
    x11.enable = true;
    gtk.enable = true ;
  };
    
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
