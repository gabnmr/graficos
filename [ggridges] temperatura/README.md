

## PACOTES

**Carregar os pacotes**

    library(tidyverse)
    library(ggridges)
    library(lubridate)
    library(hrbrthemes)

## DADOS

**Carregar os dados**

    dados <- read.table("temp.txt", header = TRUE, sep = ";", dec = ".")

 - *"header =" -> se o arquivo tiver cabeçalhos, TRUE*
 - *"sep =" -> separador de "colunas"*
 - *"dec = " -> separador de decimal nos dados*

--------
**Arrumar os dados**

    dados_2 <- dados %>% 

Selecionar colunas de data e temperatura:

    select(Data, Temp.Comp.Media) %>%

Renomear as colunas:

    rename(day = Data, temperature = Temp.Comp.Media) %>% 

*A coluna que chamava "Data" passa a se chamar "day".*

Formatar como data:

    mutate(day = as.Date(day, "%d/%m/%Y")) %>%

Pegar somente o mês da data e colocar na variável *month*:

    mutate(month = month(day)) %>% 

Criar a variável com o nome do mês (*month_name*):

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

  
  Colocar a variável *month_name* como tipo *factor* (categorias):

    mutate(month_name = factor(month_name))

Ver o resultado:

    head(dados_2)


## GRÁFICO

**Colocar os dados no gráfico**

Chamar o pacote e os dados:

    ggplot(dados_2, aes(temperature, reorder(month_name,desc(month)), fill = stat(x))) +

 - *"dados_2" -> fonte dos dados;*
  - *"aes" -> descrever/puxar as variáveis e como elas serão mapeadas;*
   - *"temperature" -> variável do eixo x;*
   - *"reorder(month_name,desc(month))" -> variável month_name no eixo y, reordenada em ordem decrescente da variável month;*
   - *"fill = " -> colore a área abaixo da linha do gráfico;*
   - *"stat(x)" -> usada para cálculos estéticos. Fica armazenada para depois.*

--


Chamar o tipo de gráfico e suas características:

      geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +

 - *"geom_density_ridges_gradient" -> tipo de gráfico;*
 - *"scale = "* -> altura máxima dos gráficos;*
 - *"rel_min_height = 0.01" -> altura mínima do gráfico. Dados menores que 0.01 não são mostrados.*

--


Definir o tipo de eixo:

Eixo x:

    scale_x_continuous(expand = c(0, 0)) +

 - *"scale_x_continuous" -> define o eixo x como de valores contínuos;*
 - *"expand = " -> adicionar ou retirar distanciamento entre o eixo y e o gráfico. Mais fácil de visualizar colocando *rel_min_height = 0* na seção anterior;*

Eixo y:

    scale_y_discrete(expand = expansion(mult = c(0.01, 0.25))) +

 - *"scale_y_discrete" -> define o eixo y como de valores discretos;"*
 - *"expand = expansion(mult = c(0.01, 0.25))" -> aumenta o distanciamento entre o eixo x e o gráfico. O distanciamento abaixo do gráfico é feito em valores múltiplos de 0.01, e o acima em múltiplos de 0.25.*

--------
**Melhorar a estética**
Colocar escala ao lado direito dos dados:

      scale_fill_viridis_c(name = "Temp. [ºC]", option = "C") +

 - *" scale_fill_viridis_c" -> função para chamar a legenda com mapa de cores;*
 - *"name =" -> nome que aparece no topo do escala;*
 - *"option = "C" -> uma das 5 opções de escala de cor.*

--
Colocar título, subtítulo e texto de rodapé:

      labs(title = 'Temperaturas em Belo Horizonte',
        subtitle = 'Distribuição das temperaturas médias por mês em 2019',
        caption = "Fonte: INMET. 
        Feito por @gabrielnmr, inspirado em @awhstin.") +

Definir títulos dos eixos:

      xlab("Temperatura") +
      ylab(NULL) +

 - *"ylab(NULL)" -> eixo y sem título*

--


Definir propriedades globais do tema:

      theme_ridges(font_size = 13, grid = TRUE) +

 - *"theme_ridges" -> utiliza um tema já pronto;*
 - *"font_size = 13, grid = TRUE" -> define o tamanho da fonte e adiciona linhas de grade.*


Definir propriedades locais do tema:

    theme(axis.title.x = element_text(hjust = 0.5),

 - *"axis.title.x =" -> seleciona o título do eixo x;*
 - *"element_text(hjust = 0.5)" -> ajusta para ficar no meio do gráfico.*
````
    plot.caption.position = "plot",
````
 - *"plot.caption.position = " -> seleciona a posição do texto de rodapé.*
````
    plot.caption = element_text(size = 8))
````
 - *"plot.caption =" -> seleciona a nota de rodapé;*
 - *"element_text(size = 8)" -> coloca o tamanho do texto como 8.*
