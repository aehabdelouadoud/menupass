# Pass Menu - A BEMenu Frontend for Pass

A bash script that provides a graphical interface for [pass](https://www.passwordstore.org/) (the standard unix password manager) using [bemenu](https://github.com/Cloudef/bemenu). Designed for Wayland/X11 environments with Gruvbox Material theme integration.

![demo](https://github.com/user-attachments/assets/5c2b210e-6ca3-4c7b-bda4-a72c5fbabe7d)

## Features

- 📁 Browse password store entries in a clean menu interface
- 🔐 Copy passwords or specific fields (username, email, etc.)
- 🎨 Gruvbox Material color scheme integration
- 📋 Automatic clipboard clearing after 45 seconds
- 🔍 Case-insensitive search
- 🔄 Supports both X11 (`xclip`) and Wayland (`wl-copy`)
- 📱 Desktop notifications support

## Dependencies

- [pass](https://www.passwordstore.org/) - Password manager
- [bemenu](https://github.com/Cloudef/bemenu) - Dynamic menu library
- `wl-copy` (Wayland) or `xclip` (X11) - Clipboard utilities
- [FiraCode Nerd Font](https://www.nerdfonts.com/) (or substitute with your preferred font)
- `notify-send` (optional for notifications)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/aehabdelouadoud/passmenu.git
   cd pass-menu
   chmod +x pass-menu.sh
   ```

2. Install dependencies (example for Arch Linux):
   ```bash
   sudo pacman -S pass bemenu wl-clipboard xclip libnotify
   ```

3. Make sure your password store is initialized:
   ```bash
   pass init <gpg-id>
   ```

## Usage

Run the script directly:
```bash
./pass-menu.sh
```

Recommended: Create a keyboard shortcut (e.g., in Sway/i3 or your DE) to launch the script.

## Configuration

### Environment Variables
- `PASSWORD_STORE_DIR`: Set to custom password store location (default: `~/.password-store`)
  
Example:
```bash
export PASSWORD_STORE_DIR="$HOME/my-passwords"
```

### Menu Customization
Modify the `MENU` variable in the script to:
- Change colors (current theme: Gruvbox Material)
- Adjust font and size
- Modify menu dimensions
- Change prompt character

Example modification:
```bash
MENU="bemenu \
    --nb '#1d2021' --nf '#ebdbb2' \
    ... (other parameters)
    --fn 'YourFont 10'"
```

## Security Note

- Clipboard contents are automatically cleared after 45 seconds
- Ensure you have proper security measures for your password store
- Recommend using a clipboard manager that doesn't store history

## License

[MIT](LICENSE)

<p align="right"><a href="#readme-top">back to top</a></p>
