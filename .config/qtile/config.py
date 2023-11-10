import os
import subprocess as sp
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder

mod = "mod4"
terminal = guess_terminal()
font = "JetBrainsMono Nerd Font"
home = os.path.expanduser('~')
wifi = os.path.join(home,".local/bin/rofi-wifi-menu")
exit_command = "rofi -show powermenu -theme ~/.local/share/rofi/themes/nord.rasi -modi powermenu:rofi-power-menu"
def change_kblayout():
    qtile.cmd_spawn("sh -c ~/.local/bin/switchlang")

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
    "bar":"#44475aB3"
} #This is the offical dracula theme platte
  #and please ignore the naming


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

    #MORE
    Key([mod, "shift"],"Return",lazy.layout.toggle_split(),desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    #floating and fullscreen
    Key([mod],"m", lazy.window.toggle_fullscreen(),desc="Toggle fullscreen"),
    Key([mod],"f", lazy.window.toggle_floating(),desc="Toggle floating"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    #qtile
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    #rofi 
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Spawn a command using a prompt widget"),
]

#Groups

# groups = [Group(i) for i in "ABCD"] #group names
# groups = [Group(i) for i in "" ] #group icons
groups = [Group(f"{i+1}", label="󰏃") for i in range(4)]


dgroups_key_binder = simple_key_binder("mod4") # mod + group num to switch to it

#layouts
layout_theme = {
    "border_focus": [colors["purple"]],
    "border_normal": [colors["black"]],
    "border_width": 4,
    "margin": 4
}

layouts = [
    layout.RatioTile(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Floating(**layout_theme),
]

widget_defaults = dict(
    font=font,
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.LaunchBar(progs=[(" Apps","rofi -show drun")],foreground=colors["green"]),
                widget.GroupBox(active=colors["purple"],
                                inactive=colors["cyan"],
                                highlight_method='line',
                                highlight_color=colors["black"],
                                this_current_screen_border =colors["pink"],),
                
                widget.WindowName(format='{name}',max_chars=30,foreground=colors['yellow']),

                widget.Chord(
                    chords_colors={
                        "launch": (colors["red"], colors["white"]),
                    },
                    name_transform=lambda name: name.upper(),
                ),

                widget.Clock(format="%I:%M %p %m-%d %a ",foreground=colors["cyan"]),
                widget.Spacer(lenght=700),
                # widget.Systray(background=colors["semi-black"]),
                widget.Sep(),
                widget.LaunchBar(progs=[("󰤥 ",wifi)],foreground=colors["cyan"]),
                widget.Sep(),
                widget.LaunchBar(progs=[("","blueman-manager")],foreground=colors["cyan"]),
                widget.Sep(),
                widget.TextBox("󰂁"),
                widget.Battery(format='{char} {percent:2.0%}',update_interval=1),
                widget.Sep(),
                widget.KeyboardLayout(foreground=colors["orange"],update_interval=0.1,
                                                          mouse_callbacks={"Button1":change_kblayout},), 
                widget.Sep(),
                widget.LaunchBar(progs=[("󰿅 exit",exit_command)],foreground=colors["red"]),
                widget.CurrentLayoutIcon(),
            ],
            24,
            border_color = colors["bar"],
            border_width = [3,5,3,5],
            margin = [3,30,3,30],
            background=[colors["bar"]]
        ),
    ),
]

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
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    script =  os.path.expanduser('~/.config/qtile/script.sh')
    sp.Popen([script])
