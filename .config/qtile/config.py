#  ___                            _       
# |_ _|_ __ ___  _ __   ___  _ __| |_ ___ 
#  | || '_ ` _ \| '_ \ / _ \| '__| __/ __|
#  | || | | | | | |_) | (_) | |  | |_\__ \
# |___|_| |_| |_| .__/ \___/|_|   \__|___/
#               |_|                       
#-- nedded libs for config to work
#-- all are pre installed except qtile_extras
#----------------------------------------------#
import os
import subprocess as sp
from libqtile import bar, layout, hook, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.config import KeyChord, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder
from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
#----------------------------------------------#

# __     __         _       _     _           
# \ \   / /_ _ _ __(_) __ _| |__ | | ___  ___ 
#  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#   \ V / (_| | |  | | (_| | |_) | |  __/\__ \
#    \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/

#----------------------------------------------#
mod = "mod4"
terminal = guess_terminal()
font = "JetBrainsMono Nerd Font"
home = os.path.expanduser('~') + "/"
wifi = home + ".local/bin/rofi-wifi-menu"
startup_script = home +  ".config/qtile/script.sh"
exit_command = "rofi -show powermenu -theme ~/.local/share/rofi/themes/nord.rasi -modi powermenu:rofi-power-menu"

colors = {
    "black":"#282a36",
    "semi-black":"#44475a",
    "white":"#f8f8f2",
    "purple-sky":"#6272a4",
    "cyan":"#8be9fd",
    "green":"#50fa7b",
    "orange":"#ffb86c",
    "pink":"#ff79c6",
    "purple":"#bd93f9",
    "red":"#ff5555",
    "yellow":"#f1fa8c",
    # "bar":"#44475a80"
    "bar":"#44475a00"
}
#-- This is the offical dracula theme platte
#-- and please ignore the naming

#----------------------------------------------#

#  _  __          ____  _           _ _           
# | |/ /___ _   _| __ )(_)_ __   __| (_) __ _ ___ 
# | ' // _ \ | | |  _ \| | '_ \ / _` | |/ _` / __|
# | . \  __/ |_| | |_) | | | | | (_| | | (_| \__ \
# |_|\_\___|\__, |____/|_|_| |_|\__,_|_|\__, |___/
#           |___/                       |___/     

#----------------------------------------------#
keys = [
    #moving window foucus
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    #Moving Windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    #Changing windows size
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    #Terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    #Killing a window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    #floating and fullscreen
    Key([mod],"m", lazy.window.toggle_fullscreen(),desc="Toggle fullscreen"),
    Key([mod],"f", lazy.window.toggle_floating(),desc="Toggle floating"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"],"Return",lazy.layout.toggle_split(),desc="Toggle between split and unsplit sides of stack"),

    #qtile
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    #rofi 
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Spawn a command using a prompt widget"),

    # dropdowns
    Key([mod], "t", lazy.group['5'].dropdown_toggle("term")),
    Key([mod], "c", lazy.group['5'].dropdown_toggle("emacs")),
    Key([mod], "v", lazy.group['5'].dropdown_toggle("files"))
]
#----------------------------------------------#

#   ____                           
#  / ___|_ __ ___  _   _ _ __  ___ 
# | |  _| '__/ _ \| | | | '_ \/ __|
# | |_| | | | (_) | |_| | |_) \__ \
#  \____|_|  \___/ \__,_| .__/|___/
#                       |_|        
#-- some call it groups
#-- and some call it workspaces

#----------------------------------------------#
# main_groups = [Group(i) for i in "ABCD"] #group names
# main_groups = [Group(i) for i in "" ] #group icons
# main_groups = [Group(f"{i+1}", label="󰏃") for i in range(4)]
main_groups = [Group(f"{i+1}", label="") for i in range(4)]

dropdown_config = {
    "height" : 0.8,
    "weidth" : 0.8,
    "x" : 0.1,
    "y" : 0.1
}

groups = [
    *main_groups,
    ScratchPad('5',[
               DropDown('term',"alacritty",**dropdown_config),
               DropDown('emacs',"emacs",**dropdown_config),
               DropDown('files',"nautilus",**dropdown_config)
               ])
]

dgroups_key_binder = simple_key_binder("mod4") # mod + group num to switch to it
#----------------------------------------------#

#   _                            _       
# | |    __ _ _   _  ___  _   _| |_ ___ 
# | |   / _` | | | |/ _ \| | | | __/ __|
# | |__| (_| | |_| | (_) | |_| | |_\__ \
# |_____\__,_|\__, |\___/ \__,_|\__|___/
#             |___/                     

#----------------------------------------------#
layout_theme = {
    "border_focus": [colors["purple"]],
    "border_normal": [colors["black"]],
    "border_width": 4,
    "margin": 4
}

layouts = [
    layout.Columns(**layout_theme),
    layout.VerticalTile(**layout_theme),
    layout.Floating(**layout_theme),
#     layout.Bsp(**layout_theme),
#     layout.Matrix(**layout_theme),
#     layout.Max(**layout_theme),
    # layout.MonadTall(**layout_theme),
#     layout.MonadThreeCol(**layout_theme),
#     layout.MonadWide(**layout_theme),
#     layout.RatioTile(**layout_theme),
#     layout.Slice(**layout_theme),
#     layout.Spiral(**layout_theme),
#     layout.Stack(**layout_theme),
#     layout.Tile(**layout_theme),
#     layout.TreeTab(**layout_theme),
#     layout.Zoomy(**layout_theme),
]
#----------------------------------------------#

# __        ___     _            _       
# \ \      / (_) __| | __ _  ___| |_ ___ 
#  \ \ /\ / /| |/ _` |/ _` |/ _ \ __/ __|
#   \ V  V / | | (_| | (_| |  __/ |_\__ \
#    \_/\_/  |_|\__,_|\__, |\___|\__|___/
#                     |___/              
#-- Things we put in the bar you know ;)

#----------------------------------------------#
widget_defaults = dict(
    font=font,
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

powerline = {"decorations": [PowerLineDecoration(path="rounded_left")]}
powerliner = {"decorations": [PowerLineDecoration(path="rounded_right")]}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    "  ",
                    fontsize=18,
                    foreground=colors["black"],
                    background=colors["orange"],
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("rofi -show drun")},
                    **powerline
                ),
                widget.GroupBox(
                    active=colors["purple"],
                    inactive=colors["cyan"],
                    highlight_method='line',
                    highlight_color=colors["black"],
                    this_current_screen_border =colors["pink"],
                    background=colors["semi-black"],**powerline
                ),
                widget.CurrentLayoutIcon(
                    use_mask = True,
                    foreground = colors["white"],
                    background=colors["pink"],**powerline
                ),
                widget.WindowName(
                    format='{}',
                    # format='{name}',
                    max_chars=30,
                    foreground=colors['yellow'],
                    background=colors["bar"],**powerliner
                ),
                widget.Clock(
                    format="󰃭 %d-%B %a   %I:%M %p",
                    foreground=colors["cyan"],
                    background=colors["purple-sky"],
                    **powerline
                ),
                widget.Spacer(
                    lenght=700,
                    background=colors["bar"],**powerliner
                              ),
                widget.WidgetBox(
                    widgets=[

                        # widget.Systray(background=colors["semi-black"]),
                        widget.TextBox(
                            "󰤥 ",
                            fontsize=18,
                            mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(wifi)},
                            foreground=colors["cyan"],
                            background=colors["purple-sky"]
                        ),
                        widget.TextBox(
                            " ",
                            fontsize=18,
                            mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("blueman-manager")},
                            foreground=colors["cyan"],
                            background=colors["purple-sky"]
                        ),
                    ],
                    text_open= "󰦭 ",
                    text_closed= "󰦬 ",
                    fontsize=18,
                    foreground=colors["black"],
                    background=colors["green"],**powerliner
                ),
                widget.Battery(
                    charge_char= "󰢝",
                    discharge_char= "󰁿",
                    full_char= "󱟢",
                    format='{char} {percent:2.0%}',
                    update_interval=1,
                    fontsize=18,
                    low_percentage=0.2,
                    low_foreground=colors["red"],
                    foreground=colors["white"],
                    background=colors["purple"],
                ),
                widget.Backlight(
                    backlight_name="nvidia_0",  
                    format="󰃠 {percent:2.0%}",
                    fontsize=18,
                    foreground=colors["semi-black"],
                    background=colors["orange"],**powerliner
                ),
                widget.Volume(
                    fmt="󰕾 {}",
                    get_volume_command=home + ".config/qtile/volume.sh",
                    fontsize=18,
                    foreground=colors["orange"],
                    background=colors["purple-sky"],**powerliner
                ),
                widget.KeyboardLayout(
                    foreground=colors["semi-black"],
                    update_interval=0.1,
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(home + ".local/bin/switchlang")},
                    background=colors["yellow"],**powerliner
                ),
                widget.TextBox(
                    "  ",
                    fontsize=18,
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(exit_command)},
                    background=colors["red"],**powerline
                ),
            ],
            24,
            border_color = colors["bar"],
            border_width = [3,5,3,5],
            margin = [3,30,3,30],
            background=[colors["bar"]]
        ),
    ),
]
#----------------------------------------------#

#  _____ _             _   _             
# |  ___| | ___   __ _| |_(_)_ __   __ _ 
# | |_  | |/ _ \ / _` | __| | '_ \ / _` |
# |  _| | | (_) | (_| | |_| | | | | (_| |
# |_|   |_|\___/ \__,_|\__|_|_| |_|\__, |
#                                  |___/ 
#----------------------------------------------#

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="gnome-calculator"),  # Calculator
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
auto_minimize = True
focus_on_window_activation = "smart"
reconfigure_screens = True
#----------------------------------------------#

#  ____  _             _               
# / ___|| |_ __ _ _ __| |_ _   _ _ __  
# \___ \| __/ _` | '__| __| | | | '_ \ 
#  ___) | || (_| | |  | |_| |_| | |_) |
# |____/ \__\__,_|_|   \__|\__,_| .__/ 
#                               |_|    
#----------------------------------------------#
@hook.subscribe.startup_once
def autostart():
    sp.Popen([startup_script])
#----------------------------------------------#

#  __  __                
# |  \/  | ___  _ __ ___ 
# | |\/| |/ _ \| '__/ _ \
# | |  | | (_) | | |  __/
# |_|  |_|\___/|_|  \___|
#-- using dropdown in fullscreen mode
#-- some stuff that is important.... i guess !?

#----------------------------------------------#
@hook.subscribe.client_focus
def bring_focus_to_front(window):
    current_wid = window.info()["id"]
    if current_wid in bring_focus_to_front.fullscreen_to_restore:
        for wid in bring_focus_to_front.fullscreen_to_restore:
            qtile.select([("window", wid)]).cmd_enable_fullscreen()
            bring_focus_to_front.fullscreen_to_restore.remove(wid)
    elif not window.info()["fullscreen"]:
        all_group_windows = qtile.select(
            [("group", window.group.name)]
        ).windows
        for group_window in all_group_windows:
            if group_window.info()["fullscreen"]:
                wid = group_window.info()["id"]
                qtile.select([("window", wid)]).cmd_disable_fullscreen()
                bring_focus_to_front.fullscreen_to_restore.append(wid)

bring_focus_to_front.fullscreen_to_restore = []
#----------------------------------------------#

# this can be used to configure input devices for wayland.
wl_input_rules = None

# i dont know what is this thing ;)
wmname = "LG3D"
#----------------------------------------------#
