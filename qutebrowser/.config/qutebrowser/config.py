
c.colors.hints.bg = "yellow"
c.colors.hints.fg = "black"

c.tabs.position = "bottom"
c.completion.shrink = True
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "wa": "https://wiki.archlinux.org/?search={}",
    "g": "https://github.com/search?q={}",
    "d": 'https://duckduckgo.com/?q={}',
    "c": 'https://boards.4chan.org/{}/',
    "sr": 'https://www.old.reddit.com/r/{}',
    "w": 'https://en.wikipedia.org/wiki/={}',
    "y": 'https://www.youtube.com/results?search_query={}',
}

c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}

c.aliases = {
    "q": "tab-close",
    "w": "session-save",
    "wq": "quit --save",
    "mpv": "spawn -d mpv --force-window=immediate {url}",
    "pass": "spawn -d pass -c",
}
config.bind(' p', 'spawn --userscript qute-pass --dmenu-invocation dmenu')
config.bind(' k', "spawn bash -c 'feh --zoom fill ~/Pictures/qutebrowser-cheatsheet.png'")

monospace = "14px 'Hack'"

c.editor.command = ['alacritty', '-e', 'nvim', '{}']

c.fonts.hints = "bold 20px 'Hack'"

# Font used in the completion categories.
c.fonts.completion.category = f"bold {monospace}"

# Font used in the completion widget.
c.fonts.completion.entry = monospace

# Font used for the debugging console.
c.fonts.debug_console = monospace

# Font used for the downloadbar.
c.fonts.downloads = monospace

# Font used in the keyhint widget.
c.fonts.keyhint = monospace

# Font used for error messages.
c.fonts.messages.error = monospace

# Font used for info messages.
c.fonts.messages.info = monospace

# Font used for warning messages.
c.fonts.messages.warning = monospace

# Font used for prompts.
c.fonts.prompts = monospace

# Font used in the statusbar.
c.fonts.statusbar = monospace

# Font used in the tab bar.
c.fonts.tabs = monospace

# Chars used for hint strings.
c.hints.chars = "asdfghjklie"

# Leave insert mode if a non-editable element is clicked.
c.input.insert_mode.auto_leave = True

# Automatically enter insert mode if an editable element is focused
# after loading the page.
c.input.insert_mode.auto_load = True

c.url.start_pages = "https://news.ycombinator.com"

c.zoom.default = '175%'

c.auto_save.session = True
