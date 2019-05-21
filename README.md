# Apache-Checker
Esto es un script que simplemente se encarga de *comprobar* el correcto funcionamiento de *Apache*. *Si* se diese el caso de que *no está en ejecución*, *inicia el servicio* y *manda un correo al administrador*.

### Requisitos
Tener instalado el paquete **apache2**
(Si no lo tienes instalado ejecuta como *root*: `apt-get install apache2`)

### Instrucciones

`git clone https://github.com/LuisaoStuff/Apache-Checker.git` < *Clonar este repositorio en tu máquina*

`./Instalador.sh` < *Solo es necesario ejecutarlo una vez*

`./Comprobar.sh` < *Cada vez que quieras comprobar el estado de Apache*
