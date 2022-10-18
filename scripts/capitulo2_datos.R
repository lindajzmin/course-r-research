

# PAQUETES A UTILIZAR -----------------------------------------------------


## INSTALACIÓN -------------------------------------------------------------
## Instalación de paquetes a utilizar en el Capítulo 2

#install.packages("tidyverse")
#install.packages("readxl")
#install.packages("haven")
#install.packages("lubridate")
#install.packages("hms")


## CARGA DE PAQUETES -------------------------------------------------------
## Cargando paquetes a utilizar en el Capítulo 2

library(tidyverse)
library(readxl)
library(haven)
library(lubridate)
library(hms)

## Visualizar los paquetes que contiene tidyverse
tidyverse::tidyverse_packages()



# IMPORTAR DATOS ----------------------------------------------------------

## CSV FILE ------------------------------------------------------------
## Importando archivos .csv
## únicamente especificando nombre de archivo, escribo la ruta
## realizo asignación para guardar el archivo en un objeto llamado players21
players21 <- read_csv("Data/players_21.csv")
view(players21)     #visualizar el conjunto de datos en el visor
remove(players21)   #eliminar objeto del environment rm()


## XLS o XLSX FILE ---------------------------------------------------------
## importar desde Excel
## Podemos especificar el nombre del archivo, hoja y skip
## Guardo el archivo en un objeto llamado vuelos
vuelos <- read_excel("data/VentasVuelos.xlsx", 
                           sheet = "data", skip = 1)
view(vuelos)

## SAV y DTA FILE ----------------------------------------------------------------
## importar desde SPSS
## Guardo el archivo en un objeto llamado estres
estres <- read_sav("data/estres.sav")
view(estres)

## importar desde STATA
## Guardo el archivo en un objeto llamado pasajeros
pasajeros <- read_dta("data/pasajeros.dta")
view(pasajeros)


# PRÁCTICA 2.1 --------------------------------------------------------------
## 1. Cargar el archivo profesores.xlsx y guardarlo en un objeto llamado profesores
profesores <- read_excel("data/profesores.xlsx")

## 2. Cargar el archivo `BasePrograma.xlsx` y guardarlo en un objeto llamado baseprograma.
baseprograma <- read_excel("data/BasePrograma.xlsx")



# ESTRUCTURAS DE DATOS ----------------------------------------------------

## VECTORES ----------------------------------------------------------------
## vector de dimensión 1
x <- 4
is.vector(x)

## creando vectores con concatenar c()
y <- c(11, 13, 15, 20)
y
is.vector(y)

## creando vectores de tipo caracter, elementos en comillas
z <- c("1", "5", "11", "14")
z
is.vector(z)

## operaciones entre vectores de misma dimensión
w <- c(2, 5, 6, 8)
w
y + 2*w - 3

## función para conocer la longitud de los vectores
length(x)
length(y)

## indexación para extraer elementos
w       # reviso los elementos que contiene el vector
w[2]    # extraigo el segundo elemento del vector w
w[-3]   # imprimo el vector w, excepto su tercer elemento

## guardo en un objeto el nuevo vector
w <- w[-3]   # guardo el vector sin su tercer elemento
w


## DATA.FRAMES -------------------------------------------------------------

## crear un data.frame con vectores previamente creados
nombres <- c("Marcela Cox", "Luis Vargas", "David Mieles")
edades <- c(24,32,27)
seguro <- factor(c("IESS", "BMI", "IESS"))

## guardo el data.frame en el objeto pacientes
pacientes <- data.frame(nombres, edades, seguro)
pacientes

## cambiar el nombre de las columnas del data.frame desde su creación
pacientes2 <- data.frame(N1=nombres, N2=edades, seguro)
pacientes2    

## cambiar nombres de columnas de data.frame existente
names(pacientes2) <- c("Name", "Age", "Insurance")
pacientes2

## extraer la edad de David Mieles
pacientes[3,2]

## extraer toda la información de David Mieles
pacientes[3,]

## consultar los valores de la columna de nombres
pacientes$nombres

## conocer la media de las edades de los pacientes
mean(pacientes$edades)


## FUNCIONES BÁSICAS -------------------------------------------------------

## ¿Cuántas personas llenaron la encuesta?
dim(profesores)

## estructura de encuesta
str(profesores)

## nombres de columnas de la encuesta
colnames(profesores)

## Visualización de las primeras 5 encuestas
head(profesores, n=5)

## Visualización de las últimas 5 encuestas
tail(profesores, n=5)

## Total de alumnos con NEE que constan en la encuesta
sum(profesores$`No_Alumnos NEE`)

## Profesor más joven
min(profesores$Edad)

## Profesor de mayor edad
max(profesores$Edad)

## Resumen de la variable No_Alumnos
summary(profesores$No_Alumnos)

summary(profesores)



# TIPOS DE DATOS ----------------------------------------------------------

## NUMÉRICOS ---------------------------------------------------------------

## clase de un vector de 1 elemento
class(5)

## clase de la columna edades del dataset pacientes
class(pacientes$edades)

## vector de tipo caracter
class(z)

## as.numeric()
## cambio de clase caracter a numérico con as.numeric()
class(as.numeric(z))

## parse_number()
## cambio de clase caracter a numérico con parse_number()
class(parse_number(z))


## CADENA DE CARACTERES ----------------------------------------------------

## ¿Qué sucede cuando tus datos producidos no entienden UTF-8?
x1 <- "El Ni\xf1o was particularly bad this year"

## Para corregir el problema de codificación de caracteres
parse_character(x1, locale = locale(encoding = "Latin1"))

## ¿Cómo encontrar la codificación correcta? 
guess_encoding(charToRaw(x1))

## indica la clase de un texto
frase <- "Esta es una cadena de caracteres"
class(frase)

## indica el número de caracteres de una cadena.
str_length(frase)

## combina dos o más cadenas
str_c(frase, " y esto también")


## FACTORES ----------------------------------------------------------------

## creamos una variable que registra meses
fc1 <- c("Dic", "Abr", "Ene", "Mar")
class(fc1)

## defino la lista de niveles válidos
niveles_meses <- c("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic")

## con la función factor() creo el factor
y1 <- factor(fc1, levels = niveles_meses)
class(y1)

## para acceder a los niveles del factor
levels(y1)


## FECHAS Y HORAS ----------------------------------------------------------

## parse_datetime()
## Dato de fecha-hora
fecha1 <- "2010-10-01T2010"
parse_datetime(fecha1)

## parse_datetime()
## Si se omite la hora, será determinada como medianoche.
fecha2 <- "20101010"
parse_datetime(fecha2)

## parse_date() asume aaaa-mm-dd o aaaa/mm/dd.
fecha3 <- "2010-10-01"
parse_date(fecha3)

## parse_time() espera la hh:mm:ss, los segundos y el especificador am/pm son opcionales
parse_time("01:10 am")
parse_time("20:10:01")

## Para obtener la fecha o fecha-hora actual 
today()
now()

## DESDE CADENAS DE CARACTERES
ymd("2017-01-31")
ymd("20170131")
mdy("01-31-2017")
mdy("01312017")
dmy("31-01-2017")
dmy("31012017")
mdy_hm("01/31/2017 08:01")
ymd_hms("2017-01-31 20:11:59")

## DESDE COMPONENTES INDIVIDUALES
ejemplo <- data.frame(anio= c(1994, 1992, 1987),
                      dia= c(21, 02, 15),
                      mes= c(02, 04, 05),
                      hora= c(20, 14, 09),
                      minuto= c(45, 30, 15))
ejemplo

## make_date() para crear fecha
## forma fecha que contiene dia, mes y anio
make_date(ejemplo$anio, ejemplo$mes, ejemplo$dia)

## make_datetime() para crear fecha-hora
# forma fecha-hora
make_datetime(ejemplo$anio, ejemplo$mes, ejemplo$dia, ejemplo$hora, ejemplo$minuto)

## DESDE OTROS TIPOS
as_datetime(today())
as_date(now())



# PRÁCTICA 2.2 --------------------------------------------------------------

## 1. Verifica la estructura del data set `profesores` y define el tipo de cada variable
str(profesores)

## 2. Prepare el data set para el análisis verificando que el tipo de dato de cada variable sea el adecuado, corríjalos.

## Fecha: cambio de tipo POSIXct a tipo Date
profesores$Fecha <- as_date(profesores$Fecha)
class(profesores$Fecha)    #verifico que se realizó el cambio

## Tiempo impartiendo docencia: cambio de tipo caracter a factor
profesores$Tiempo_impartiendo_docencia <- factor(profesores$Tiempo_impartiendo_docencia, 
                                                 levels = c("Menos de 3 años", 
                                                            "De 3 a 6 años", 
                                                            "Más de 6 años"))
class(profesores$Tiempo_impartiendo_docencia)

## AD es necesaria: cambio de tipo caracter a factor
profesores$AD_es_necesaria <- factor(profesores$AD_es_necesaria, 
                                     levels = c(1, 2, 3, 4, 5))

class(profesores$AD_es_necesaria)

## AD es necesaria: recodifico los niveles
profesores$AD_es_necesaria <- fct_recode(profesores$AD_es_necesaria, 
                                         "Totalmente en desacuerdo" ="1",
                                         "En desacuerdo" ="2",
                                         "Ni de acuerdo ni en desacuerdo" = "3",
                                         "De acuerdo" = "4",
                                         "Totalmente de acuerdo" = "5")

levels(profesores$AD_es_necesaria)    # verifico niveles

##AD en cualquier asignatura: cambio de tipo caracter a factor
profesores$AD_en_cualquier_asignatura <- factor(profesores$AD_en_cualquier_asignatura, 
                                                levels = c(1, 2, 3, 4, 5))

##AD en cualquier asignatura: recodifico los niveles
profesores$AD_en_cualquier_asignatura <- fct_recode(profesores$AD_en_cualquier_asignatura, 
                                                    "Totalmente en desacuerdo" ="1",
                                                    "En desacuerdo" ="2",
                                                    "Ni de acuerdo ni en desacuerdo" = "3",
                                                    "De acuerdo" = "4",
                                                    "Totalmente de acuerdo" = "5")


## Leyes para ANEE: cambio de tipo caracter a factor
profesores$Leyes_para_ANEE <- factor(profesores$Leyes_para_ANEE, 
                                     levels = c(1, 2, 3, 4, 5))

## Leyes para ANEE: recodifico los niveles
profesores$Leyes_para_ANEE <- fct_recode(profesores$Leyes_para_ANEE, 
                                         "Totalmente en desacuerdo" ="1",
                                         "En desacuerdo" ="2",
                                         "Ni de acuerdo ni en desacuerdo" = "3",
                                         "De acuerdo" = "4",
                                         "Totalmente de acuerdo" = "5")

## Ratio de ANEE: cambio de tipo caracter a factor
profesores$Ratio_de_ANEE <- factor(profesores$Ratio_de_ANEE, 
                                   levels = c(1, 2, 3, 4, 5))

## Ratio de ANEE: recodifico los niveles
profesores$Ratio_de_ANEE <- fct_recode(profesores$Ratio_de_ANEE, 
                                       "Totalmente en desacuerdo" ="1",
                                       "En desacuerdo" ="2",
                                       "Ni de acuerdo ni en desacuerdo" = "3",
                                       "De acuerdo" = "4",
                                       "Totalmente de acuerdo" = "5")

## Asistente: cambio de tipo caracter a factor
profesores$Asistente_de_clases <- factor(profesores$Asistente_de_clases, 
                                         levels = c(1, 2, 3, 4, 5))

## Asistente: recodifico los niveles
profesores$Asistente_de_clases <- fct_recode(profesores$Asistente_de_clases, 
                                             "Totalmente en desacuerdo" ="1",
                                             "En desacuerdo" ="2",
                                             "Ni de acuerdo ni en desacuerdo" = "3",
                                             "De acuerdo" = "4",
                                             "Totalmente de acuerdo" = "5")

## Instrucción: cambio de tipo caracter a factor
profesores$Suficiente_instruccion <- factor(profesores$Suficiente_instruccion, 
                                            levels = c(1, 2, 3, 4, 5))

## Instrucción: recodifico los niveles
profesores$Suficiente_instruccion <- fct_recode(profesores$Suficiente_instruccion, 
                                                "Totalmente en desacuerdo" ="1",
                                                "En desacuerdo" ="2",
                                                "Ni de acuerdo ni en desacuerdo" = "3",
                                                "De acuerdo" = "4",
                                                "Totalmente de acuerdo" = "5")

## 3. Guarde el data set en un archivo excel en su computadora `r_profesores`.

library(openxlsx)
write.xlsx(profesores, file="data/r_profesores.xlsx", sheetName="cap2")

## para guardar varias hojas en un archivo excel
wb <- createWorkbook()
addWorksheet(wb, "profesores")
addWorksheet(wb, "pacientes")
addWorksheet(wb, "vuelos")

writeData(wb, "profesores", profesores, startRow = 1, startCol = 1)
writeData(wb, "pacientes", pacientes, startRow = 1, startCol = 1)
writeData(wb, "vuelos", vuelos, startRow = 1, startCol = 1)

saveWorkbook(wb, file = "data/excel_test.xlsx", overwrite = TRUE)

## para guardar objeto (menos espacio)
saveRDS(profesores, file = "data/prof1.rds")

## guardar en un nuevo objeto el data set corregido
profesores2 <- profesores

## 4. Extraer la información del 6to encuestado.

encuestado6 <- profesores2[6,]
encuestado6

## 5. Extraer la siguiente información del 5to encuestado: edad, género 
## y si condera que la atención a la diversidad es necesaria.

profesores2[5,c("Genero", "Edad", "AD_es_necesaria")]

## para exportar archivos spss y stata

write_sav(profesores2, "data/profesores_spss.sav")
write_dta(profesores2, "data/profesores_stata.dta")