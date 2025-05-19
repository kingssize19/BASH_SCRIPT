#!/usr/bin/bash

# Diskleri listeler ve menü sunar

while true; do
	clear
	echo "------- Jetson Disk Yöneticisi -------"
	echo "1) Bağlı diskleri listele"
	echo "2) Disk mount et"
	echo "3) Disk umount et"
	echo "4) Çıkış"
	echo "--------------------------------------"
	read -p "İslem Seciniz : " secim

	case $secim  in
		1)
			echo
			echo "Bagli Diskler : "
			lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,LABEL
			read -p "DEvam etmek için Enter'a basın..."
			;;
		2)
			echo
			echo "Baglanacak disk bilgileri : "
			lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,LABEL
			read -p "Baglanacak aygıt adını girin (örn: sda1) : " disk
			read -p "Mount edilecek klasör yolunu girin (örn: /mnt/usb)" klasor

			sudo mkdir -p "$klasor"
			sudo mount "/dev/$disk" "$klasor"

			if [ $? -eq 0 ]; then
				echo "Basariyla baglandi : /dev/$disk -> $klasor"
			else
				echo "Mount islemi basariz."
			fi
			read -p "Devam etmek için Enter'a basın..."
			;;
		3)
			echo
			echo "Su an bagli olan diskler : "
			df -h | grep ^/dev
			read -p "Umount edilecek aygıt adını girin (örn: sda1) : " disk

			sudo umount "/dev/$disk"

			if [ $? -eq 0 ]; then
				echo "Basarıyla umount edildi: /dev/$disk"
			else
				echo "Umount işlemi başarısız."
			fi
			read -p "Devam etmek için Enter'a basın..."
			;;
		4)
			echo "Çıkılıyor..."
			break
			;;
		*)
			echo "Geçersiz seçim!"
			sleep 1
			;;
		esac
done
