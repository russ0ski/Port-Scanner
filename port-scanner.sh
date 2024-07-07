#!/bin/bash

# Realizamos una comprobación de si el programa Nmap se encuentra instalado
test -f /usr/bin/nmap

# En caso de ser así, se informa al usuario de ello
if [ $(echo $?) -eq 0 ]; then
	echo
	echo "-> Los programas necesarios están instalados, realizando análisis.."
# En caso contrario, se informa también y se procede a instalar Nmap
else
	echo
	echo "-> Faltan programas por instalar, espera un momento.."
	apt update > /dev/null && apt install nmap -y > /dev/null
	echo "-> Todo listo ahora!, realizando análisis.."
fi

ip=$1

# Lanzamos una traza ICMP a la dirección IP proporcionada por el usuario y almacenamos el resultado en un fichero
ping -c 1 $ip > ping.log

# Indicamos en un bucle For que si el TTL encontrado al realizar el Ping se encuentra entre
# 60 y 70, entonces se trata de un sistema Linux y por tanto lo informamos al usuario
for i in $(seq 60 70)
do
	if test $(grep ttl=$i ping.log -c) = 1; then
		echo
		echo "-> Se trata de un sistema operativo Linux."
	fi
done

# Indicamos en un bucle For que si el TTL encontrado al realizar el Ping se encuentra entre 120 y 130,
# entonces se trata de un sistema Windows y por tanto lo informamos al usuario
for i in $(seq 120 130)
do
        if test $(grep ttl=$i ping.log -c) = 1; then
                echo
		echo "-> Se trata de un sistema operativo Windows."
        fi
done

# Borramos el fichero "ping.log" creado anteriormente porque ya no es necesario
rm ping.log

echo
# Imprimimos por pantalla un mensaje indicando que a continuación se mostrará el resultado que arroja Nmap
echo "-> Los Puertos que se encuentran abiertos y sus Servicios corriendo son los siguientes:"
echo

# Lanzamos el comando de Nmap que se encangará de analizar la IP en busca de los Puertos abiertos y sus Servicios,
# y almacenará el resultado final en un fichero llamado "Escaneo.txt" para que pueda ser consultado posteriormente
nmap -p- -sVCS --open --min-rate 5000 -n -Pn $ip -oN Escaneo.txt
echo
echo "-> Análisis completado con éxito, el reporte completo se ha guardado en el fichero Escaneo.txt"
echo