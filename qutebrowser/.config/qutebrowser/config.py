c.tabs.position = "bottom"
c.completion.shrink = True
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "wa": "https://wiki.archlinux.org/?search={}",
    "g": "https://github.com/search?q={}",
    "d": 'https://duckduckgo.com/?q={}',
    "c": 'https://boards.4chan.org/{}/',
    "r": 'https://www.reddit.com/r/{}',
    "w": 'https://en.wikipedia.org/wiki/={}',
    "y": 'https://www.youtube.com/results?search_query={}',
}

monospace = "16px 'Hack'"

c.fonts.hints = monospace

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

# Font used for the hints.
c.fonts.hints = "bold 13px 'DejaVu Sans Mono'"

# Chars used for hint strings.
c.hints.chars = "asdfghjklie"

# Leave insert mode if a non-editable element is clicked.
c.input.insert_mode.auto_leave = True

# Automatically enter insert mode if an editable element is focused
# after loading the page.
c.input.insert_mode.auto_load = True

c.url.start_pages = "https://news.ycombinator.com"

c.zoom.default = '175%'
