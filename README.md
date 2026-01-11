# dotfiles

My personal collection of configuration files (dotfiles) managed with GNU Stow.

## What are dotfiles?

Dotfiles are configuration files that begin with a dot (hence the name) and are typically stored in your home directory. They customize and configure various applications, shells, and tools on Unix-like systems.

## What is GNU Stow?

GNU Stow is a symlink farm manager that takes distinct packages of software and/or data located in separate directories on the filesystem, and makes them appear to be installed in the same place. It's commonly used to manage dotfiles by creating symlinks from a central repository to your home directory.

## Included Configurations

This repository includes configurations for:

- **Alacritty** - Terminal emulator configuration (`alacritty.toml`)
- **VS Code** - Editor settings and keybindings (`settings.json`, `keybindings.json`)
- **Zsh** - Z Shell configuration (`.zshrc`)

## Prerequisites

Before using these dotfiles, ensure you have:

- [GNU Stow](https://www.gnu.org/software/stow/) installed
- Git installed for cloning the repository

## Installation

1. Clone this repository to your home directory (or wherever you prefer to keep your dotfiles):

```bash
cd ~
git clone https://github.com/yourusername/dotfiles.git
# or if you've forked/created your own version
git clone git@github.com:yourusername/dotfiles.git
```

2. Navigate to the dotfiles directory:

```bash
cd ~/dotfiles
```

3. Use Stow to symlink the configurations you want to install:

```bash
# Install all configurations
stow */

# Or install specific configurations individually
stow alacritty    # Terminal configuration
stow Code         # VS Code configuration  
stow zsh          # Zsh configuration
```

Stow will create symlinks from the files in this repository to your home directory.

## Updating Configurations

After making changes to your dotfiles, simply commit and push them:

```bash
git add .
git commit -m "Update configuration"
git push origin main
```


## Adding New Configurations

To add a new configuration:

1. Create a new directory in the repository with the name of the application
2. Place the configuration files in that directory
3. Use `stow <directory-name>` to symlink the new configuration

For example, if you wanted to add a new configuration for a program called `myapp` with config file `.myapprc`:

```bash
mkdir myapp
mv ~/.myapprc myapp/
stow myapp
```

## Backup and Sync

Since these are stored in a Git repository, you can easily sync them across machines by pulling the latest changes:

```bash
cd ~/dotfiles
git pull origin main
```

## Contributing

Feel free to fork this repository and customize it for your own needs. If you find any issues or have suggestions, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.