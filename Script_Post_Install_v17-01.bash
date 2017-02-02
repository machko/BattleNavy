#!/bin/bash

#########################################################
#		Script by Machko			#
#	Tester sous Ubuntu 16.04.01			#
#		Date de la release : 02/02/17		#
#	Licence : GPLv3					#
#########################################################


#Le script commence directement par installer le logiciels dialog qui permet la bonne execusion de celui-ci.
echo "Demarrage du script en cours, veilliez patienter !"
sudo apt-get -qq install dialog
mkdir /home/TEMPO
sudo cd /home/TEMPO

HEIGHT=20
WIDTH=70
CHOICE_HEIGHT=15
BACKTITLE="Post-Installation Linux(DEB)"
TITLE="Menu"
MENU="Que voulez-vous faire ? : "

OPTIONS=(00 "Custom Linux (Bientot)"
	 01 "Mise a jours des caches, Systeme, ..."
         02 "Installation programme de base."
	 03 "Installation du lecteur de carte ID."
	 04 "Installation de MultiSystem."
	 05 "Installation de Pipelight. (Alt. Silverlight, Flash)"
	 06 "Utilitaire multimedia, studio"
         09 "Nettoyage du systeme."
	 10 "Installation Utilitaire Tech"
	 11 "Installation de Kodi"
	 99 "Generation Rapport Machine")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
	00)
	    echo "Custom Linux"
		echo "Option en cours de dévlopement."
		cd /home/TEMPO
		
	    ;;
        01)
            echo "Mise a jours des caches, Systeme, ..."
		cd /home/TEMPO
		echo "Mise a jours des caches."
		sudo apt-get -qq update
		sudo apt-get install -fy
		echo "Mise a jours des differents systeme et programme."
		#Ajouter le support de langue FR ICI
		sudo apt-get -qq upgrade
		echo "Mise a jours du systeme par distribution."
		sudo apt-get -qq dist-upgrade
		echo "Mise a jours terminé."
		echo "Appuyer la touche <Entrée> pour continuer..."
		rm -rf /home/TEMPO		
		read touche
            ;;
        02)
            echo "Installation programme de base."
		cd /home/TEMPO
		sudo apt-get -qq update
		sudo apt-get install -fy
		echo "Installation des programmes de base, ..."
		echo "Programme systeme, ..."
		sudo apt-get -qq install wine playonlinux gedit
		echo "Programme multimedia, ..."
		sudo apt-get -qq install amarok audacity blender vlc brasero gimp scratch 
		echo "Programme internet, ..."
		sudo apt-get -qq install firefox thunderbird firefox-locale-fr thunderbird-locale-fr
		#Installation de Skype
		#Prerequis
		sudo apt-get install -qq pavucontrol gnome-alsamixer libsdl1.2debian paman pavumeter
		wget https://go.skype.com/skypeforlinux-64-alpha.deb
		sudo dpkg -i skypeforlinux-64-alpha.deb
		echo "Programme bureautique, ..."
		sudo apt-get -qq install libreoffice 
		echo "Téléchargement de TeamViewer, "
		wget http://download.teamviewer.com/download/teamviewer_i386.deb
		sudo apt-get -qq install libjpeg62 libxtst6
		sudo apt-get -f install
		echo "Installation de TeamVierwer."
		sudo dpkg -i teamviewer_i386.deb
		echo "Appuyer la touche <Entrée> pour continuer..."
		rm -rf /home/TEMPO
		read touche	    
            ;;
        03)
            echo "Installation du lecteur de carte ID."
		cd /home/TEMPO
		sudo apt-get -qq update
		sudo apt-get install -fy
		wget eid.belgium.be/sites/default/files/downloads/eid-archive_2016.2_all.deb
		sudo dpkg -i eid-archive_2016.2_all.deb
		sudo apt-get update
		sudo apt-get install -qq eid-mw 
		sudo apt-get install -qq eid-viewer	
		clear	
		#Ouverture du navigateur Firefox sur l'URL ci-desous pour installation de l'addon belge.
		echo "Téléchargez et installez l'extension eID Belgique"
		echo " Redémarrer Firefox et connectez-vous une première fois à https://my.belgium.be/index.html : ça ne marche pas, et c’est normal : "
		#Procedure a suivre pour la finalisation qui s'affiche a l'ecran.
		
		echo "les certificats viennent seulement d’être ajoutés, il reste à les autoriser…"
		echo "Pour cela allez dans Menu Firefox (à droite) → Préférences → Avancé → Certificats → Afficher les certificats → Chercher les Certificats" 	
		echo "Belgian Root (CA, CA1, CA2, CA3 et/ou CA4),"
		echo "Pour chacun d’eux cliquez sur la ligne située sous la petite flèche de ce certificat. Cliquez sur Modifier la confiance, cochez les" 			
		echo "3 cases et cliquez sur « OK ». Cliquez deux fois sur « OK » pour refermer le Gestionnaire de certificats et les Options."
		firefox https://addons.mozilla.org/fr/firefox/addon/belgium-eid/
		echo "Redémarrer Firefox …"
		echo "Appuyer la touche <Entrée> pour continuer..."
		rm -rf /home/TEMPO
		read touche
            ;;
	04)
	    echo "Installation de MultiSystem."
		cd /home/TEMPO
		sudo apt-get -qq update
		sudo apt-get install -fy
		sudo sh -c 'echo "deb http://liveusb.info/multisystem/depot all main" >> /etc/apt/sources.list.d/multisystem.list'
		wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -
		sudo apt-get -qq update
		sudo apt-get -qq install multisystem
		echo "Appuyer la touche <Entrée> pour continuer..."
		rm -rf /home/TEMPO
		read touche
	    ;;
	05)
	    echo "Installation de Pipelight. (Alt. Silverlight, Flash)"
		cd /home/TEMPO
		echo "ATTENTION, pour installer Pipelight firefox dois etre fermer, il serra automatiquement fermer après."
		echo "Appuyer la touche <Entrée> pour continuer..."
		read touche
		sudo apt-get -qq update
		sudo apt-get install -fy		
		killall firefox-bin
		sudo add-apt-repository ppa:pipelight/stable
		sudo apt-get -qq update
		sudo chown _apt /var/lib/update-notifier/package-data-downloads/partial/
		sudo apt-get install --install-recommends pipelight-multi
		sudo pipelight-plugin --update
		sudo pipelight-plugin --create-mozilla-plugins
		sudo apt-get remove flashplugin-installer adobe-flashplugin --purge
		sudo pipelight-plugin --enable flash
		sudo pipelight-plugin --enable silverlight
		mv ~/.mozilla/firefox/*.default/pluginreg.dat ~/.mozilla/firefox/old_pluginreg.dat
		echo "Appuyer la touche <Entrée> pour continuer..."
		rm -rf /home/TEMPO
		read touche
	    ;;
	06)
	    echo "Utilitaire multimedia, studio"
		cd /home/TEMPO
		sudo apt-get -qq update
		sudo apt-get install -fy
		echo "Traitement audio."
		sudo apt-get -qq install jack ardour jack-tools rakarrack guitarix audacity qtractor hydrogen yoshimi
		echo "Traitement graphique."
		sudo apt-get -qq install blender inkscape gimp mypaint
		echo "Traitement video."
		sudo add-apt-repository ppa:ubuntuhandbook1/dvdstyler
		sudo add-apt-repository ppa:cinelerra-ppa/ppa
		sudo apt-get -qq update
		sudo apt-get -qq install openshot ffmpeg dvdstyler cinelerra-cv
		echo "Appuyer la touche <Entrée> pour continuer..."
		rm -rf /home/TEMPO
		read touche
	    ;;
	09)
	    echo "Nettoyage du systeme."
		cd /home/TEMPO
		#Suppression des résidus de logiciels supprimés
		sudo apt-get autoclean
		sudo apt-get clean
		sudo apt-get autoremove
		#Vidange des corbeilles
		sudo rm -r -f ~/.local/share/Trash/*/*
		find ~/ -name '*~' -print0 | xargs -0 rm
		echo "Appuyer la touche <Entrée> pour continuer..."
		rm -Rf /home/TEMPO
		read touche
	    ;;
	10)
	    echo "Installation Utilitaire Tech"
		cd /home/TEMPO
		sudo apt-get -qq update
		sudo apt-get install -fy
		sudo apt-get install -y gsmartcontrol gparted hardinfo acpi
		rm -rf /home/TEMPO
	    ;;	
	11)
	    echo "Installation de Kodi"
		cd /home/TEMPO
		sudo apt-get install software-properties-common
		sudo add-apt-repository ppa:team-xbmc/ppa
		sudo apt-get update
		sudo apt-get install kodi
	    ;;
	99) 
	    echo "Generation Rapport Machine"	
		cd /home/TEMPO
		sudo apt-get -qq update
		sudo apt-get install -fy
		sudo apt-get install -qq smartmontools acpi stress
		sudo lshw -short >> /home/TEMPO/Conf-Materiel.txt
		sudo smartctl -a /dev/sda >> /home/TEMPO/Rap-Smart-A.txt
		sudo smartctl -a /dev/sdb >> /home/TEMPO/Rap-Smart-B.txt
		sudo smartctl -a /dev/sdc >> /home/TEMPO/Rap-Smart-C.txt
		acpi -V | grep Battery >> /home/TEMPO/Rapport-Bat.txt
		sudo stress -c 8 -m 4 -v -t 3600 >> /home/TEMPO/StressMachine.txt
		rm -rf /home/TEMPO
	    ;;
esac
