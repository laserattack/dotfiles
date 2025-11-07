#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

symlinkFile() {
    filename="$SCRIPT_DIR/$1"

    if [ -z "$2" ]; then
        destination="$HOME/$1"
    else
        destination="$HOME/$2/$1"
    fi

    mkdir -p $(dirname "$destination")

    if [ -L "$destination" ]; then
        echo "[WARNING] $filename already symlinked"
        return
    fi

    if [ -e "$destination" ]; then
        echo "[ERROR] $destination exists but it's not a symlink." \
             "Please fix that manually"
        exit 1
    fi

    ln -s "$filename" "$destination"
    echo "[OK] $filename -> $destination"
}

deployManifest() {
    for row in $(cat $SCRIPT_DIR/$1); do
        # you can write one-line comments in MANIFEST
        # like Python comments
        if [[ "$row" =~ ^#.* ]]; then
            continue
        fi

        filename=$(echo $row | cut -d \| -f 1)
        operation=$(echo $row | cut -d \| -f 2)
        destination=$(echo $row | cut -d \| -f 3)

        case $operation in
            symlink)
                symlinkFile $filename $destination
                ;;

            *)
                echo "[WARNING] Unknown operation $operation. Skipping..."
                ;;
        esac
    done
}

if [ -z "$@" ]; then
    echo "Usage: $0 <MANIFEST>"
    exit 1
fi

deployManifest $1
