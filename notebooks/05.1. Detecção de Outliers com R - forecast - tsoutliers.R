# Carrega bibliotecas
library(ggplot2)
library(forecast)
library(readr)

# Lê o dataset arrecadacao_Brasil.csv
arrecadacao_brasil <- read_csv("tcc-puc-mg/datasets/arrecadacao_Brasil.csv")

# Converte em série temporal no R
ts_arrecadacao <- ts((arrecadacao_brasil$arrecadacao), start=c(2004, 1), end=c(2019, 12), frequency=12)

ts_arrecadacao

#Plot
autoplot(ts_arrecadacao)

# Decomposição
autoplot(decompose(ts_arrecadacao))

# Identificação de Outliers
outliers = tsoutliers(ts_arrecadacao)

# Índices e valores substitutos
outliers$index
outliers$replacements

# Cria cópia do ts_arrecadacao e aplica a substituição dos outliers identificados
ts_arrecadacao2 = ts_arrecadacao
ts_arrecadacao2[outliers$index] <- outliers$replacements

plot(ts_arrecadacao)
lines(ts_arrecadacao2, col = "red")

#Nota-se que identificou várias vezes o mês de janeiro

# Teste usando uma transformação Box Cox durante a identificação de outliers
outliers = tsoutliers(ts_arrecadacao, lambda = "auto")

# Índices e valores substitutos
outliers$index
outliers$replacements

# Cria cópia do ts_arrecadacao e aplica a substituição dos outliers identificados
ts_arrecadacao2 = ts_arrecadacao
ts_arrecadacao2[outliers$index] <- outliers$replacements

plot(ts_arrecadacao)
lines(ts_arrecadacao2, col = "red")

# O resultado se apresenta bem mais interessante, corrigindo dois relevantes outliers em 2013-11 [119] e 2016-10 [154].
