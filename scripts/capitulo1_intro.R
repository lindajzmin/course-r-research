
# CAPÍTULO 1: INTRODUCCIÓN A RSTUDIO

# ENTENDIENDO RSTUDIO -----------------------------------------------------

## Puedo incluir código directo desde la consola
## 8*4
## print("mi nombre es Linda")

## 1. Para ejecutar 1 línea de código a la vez:
## Pulse Ctrl+Enter sobre la línea de código (Atajo)
## O Puede presionar "Run" sobre la línea de código
4*8
print("mi nombre es Linda")

## 2. Para ejecutar varias líneas de código a la vez:
## Seleccione todas las líneas y pulse Ctrl+Enter
## O Puede presionar "Run" sobre las líneas de código seleccionadas
4*8
print("mi nombre es Linda")

## 3. Para ejecutar todo el documento:
## Pulse Ctrl+Shift+Enter
## Puede presionar "Run"



# OBTENIENDO AYUDA --------------------------------------------------------

## 1. DESDE RSTUDIO --------------------------------------------------------
## Proporciona enlaces de ayuda general del entorno de RStudio
help.start()

## busca en el sistema de ayuda la documentación que coincida con un carácter dado.
## introducir cadena de texto.
help.search("time series")

## proporciona detalles para una función específica instalada en tu pc
help("unique")

## busca la frase clave en manuales de ayuda y listas de correo archivadas en el 
## sitio web de R Project en http://search.r-project.org/
RSiteSearch("string")


## 2. DESDE LA WEB ---------------------------------------------------------
## Stack Overflow: http://stackoverflow.com/questions/tagged/r
## Cross Validated: http://stats.stackexchange.com/questions/tagged/r
## R-seek: http://rseek.org/
## R-bloggers: http://www.r-bloggers.com/




# TRABAJANDO CON PAQUETES -------------------------------------------------

# 1. Para instalar un paquete
install.packages("tidyverse")

# 2. Para cargar un paquete
library(tidyverse)

# https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages

## Paquete para actualizar R. Si actualiza R debe hacerlo en la Gui y volver a instalar RStudio
# install.packages("installr")
# library(installr)
# updateR()



# GENERALIDADES ----------------------------------------------------------

## 1. CALCULADORA ----------------------------------------------------------

## multiplicación
20*3            

## división
16/3            

## raíz cuadrada
sqrt(81)        

## logaritmo natural de e
log(exp(1))     

## logaritmo base 10 de 100, también log10(100)
log(100, 10)    

## euler elevado a la 10
exp(10)         

## seno de pi medio
sin(pi/2)       


## 2. ASIGNACIÓN -----------------------------------------------------------

## crear una variable de nombre x
x <- 20*3
x      # imprime el valor guardado en la variable x

## nombres adecuados para variables
dato_calculo <- 5*2
dato_calculo


## 3. FUNCIONES ------------------------------------------------------------

## clase de dato de un número
class(2)

## clase de dato de una palabra
class("dos")

?seq
## generar secuencias de números de 1 en 1 del 1 al 10
seq(from=1, to=10)

## generar secuencias de números del 1 al 10, saltándome 2 números
seq(from=1, to=10, by=2)

## también podemos ingresar los argumentos sin sus etiquetas, pero en el orden correcto
seq(1, 10, 2)

## generar una secuencia de 3 números del 1 al 10, lo divide en partes iguales
seq(from=1, to=10, length.out=3)



# PRÀCTICA 1----------------------------------------------------------------

## Crea un proyecto en tu computadora denominado "SEE_PracticasR".
## En el nuevo proyecto crea un script denominado "practica1".

## En el script: 1. Crea una variable, asígnale el valor de 20.

v1 <- 20

## En el script: 2. Crea otra variable, asígnale el valor de 3.

v2 <- 3

## En el script: 3. Crea otra variable que contenga la resta de la primera y segunda variable que creaste y elévala al cuadrado.

v3 <- (v1-v2)^2

## En el script: 4. Imprime el resultado.

v3
