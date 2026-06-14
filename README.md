# Theo Trainer 🐕

Raspberry Pi-based sound desensitization system for training Theo (Border Collie) not to react to door sounds.

## What It Does

Plays door knock and key sounds at random intervals (5-30 min) through a Bluetooth speaker near the apartment door. Variations in pitch, tempo, echo, and volume keep the sounds unpredictable.

## Hardware

- Raspberry Pi 3B (`theo-trainer`, `10.0.0.24`)
- JBL Bluetooth speaker (MAC: `FC:A8:9A:93:3D:FB`)
- Runs headless — boots, connects Bluetooth, starts playing automatically

## Setup

### 1. Install dependencies
```bash
sudo apt install ffmpeg ffplay pulseaudio pulseaudio-module-bluetooth vim
```

### 2. Pair JBL speaker
```bash
bluetoothctl
scan on
pair FC:A8:9A:93:3D:FB
trust FC:A8:9A:93:3D:FB
connect FC:A8:9A:93:3D:FB
```

### 3. Copy scripts
```bash
cp scripts/*.sh ~/scripts/
chmod +x ~/scripts/*.sh
```

### 4. Add source sounds
Place sound files in `~/Videos/`:
- `keysound.mp4`
- `knockdoor.MOV`

### 5. Generate variations
```bash
~/scripts/generate-variations.sh
```

### 6. Install systemd service
```bash
sudo cp systemd/theo-trainer.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable theo-trainer.service
sudo systemctl start theo-trainer.service
```

## Usage

```bash
# Check status
sudo systemctl status theo-trainer.service

# View logs
journalctl -u theo-trainer.service -f

# Stop
sudo systemctl stop theo-trainer.service

# Restart
sudo systemctl restart theo-trainer.service
```

## Files

```
scripts/
  theo-trainer.sh          # Main loop — random sound at random intervals
  bt-connect.sh            # Auto-connect Bluetooth on boot
  generate-variations.sh   # Generate pitch/tempo/echo variations
systemd/
  theo-trainer.service     # Systemd unit for auto-start on boot
```

## SSH Access

```bash
ssh wengwei@10.0.0.24
# or
ssh wengwei@theo-trainer.local
```
