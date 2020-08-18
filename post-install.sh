#! /bin/bash

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
pacman -Syyu --needed --noconfirm base base-devel dotnet-runtime || exit $?

echo
echo "[*] Changing password for root"
passwd || exit $?

echo
echo "[*] Creating new regular user with UID 1000"
read -p "New username: " -r wsl_username
groupdel -f docker || ( code=$?; [[ $code != '6' ]] && exit $code )
useradd -m -u 1000 -G wheel $wsl_username || exit $?

echo
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/allow-wheels-nopasswd
echo "[*] Changing password for $wsl_username"
passwd $wsl_username || exit $?

groupadd docker || exit $?
usermod -aG docker $wsl_username || exit $?

mv -f .bashrc~ .bashrc || exit $?
rm -f post-install.sh || exit $?

echo
source .bashrc
