import os
from urllib.request import urlopen

# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

import catppuccin

config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

config.load_autoconfig()

# SECTION: GUI
# last argument (optional, default is False): enable the plain look for the menu rows
catppuccin.setup(c, "macchiato", False)

c.tabs.position = "left"
c.colors.webpage.darkmode.enabled = True

c.scrolling.smooth = False

c.fonts.default_family = "SauceCodePro Nerd Font"
c.fonts.default_size = "12pt"
c.fonts.web.family.fixed = "SauceCodePro Nerd Font Mono"

c.qt.highdpi = True

# IDEA: make completion widget font bigger (maybe)

# IDEA: make fonts.statusbar larger
#
# NOTE: tab groups? Unimplemented

# SECTION: Misc
c.editor.command = [
    "/etc/profiles/per-user/daniel.gonzalez15/bin/neovide",
    "{file}",
    "--",
    # neovim commands here
    "-c",
    "normal {line}G{column0}l",
]

c.auto_save.session = True

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?ia=web&q={}",
    # ':a':       'https://www.amazon.se/s?k={}',
    # NOTE: blocked at work so default to ddg
    ":bra": "https://search.brave.com/search?q={}&source=desktop",
    ":ddg": "https://duckduckgo.com/?ia=web&q={}",
    ":gh": "https://github.com/search?o=desc&q={}&s=stars",
    ":b": "https://www.bing.com/search?q={}",
    # nix search
    ":np": "https://search.nixos.org/packages?query={}",
    ":nm": "https://mynixos.com/search?q={}",
    ":nw": "https://wiki.nixos.org/w/index.php?search={}&title=Special%3ASearch&wprov=acrw1_-1",
    # misc
    ":maps": "https://www.google.com/maps/search/{}",
    ":k": "https://kagi.com/search?q={}",
    # ':p':       'https://pry.sh/{}',
    ":r": "https://www.reddit.com/search?q={}",
    ":w": "https://en.wikipedia.org/wiki/{}",
    ":yt": "https://www.youtube.com/results?search_query={}",
    ":brew": "https://formulae.brew.sh/{}",
}

# TODO: dealbreaker - password manager

# SECTION: Keybindings
# TODO: i think these can be set in autoconfig.yml
# TODO: investigate leader keybindings
config.bind(",r", "config-source")  # hot reload config.py
config.bind("xb", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")
config.bind(
    "xx",
    "config-cycle statusbar.show always never;;config-cycle tabs.show always never",
)


# TODO: keybindings:
# cmd-l to "edit url bar": cmd-set-text: open -t -r {url:pretty}
# ctrl - tab to "next tab""
# ctrl - shift - tab to "prev tab"

# edit url
config.bind("<Meta+l>", "cmd-set-text :open -t -r {url:pretty}")
config.bind("<Ctrl+l>", "cmd-set-text :open -t -r {url:pretty}")

# standard browser forward and back
config.bind("<Ctrl+Tab>", "tab-prev")
config.bind("<Ctrl+Shift+Tab>", "tab-next")

# standard vim jump history
config.bind("<Ctrl+o>", "tab-focus stack-prev")
config.bind("<Ctrl+i>", "tab-focus stack-next")

config.bind("^", "tab-focus last")

# more vim-like marks
config.bind("m", "mode-enter set_mark")
config.bind("`", "mode-enter jump_mark")
# rebind default m and M
config.bind("<Ctrl+m", "quickmark-save")
config.bind("<Ctrl+M", "bookmark-add")
