#!/bin/bash
pushd /root > /dev/null

distro_name="ArchExperience"

echo
echo "[*] Executing $distro_name post-installation procedure"

echo
echo "[*] Before we start you need to edit the mirrorlist"
echo "[*] Select your preferred editor to continue (default: vim)"
select editor in "vim" "nano"; do
    [[ $editor != "nano" ]] && [[ $editor != "vim" ]] && editor="vim"
    $editor /etc/pacman.d/mirrorlist || exit $?
    break
done

echo
echo "[*] Installing Arch Linux system packages"
pacman-key --init || exit $?
pacman-key --populate archlinux || exit $?
pacman -Syu --color=auto --noconfirm base base-devel || exit $?

echo
echo "[*] Changing password for root"
passwd || exit $?

echo
echo "[*] Creating new regular user with UID 1000"
read -p "New username: " -r wsl_username
groupdel -f docker
useradd -m -u 1000 -G wheel -s /bin/zsh $wsl_username || exit $?

echo
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/allow-wheels-nopasswd
echo "[*] Changing password for $wsl_username"
passwd $wsl_username || exit $?

groupadd docker || exit $?
usermod -aG docker $wsl_username || exit $?

rm -f .zshrc post-install.sh || exit $?

echo
popd > /dev/null
