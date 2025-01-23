#!/usr/bin/env bash

# Configure menu tool (bemenu with Gruvbox Material colors)
MENU="bemenu \
    --nb '#32302F' --nf '#ddc7a1' \
    --sb '#32302f' --sf '#ebdbb2' \
    --hb '#D8A657' --hf '#292828' \
    --fb '#504945' --ff '#bdae93' \
    --tb '#504945' --tf '#a9b665' \
    --cb '#a9b665' --cf '#EA6962' \
    --bdr '#32302F' \
    --ignorecase \
    -p '󰌆 ' -l 10 --border=0 \
    --fn 'FiraCode Nerd Font 9'"

PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

# Detect clipboard tool
if [ -n "$WAYLAND_DISPLAY" ]; then
    CLIP="wl-copy"
    CLEAR_CLIP="wl-copy --clear"
else
    CLIP="xclip -selection clipboard"
    CLEAR_CLIP="echo -n | xclip -selection clipboard"
fi

# Get password entries
entries=$(find "$PASSWORD_STORE_DIR" -type f -name '*.gpg' 2>/dev/null | \
          sed -e "s|^$PASSWORD_STORE_DIR/||" -e 's/\.gpg$//' | sort)

# Main selection
selected=$(echo "$entries" | eval "$MENU")

[ -z "$selected" ] && exit 0

# Parse password file
content=$(pass show "$selected" 2>/dev/null)
fields=("password: $(head -n1 <<< "$content")")

while read -r line; do
    [[ $line =~ ^([^:]+):\ (.*) ]] && fields+=("${BASH_REMATCH[1]}: ${BASH_REMATCH[2]}")
done < <(tail -n +2 <<< "$content")

# Field selection
field=$(printf "%s\n" "${fields[@]%%:*}" | eval "$MENU -p ''")

[ -z "$field" ] && exit 0

# Extract and copy value
case $field in
    "password")
        pass show -c "$selected" 2>/dev/null
        ;;
    *)
        value=$(grep "^${field}:" <<< "$content" | cut -d: -f2- | xargs)
        echo -n "$value" | $CLIP
        # Clear clipboard after 45 seconds
        (sleep 45; $CLEAR_CLIP) &>/dev/null &
        ;;
esac

# Notification
if command -v notify-send &>/dev/null; then
    notify-send "Pass" "󰌆 Copied ${field}!" -t 2000
fi

