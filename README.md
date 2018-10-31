Dotfiles

Ideas stolen from: https://github.com/Kraymer/F-dotfiles
* Naming convention
    - lowercase for packages in $HOME ex. `vim`
    - titlecase for packages in `/` ex. `Pacman`
    - leading `@` for environment specific packages
    - leading `_` for packages not to be stowed

```
├── @linux
│   └── .config
│       └── sublime-text-3
│           └── Packages -> ../../../_common/Packages
├── @osx
│   └── Library
│       └── Application Support
│           └── Sublime Text 3
│               └── Packages -> ../../../../_common/Packages 
└── _common
    └── Packages
        └── User
            ├── Flake8Lint.sublime-settings
            ├── Monokai (Flake8Lint).tmTheme
            ├── Package Control.sublime-settings        List of packages to install
            └── Preferences.sublime-settings
```
