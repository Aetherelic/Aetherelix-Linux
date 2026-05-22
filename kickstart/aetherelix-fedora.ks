# Aetherelix Linux Fedora Kickstart Prototype
#
# Goal:
# Create a Fedora-based Hyprland install target that can later become
# a proper live/remix ISO.
#
# This is an early prototype. The post-install script is still the source of truth.

lang en_GB.UTF-8
keyboard --vckeymap=gb --xlayouts='gb'
timezone Europe/London --utc

network --bootproto=dhcp --device=link --activate
rootpw --lock
user --name=aetherelix --groups=wheel --gecos="Aetherelix User" --password=aetherelix

firewall --enabled
selinux --enforcing
firstboot --disable

bootloader --location=mbr
clearpart --all --initlabel
autopart --type=btrfs

reboot

%packages
@core
@standard
git
curl
wget
bash-completion
dnf-plugins-core
flatpak
%end

%post --log=/root/aetherelix-post.log
set -eux

cat > /etc/motd <<'MOTD'
Aetherelix Linux Fedora Remix Prototype

This system was installed from the early Kickstart prototype.
Run the Aetherelix installer after first login to complete the desktop setup.
MOTD

%end
