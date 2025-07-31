#!/bin/bash

BIN_NAME="stackhunter"
INSTALL_PATH="/usr/local/bin/$BIN_NAME"

echo "=> Setting executable permissions on ./$BIN_NAME"
chmod u+x "./$BIN_NAME"

echo "=> Installing $BIN_NAME to $INSTALL_PATH"
if sudo cp "./$BIN_NAME" "$INSTALL_PATH"; then
    echo "✓ Installed successfully!"
    echo "You can now use '$BIN_NAME' as a global command."
else
    echo "✗ Installation failed."
    exit 1
fi