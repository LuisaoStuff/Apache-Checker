#!/bin/bash

if [ "$USER" != "root" ]; then
	echo "Debes tener permisos de superusuario"
	sleep 1.5
	clear
	clear && exit
fi

ruta=`dirname $0`

clear
echo "Comprobando estado de Apache2"
set `systemctl status apache2 | grep Active`
sleep 1
fecha=$(echo $6)
hora=$(echo $7)
zonahoraria=$(echo $8)

if [ $2 != "active" ]; then
	email=$(cat $ruta/administrador_e-mail.txt)
	echo "Apache2 lleva inactivo desde el $6 a las $7"
	echo "Reactivando el proceso"
	sleep 1
	systemctl start apache2
	sleep 1
	set `systemctl status apache2 | grep Active`

	if [ $2 != "active" ]; then
		echo "Subject: Servidor Apache apagado" > /tmp/email.txt
		echo "El servidor apache llevaba apagado desde la fecha $fecha a la hora $hora $zonahoraria" >> /tmp/email.txt
		echo "No se ha logrado reactivar el servicio, se requerirá una auditoría." >> /tmp/email.txt
	else
		echo "Subject: Servidor Apache apagado" > /tmp/email.txt
		echo "El servidor apache llevaba apagado desde la fecha $fecha a la hora $hora $zonahoraria" >> /tmp/email.txt
		echo "Se ha reactivado el servicio." >> /tmp/email.txt
	fi
	
	sendmail $email < /tmp/email.txt &
	rm /tmp/email.txt

	while true; do

		comprobar=$(ps aux | grep sendmail | grep -v grep | wc -l)
		if [ $comprobar -eq 1 ];then
			break
		else
			clear
			echo "Mandando e-mail al administrador"
			sleep 0.3
			clear
			echo "Mandando e-mail al administrador."
			sleep 0.3
			clear
			echo "Mandando e-mail al administrador.."
			sleep 0.3

			clear
			echo "Mandando e-mail al administrador..."
			sleep 0.3
		fi

	done

	
else
	echo "Apache2 lleva activo sin problemas desde el $6 a las $7"
fi
