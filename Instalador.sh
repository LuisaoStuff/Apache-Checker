#!/bin/bash

if [ "$USER" != "root" ]; then
	echo "Debes tener permisos de superusuario"
	sleep 1.5
	clear
	clear && exit
fi

echo "Comprobando la existencia de Apache..."

comprobar=$(find /var -name "www" | wc -l)

if [ $comprobar -lt 1 ]; then

	echo "No se ha encontrado ninguna instalación de apache."
	sleep 1.5
	clear
	clear && exit

fi

ruta=`dirname $0`

echo "Se ha encontrado una instalación de apache."

echo "Comprobando existencia del paquete 'sendmail' en el sistema"

set `whereis sendmail`

if [ $# -le 1 ]; then

	echo "El paquete 'sendmail' no está instalado."
	echo "Instalando 'sendmail'..."
	apt-get install -y sendmail
else

	echo "El paquete 'sendmail' ya estaba instalado."

fi

echo "A continuación deberás introducir el e-mail del administrador"
read -p "e-mail:	" email

clave=$(pwgen 6 1)

echo "Subject: Confirmar Apache-Checker" > /tmp/email.txt
echo "Clave >>> $clave" >> /tmp/email.txt

sendmail $email < /tmp/email.txt &
rm /tmp/email.txt

while true; do

	comprobar=$(ps aux | grep sendmail | grep -v grep | wc -l)
	if [ $comprobar -eq 1 ];then
		break
	else
		clear
		echo "Mandando e-mail a $email "
		sleep 0.3
		clear
		echo "Mandando e-mail a $email ."
		sleep 0.3
		clear
		echo "Mandando e-mail a $email .."
		sleep 0.3
		clear
		echo "Mandando e-mail a $email ..."
		sleep 0.3
	fi

done

echo "Le hemos enviado un correo a $email con una clave de confirmación. Compruebe en la carpeta de SPAM."
contador=3
read -p "Introduce la clave recibida: " confirmar

while [ $contador -ne 0 ]; do
	if [ "$confirmar" == "$clave" ];then
		break
	fi
	contador=$(($contador-1))
	echo "Clave incorrecta, intentos restantes($contador)"
	read -p "Introduce la clave recibida: " confirmar
done

if [ "$confirmar" == "$clave" ];then
	echo "E-mail confirmado."
	echo "Instalación completada."
	echo "$email" > $ruta/administrador_e-mail.txt
else
	echo "E-mail no confirmado."
	echo "Instalación incompleta."
fi

sleep 2 && exit
