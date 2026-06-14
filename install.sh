#!/bin/bash
# install.sh — Install/update theo-trainer systemd service

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing theo-trainer service..."
sudo cp "$SCRIPT_DIR/systemd/theo-trainer.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable theo-trainer.service
sudo systemctl restart theo-trainer.service
echo "Done! Service installed and running."
sudo systemctl status theo-trainer.service --no-pager
