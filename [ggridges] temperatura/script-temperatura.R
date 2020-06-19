#carregar pacotes
library(tidyverse)
library(ggridges)
library(lubridate)
library(hrbrthemes)

#DADOS----
#carregar dados
dados <- read.table("temp.txt",
                    header = TRUE, sep = ";", dec = ".")

#selecionar colunas de data e temperatura, renomear e formatar data
#pegar o mes, criar variavel de nome do mes, transforma-la em categoria

dados_2 <- dados %>% 
  select(Data,Temp.Comp.Media) %>%
  rename(day = Data, temperature = Temp.Comp.Media) %>% 
  mutate(day = as.Date(day,"%d/%m/%Y")) %>%
  mutate(month = month(day)) %>% 
  mutate(month_name = case_when(
    .$month == 1 ~ "Janeiro",
    .$month == 2 ~"Fevereiro",
    .$month == 3 ~ "Março",
    .$month == 4 ~"Abril",
    .$month == 5 ~ "Maio",
    .$month == 6 ~"Junho",
    .$month == 7 ~ "Julho",
    .$month == 8 ~"Agosto",
    .$month == 9 ~ "Setembro",
    .$month == 10 ~"Outubro",
    .$month == 11 ~ "Novembro",
    .$month == 12 ~"Dezembro")) %>% 
  mutate(month_name = factor(month_name))

head(dados_2)


#GRÁFICO----

ggplot(dados_2, aes(temperature, reorder(month_name,desc(month)), fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = expansion(mult = c(0.01, 0.25))) +
  scale_fill_viridis_c(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperaturas em Belo Horizonte',
    subtitle = 'Distribuição das temperaturas médias por mês em 2019',
    caption = "Fonte: INMET. 
    Feito por @gabnmr, inspirado em @awhstin.") +
  xlab("Temperatura") +
  ylab(NULL) +
  theme_ridges(font_size = 13, grid = TRUE) +
  theme(axis.title.x = element_text(hjust = 0.5), plot.caption.position = "plot", 
        plot.caption = element_text(size = 10))
        
