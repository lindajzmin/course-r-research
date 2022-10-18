

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

## gráfico de barras
diamantes %>% ggplot(aes(x = corte)) +
    geom_bar()

## el mismo gráfico con stat_count()
diamantes %>% ggplot(aes(x = corte)) +
    stat_count()

## Muestra un gráfico de barras de proporciones, 
## en lugar de un recuento
## especificar en el eje y = stat(prop) y group=1
diamantes %>% ggplot(aes(x = corte, 
                         y=stat(prop), 
                         group=1)) +
    stat_count()

## Usar `stat_summary()` para resumir los valores
## de $y$ para cada valor único de $x$,
diamantes %>% ggplot(aes(x = corte, 
                         y=profundidad)) +
    stat_summary(fun.min = min,
                 fun.max = max,
                 fun = median)


# COORDENADAS Y ESCALAS ---------------------------------------------------

## COORDENADAS -------------------------------------------------------------

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

