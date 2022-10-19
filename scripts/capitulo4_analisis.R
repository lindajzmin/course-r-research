

# PAQUETES A UTILIZAR -----------------------------------------------------


## INSTALACIÓN -------------------------------------------------------------
## Instalación de paquetes a utilizar en el Capítulo 2



## CARGA DE PAQUETES -------------------------------------------------------
## Cargando paquetes a utilizar en el Capítulo 2

library(tidyverse)
library(magrittr)
library(datos)
library(datasets)



# CREACIÓN DE GRÁFICOS -------------------------------------------------

## DATA ------------------------------------------------------------
## Elegimos la Data
profesores2 %>% ggplot()

## Algunos conjuntos de datos de los paquetes 'datos'
## y 'datasets'
library(help = "datos")
view(diamantes)
view(paises)
view(presidencial)
view(millas)

library(help = "datasets")
view(economics)


## ESTÉTICA ----------------------------------------------------------------
## Especificamos las variables con aes()
profesores2 %>% ggplot(aes(edad))


## GEOMETRÍAS --------------------------------------------------------------
## Definimos el tipo de gráfico con geom_
## En este caso tenemos un gráfico de barras
profesores2 %>% ggplot(aes(edad)) +
    geom_bar()


## FACETAS -----------------------------------------------------------------
## facet_grid()

## facet_grid(. ~ var1) ordena por columnas
profesores2 %>% ggplot(aes(edad)) +
    geom_bar() +
    facet_grid(.~niveldocencia)

## facet_grid(var1 ~ .) ordena por filas
profesores2 %>% ggplot(aes(edad)) +
    geom_bar() +
    facet_grid(niveldocencia~.)

## facet_grid(var1 ~ var2) compara dos variable categóricas
## v1 por filas, v2 por columnas
profesores2 %>% ggplot(aes(edad)) +
    geom_bar() +
    facet_grid(niveldocencia~tiempo)

## facet_wrap()
profesores2 %>% ggplot(aes(edad)) +
    geom_bar() +
    facet_wrap(~niveldocencia)


# PRÁCTICA 4.1 --------------------------------------------------------------

## 1. Observe el dataset `millas`.
view(millas)
str(millas)

## Replique el siguiente gráfico

millas %>% ggplot(aes(x=cilindrada, y=autopista)) +
    geom_smooth()

millas %>% ggplot(aes(x=cilindrada, y=autopista)) +
    geom_point() +
    facet_wrap(~fabricante, nrow = 3)


## MÁS ESTÉTICAS -------------------------------------------------------

## más de 1 geometría, 1 gráfico de puntos y un gráfico
## de líneas suavizadas
millas %>% ggplot(aes(x = cilindrada, y = autopista)) +
    geom_point() +
    geom_smooth()

## introducir más variables en el gráfico de puntos
millas %>% ggplot(aes(x = cilindrada, 
                      y = autopista)) +
    geom_point(aes(color = clase,
                   shape = traccion)) +
    geom_smooth()

## Transformar la data de una de las geometrías
millas %>% ggplot(aes(x = cilindrada, 
                      y = autopista)) +
    geom_point(aes(color = clase,
                   shape = traccion)) +
    geom_smooth(data = filter(millas, 
                              fabricante == "toyota"))


# PRÁCTICA 4.2 ------------------------------------------------------------

## Recrea el código R necesario para generar el 
## siguiente gráfico

millas %>% ggplot(aes(x = cilindrada, 
                      y = autopista)) +
    geom_point(aes(color = traccion)) +
    geom_smooth(aes(linetype = traccion),
                se = FALSE)


## TRANSFORMACIONES ESTADÍSTICAS -------------------------------------------

view(diamantes)

## diferencias entre datos que pertenecen a la data y 
## datos transformados

## hacemos una selección de los datos para no trabajar con
## las 53940 observaciones 
buenosD <- diamantes %>% 
    filter(corte=="Bueno" & color=="D")

## graficamos geom_point, geom_line() y geom_smooth
## geom_smooth a diferencia de los otros transforma los datos
buenosD %>% ggplot(aes(x=quilate, y=precio)) +
    geom_point() +
    geom_line() +
    geom_smooth()

## --Cada geom_ tiene un stat por default--
## Si incluimos 'stat' en el geom_ podemos transformar nuestros datos
## observamos el gráfico de puntos
buenosD %>% ggplot(aes(x=quilate, y=precio)) +
    geom_point()

## agregamos un stat de identity y no pasa nada porque 
## geom_point es una gráfica que muestra los datos tal cual
## y el identity trabaja con el geom_point
buenosD %>% ggplot(aes(x=quilate, y=precio)) +
    geom_point(stat = "identity")

## agregando un stat de smooth a geom_point
buenosD %>% ggplot(aes(x=quilate, y=precio)) +
    geom_point(stat = "smooth")

## agregando un stat de identity a geom_smooth no realiza transformación de datos
buenosD %>% ggplot(aes(x=quilate, y=precio)) +
    geom_smooth(stat = "identity")

## --Cada stat tiene un geom_ por default--
## gráfico de barras
buenosD %>% ggplot(aes(x = claridad)) +
    geom_bar()

## el mismo gráfico con stat_count()
buenosD %>% ggplot(aes(x = claridad)) +
    stat_count()

## Muestra un gráfico de barras de proporciones, 
## en lugar de un recuento
## especificar en el eje y = stat(prop) y group=1
buenosD %>% ggplot(aes(x = claridad, 
                         y=stat(prop), 
                         group=1)) +
    stat_count()

## Usar `stat_summary()` para resumir los valores
## de $y$ para cada valor único de $x$,
buenosD %>% ggplot(aes(x = claridad,
                         y = precio)) +
    geom_point(alpha=0.3,  
               color="turquoise4") +
    stat_summary(fun.min = min, 
                 fun.max = max,
                 fun=median, 
                 size=0.8, 
                 color="salmon")

colors()

## Histograma
# para crear un histograma de frecuencias absolutas
buenosD %>% ggplot(aes(x=precio)) +
    geom_histogram()

buenosD %>% ggplot(aes(x=precio)) +
    geom_histogram(aes(y=stat(count/max(count))))

# para modificar los rangos con bin número de rangos
buenosD %>% ggplot(aes(x=precio)) +
    geom_histogram(aes(y=stat(count)),
                   bins = 10)

# para modificar los rangos con binwidth ancho de rangos
buenosD %>% ggplot(aes(x=precio)) +
    geom_histogram(aes(y=stat(count)),
                   binwidth = 3000)

# dar color al histograma con fill y color
buenosD %>% ggplot(aes(x=precio)) +
    geom_histogram(aes(y=stat(count)),
                   binwidth = 3000,
                   color="ivory",
                   fill="thistle3")

max(buenosD$precio)
min(buenosD$precio)

## puedo invertir los ejes
buenosD %>% ggplot(aes(y=precio)) +
    geom_histogram(aes(x=stat(count)),
                   binwidth = 3000,
                   color="ivory",
                   fill="thistle3")

# puedo agregar un polígono de frecuencia
buenosD %>% ggplot(aes(x=precio)) +
    geom_histogram(aes(y=stat(count)),
                   binwidth = 3000,
                   color="ivory",
                   fill="thistle3") +
    geom_freqpoly(aes(y=stat(count)),
                  binwidth = 3000,
                  color="purple",
                  size =1)

# puedo agregar los valores de las frecuencias
buenosD %>% ggplot(aes(x=precio)) +
    geom_histogram(aes(y=stat(count)),
                   binwidth = 3000,
                   color="ivory",
                   fill="thistle3") +
    geom_freqpoly(aes(y=stat(count)),
                  binwidth = 3000,
                  color="purple",
                  size =1) +
    geom_text(stat = "bin",
              binwidth= 3000,
              aes(label=stat(round(count,2)),
                  y=stat(count)),
              nudge_y = 5)


buenosD %>% ggplot(aes(x=precio)) +
    stat_bin()
    
    
## COORDENADAS Y ESCALAS ---------------------------------------------------

## coord_flip
diamantes %>% ggplot(aes(x = corte, 
                         y = precio)) +
    geom_boxplot()

## coord_flip
diamantes %>% ggplot(aes(x = corte, 
                         y = precio)) +
    geom_boxplot() +
    coord_flip()

## coord_polar
diamantes %>% ggplot(aes(x = corte)) +
    geom_bar() +
    coord_flip()

## coord_polar
diamantes %>% ggplot(aes(x = corte)) +
    geom_bar() +
    coord_polar()


# TEMAS -----------------------------------------------------------------

## temas predeterminados
diamantes %>% ggplot(aes(x = corte)) +
    geom_bar() +
    coord_polar() +
    theme_void()

`theme_grey()`
`theme_bw()`
`theme_light()`
`theme_dark()`
`theme_classic()`
`theme_void()`

## color al gráfico
diamantes %>% ggplot(aes(x = corte, fill=corte)) +
    geom_bar() +
    coord_polar() +
    scale_fill_brewer()


## etiquetas de títulos con labs()
diamantes %>% ggplot(aes(x = corte, fill=corte)) +
    geom_bar() +
    coord_polar() +
    scale_fill_brewer() +
    theme(legend.position = "bottom") +
    labs(title = "La cantidad de diamantes por tipo de corte",
             subtitle = "Mayor cantidad de diamantes de corte ideal",
             caption = "Datos de R.com")

library(RColorBrewer)
colors()
display.brewer.all()

diamantes %>% ggplot(aes(x = corte, fill=corte)) +
    geom_bar() +
    coord_polar() +
    scale_fill_brewer(palette = "Set2") +
    theme(legend.position = "bottom") +
    labs(title = "La cantidad de diamantes por tipo de corte",
         subtitle = "Mayor cantidad de diamantes de corte ideal",
         caption = "Datos de R.com")


## gráfico con varios atributos
diamantes %>% ggplot(aes(x = corte, 
                         fill=corte)) +
    geom_bar(alpha=0.8) +
    scale_fill_brewer(palette = "Dark2") +
    geom_text(aes(label=..count..), 
              stat = 'count',
              vjust=-0.5) +
    theme_minimal() +
    theme(legend.position = "bottom") +
    labs(x = "Corte del diamante",
         y = "Cantidad de diamantes",
         title = "La cantidad de diamantes por tipo de corte",
         subtitle = "Mayor cantidad de diamantes de corte ideal",
         caption = "Datos de R.com",
         fill = "Tipo de corte")


## para guardar el gráfico
## 1. guardar el gráfico en un objeto

grafico1 <- diamantes %>% ggplot(aes(x = corte, 
                                     fill=corte)) +
    geom_bar(alpha=0.8) +
    scale_fill_brewer(palette = "Dark2") +
    geom_text(aes(label=..count..), 
              stat = 'count',
              vjust=-0.5) +
    theme_minimal() +
    theme(legend.position = "bottom") +
    labs(x = "Corte del diamante",
         y = "Cantidad de diamantes",
         title = "La cantidad de diamantes por tipo de corte",
         subtitle = "Mayor cantidad de diamantes de corte ideal",
         caption = "Datos de R.com",
         fill = "Tipo de corte")


ggsave(filename = "img/grafico1.png",
       plot = grafico1,
       units = "cm",
       width = 21,
       height = 29.7)

