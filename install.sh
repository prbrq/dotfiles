#!/bin/bash

ln -sf "$(pwd)/code/settings.json" ~/.config/Code/User/settings.json
ln -sf "$(pwd)/code/keybindings.json" ~/.config/Code/User/keybindings.json

bash ./code/install_extensions
