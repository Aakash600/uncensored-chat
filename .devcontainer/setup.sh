#!/usr/bin/env bash
# Idempotent boot setup for the Gemma 4 E4B uncensored desktop box.
# NOTE: deliberately does NOT install open-webui or build llama.cpp — both live in
# /home/vscode which survives rebuilds. Re-installing here filled the 32G disk.
set -x
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -qq
sudo apt-get install -y -qq \
  xrdp xfce4 xfce4-terminal dbus-x11 x11-xserver-utils policykit-1 \
  lightdm xorgxrdp xserver-xorg-core x11-apps imagemagick \
  python3-venv python3-pip curl 2>&1 | tail -2

# desktop user password
echo "vscode:gemma2026" | sudo chpasswd

# xrdp session = XFCE
sudo mkdir -p /etc/xrdp
sudo tee /etc/xrdp/startwm.sh > /dev/null <<'WM'
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
exec dbus-run-session -- xfce4-session
WM
sudo chmod 755 /etc/xrdp/startwm.sh

sudo tee /etc/xrdp/sesman.ini > /dev/null <<'SES'
[Globals]
ListenAddress=127.0.0.1:3389
EnableSyslog=true

[XrdpSessions]
MaxSessions=1
Policy=Default

[Sessions]
Policy=Default
KillDisconnected=true
DisconnectedTimeLimit=0
IdleTimeLimit=0
AlwaysGroupChecked=false
MaxSessions=1
SES

echo "SETUP_DONE"