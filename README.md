Este Script en Bash se vale del programa Nmap para realizar el análisis, por lo que es necesario tenerlo instalado en el equipo. Si no se encuentra instalado Nmap, el Script lo hará por tí automáticamente al ejecutarlo.

Para poder correr el Script, hay que hacerlo con permisos elevados y apuntando a la dirección IP que desees analizar. A continuación un par de ejemplos de cómo se ejecutaría correctamente:

sudo bash "nombre del Script" "dirección IP"      --> Ejemplo 1.
sudo bash Port-Scanner.sh 192.168.0.69            --> Ejemplo 2.