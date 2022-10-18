

# PAQUETES A UTILIZAR -----------------------------------------------------


## INSTALACIÓN -------------------------------------------------------------
## Instalación de paquetes a utilizar en el Capítulo 2

install.packages("magrittr")
install.packages("datos")


## CARGA DE PAQUETES -------------------------------------------------------
## Cargando paquetes a utilizar en el Capítulo 2

library(tidyverse)
library(magrittr)
library(readxl)
library(datos)

rm(estres, players21)   # eliminar datas no necesarias



# TRANSFORMACIÓN DE DATOS ----------------------------------------------

## RENAME() ------------------------------------------------------------
## Cambiamos el nombre de las variables en el data set profesores2
profesores2 <- rename(profesores2, fecha= Fecha, edad=Edad, sexo=Genero, niveldocencia= Nivel_docencia, 
       tiempo=Tiempo_impartiendo_docencia, alumnos=No_Alumnos, alumnosNEE=`No_Alumnos NEE`,
       necesaria=AD_es_necesaria, asignatura=AD_en_cualquier_asignatura,
       leyes=Leyes_para_ANEE, ratio=Ratio_de_ANEE, asistente=Asistente_de_clases,
       instruccion=Suficiente_instruccion, material=Material_utilizado)
colnames(profesores2)

library(openxlsx)
write.xlsx(profesores2, file="data/r_profesores.xlsx", sheetName="cap3")


## SELECT() ------------------------------------------------------------
## Selecciono las variables que deseo del conjunto de datos:
## indicadores:
indicador_1a <- select(profesores2, sexo, edad, alumnos, niveldocencia)
colnames(indicador_1a)
indicador_1a <- select(profesores2, 2, 3, 4, 6)


## PIPE %>% ---------------------------------------------------------
## Sin Pipe
select(profesores2, sexo, edad, alumnos, niveldocencia)

## Con Pipe
profesores2 %>% select(sexo, edad, alumnos, niveldocencia)


## FILTER() ----------------------------------------------------------------
## Filtrar observaciones
## Delimitar a las personas de 40 o más años
profesores2 %>% 
    select(sexo, edad, alumnos, niveldocencia) %>% 
    filter(edad >= 40)

## Delimitar nuestros datos a la población femenina que no tiene estudiantes 
## con NEE, mostrando solo las variables de edad, alumnos, 
## nivel que imparte docencia y material utilizado.
unique(profesores2$sexo)

profesores2 %>% 
    select(edad, alumnos, alumnosNEE, material) %>% 
    filter(sexo=="Femenino" & alumnosNEE==0)

profesores2 %>% 
    filter(sexo=="Femenino" & alumnosNEE==0) %>% 
    select(edad, alumnos, niveldocencia, material) %>% 
    view()

## Delimitar nuestros datos a la población masculina que tiene 30, 31 
## y 32 años mostrando solo las variables de edad, alumnos, nivel que 
## imparte docencia y material utilizado.
profesores2 %>% 
    filter(sexo=="Masculino" & (edad %in% c(30,31,32))) %>% 
    select(edad, alumnos, niveldocencia, material) %>% 
    view()

## para filtrar fechas
months(profesores2$fecha) # extrae el mes de la columna
day(profesores2$fecha) # extrae el día de la columna
profesores2 %>% 
    filter(months(fecha)=="julio" & day(fecha)==2) %>% 
    view()

## MUTATE() ----------------------------------------------------------------
## Delimitar nuestros datos a la población masculina que tiene
## 30, 31 y 32 años de edad. Vamos a agregar una columna que 
## contenga el número de estudiantes que no tienen NEE. 
## Mostrar las primeras 7 columnas y la última.
profesores2 %>% 
    mutate(sinNEE=alumnos-alumnosNEE) %>% 
    filter(sexo=="Masculino" & (edad %in% c(30,31,32))) %>% 
    select(c(1:7, sinNEE, 14)) %>% 
    view()

## aumentar columna con el día en que los profesores
## llenaron la encuesta 
profesores2 %>% 
    mutate(mesencuesta=months(fecha)) %>% 
    filter(sexo=="Masculino" & (edad %in% c(30,31,32))) %>% 
    select(c(1:7, 14, mesencuesta)) %>% 
    view()

## SUMMARISE() -------------------------------------------------------------
## Indicador 1: Número promedio de estudiantes por profesor
profesores2 %>% 
    summarise(EstudiantesPromedio = sum(alumnos)/n()) %>% 
    view()

## Indicador 3: Número de profesores encuestados
## Indicador 4: Edad promedio de profesores encuestados
## Indicador 5: Número de estudiantes con NEE
profesores2 %>% 
    summarise(TotalProfesores = n(),
              EdadPromedioProfesores = mean(edad),
              EstudiantesNEE = sum(alumnosNEE)) %>% 
    view()


## GROUP_BY() --------------------------------------------------------------
## Indicador 2: Número promedio de estudiantes por sexo y 
## nivel de educación
profesores2 %>% 
    group_by(sexo, niveldocencia) %>% 
    summarise(EstudiantesPromedio = sum(alumnos)/n()) %>% 
    view()

## Indicador 6: Indicador 3, 4 y 5 por sexo y nivel de educación
profesores2 %>% 
    group_by(niveldocencia, sexo) %>% 
    summarise(TotalProfesores = n(),
              EdadPromedioProfesores = mean(edad),
              EstudiantesNEE = sum(alumnosNEE)) %>% 
    view()


# PRÁCTICA 3.1 --------------------------------------------------------------

## 1. Construir la siguiente tabla.

profesores2 %>% 
    group_by(niveldocencia) %>% 
    summarise(Profesores = n(),
              Estudiantes = sum(alumnos),
              'Estudiantes Promedio' = round(Estudiantes/Profesores),
              'Edad Promedio' = round(mean(edad)))%>% 
    rename("Nivel que imparte docencia"=niveldocencia) %>% 
    view()



# DATOS ORDENADOS ---------------------------------------------------------

# cargamos el data set VentasVuelos
vuelos <- read_excel("data/VentasVuelos.xlsx", 
                     sheet = "data", skip = 1)

## PIVOT_LONGER() ------------------------------------------------

table4a

tabla4a %>%  pivot_longer(cols = c(`1999`, `2000`), 
                          names_to = "anio", 
                          values_to = "casos")

## PIVOT_WIDER() -----------------------------------------------------------

table2

tabla2 %>%  pivot_wider(names_from = tipo, 
                        values_from = cuenta)





