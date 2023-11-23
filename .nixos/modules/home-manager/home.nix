{ config, pkgs, user, ... }:
let user = "vex"; in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  # Do not change !!
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "CascadiaCode" "JetBrainsMono" ];
                             }
                               )
  ];

  # gtk
  gtk = {
    enable = true;
    theme.name = "Dracula";
    iconTheme.name = "Papirus-Dark";
    font.name = "JetBrainsMono Nerd Font";
    font.size = 12;
  };

  # gtk4 theme
  home.sessionVariables.GTK_THEME = "Dracula";

  # dconf (gnome)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Dracula";
      toolkit-accessibility = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = "disabled";
      toggle-message-tray = "disabled";
      close = ["<Super>q"];
      toggle-maximized = ["<Super>f"];
      unmaximize = "disabled";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":";
      num-workspaces = 5;
      focus-new-windows = "smart";
      raise-on-click = false;
      auto-raise = true;
      focus-mode = "mouse";

    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "alacritty";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "emacs";
      command = "emacsclient -c -a emacs";
      binding = "<Super>e";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "thorium";
      command = "/home/${user}/.local/bin/thorium-browser";
      binding = "<Super>b";
    };
  };


  # emacs
  services.emacs = {
    enable = true;
    startWithUserSession = true; # start emacs server
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
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
