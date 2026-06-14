#!/bin/bash
# bt-connect.sh — Auto-connect JBL Bluetooth speaker on boot

sleep 10  # wait for Bluetooth service to be ready
bluetoothctl connect FC:A8:9A:93:3D:FB
sleep 5
pulseaudio --start
