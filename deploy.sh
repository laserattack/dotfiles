
#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

symlinkFile() {
    local filename="$SCRIPT_DIR/$1"
    local destination

    if [[ -z "${2:-}" ]]; then
        destination="$HOME/$1"
    else
        destination="$HOME/$2/$1"
    fi

    mkdir -p "$(dirname "$destination")"

    if [[ -L "$destination" ]]; then
        echo "[WARNING] $filename already symlinked"
        return
    fi

    if [[ -e "$destination" ]]; then
        echo "[ERROR] $destination exists but it's not a symlink."
        exit 1
    fi

    ln -s "$filename" "$destination"
    echo "[OK] $filename -> $destination"
}

deployManifest() {
    local filename operation destination

    while IFS='|' read -r filename operation destination || [[ -n "$filename" ]]; do
        # Skip comments and empty lines
        [[ -z "$filename" || "$filename" == \#* ]] && continue

        case "$operation" in
            symlink)
                symlinkFile "$filename" "$destination"
                ;;

            *)
                echo "[WARNING] Unknown operation: $operation"
                ;;
        esac
    done < "$SCRIPT_DIR/$1"
}

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <MANIFEST>"
    exit 1
fi

deployManifest "$1"
