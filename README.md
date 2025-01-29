# Estudo de Convergência com PSO para a Função Shubert

## Autores
- THADEU CARNEIRO DA SILVA 
- VINICIUS DE LIRA TEIXEIRA

## Introdução
A otimização numérica é a tarefa de determinar valores ótimos dentro de um universo de possibilidades, onde cada possibilidade é avaliada por uma função de avaliação, que pode ser linear ou não linear. Este projeto utiliza o algoritmo de Otimização por Enxame de Partículas (PSO) para estudar a convergência na função Shubert.

## Descrição do Problema
O objetivo é apresentar um estudo de convergência utilizando o PSO para a função Shubert, considerando quatro propostas de peso de inércia:
- Peso de Inércia Constante
- Peso de Inércia Randômico
- Peso de Inércia com Decrescimento Linear
- Peso de Inércia com Função Sigmoide

### Considerações
- Utilizar os mesmos parâmetros do PSO apresentados no exemplo.
- Destacar a melhor estratégia de peso de inércia para cada caso.
- Executar 30 vezes para cada caso e apresentar os resultados utilizando gráficos boxplot.

## Solução do Problema

### Dados de Entrada
- Número máximo de iterações: 200
- Número de partículas: 50
- Número de dimensões do problema: 2
- Intervalos adotados de x: [200, 200] e [-200, -200]

### Análises
#### Peso de Inércia Constante
Para estas análises, utilizou-se o Peso de Inércia Constante, ou seja, W = 0,7. Os resultados são apresentados na Figura 1.

Figure_1.png

#### Peso de Inércia Randômico
O Peso de Inércia Randômico é definido pela equação $\( W = 0.5 + \frac{rand}{2} \)$, onde "rand" representa um número aleatório gerado pelo Octave/Matlab. Os resultados são apresentados na Figura 2.

#### Peso de Inércia com Decrescimento Linear
O Peso de Inércia com Decrescimento Linear é descrito pela expressão $\( W = W_{max} - \left( \frac{W_{max} - W_{min}}{I_{max}} \right) \cdot t \)$, onde $\( W_{max} = 0.9 \)$ e $\( W_{min} = 0.4 \)$. Os resultados são apresentados na Figura 3.

#### Peso de Inércia com Função Sigmoide
O Peso de Inércia com Função Sigmoide é definido pela expressão $\( W = \frac{W_{max} - W_{min}}{1 + \exp(u \cdot (t - I_{max}))} + W_{max} \)$, onde $\( u = 10^{(\log(I_{max}) - 2)} \)$. Os resultados são apresentados na Figura 4.

### Análises Comparativas
Na Figura 5, pode-se visualizar a Função de Shubert e os respectivos pontos de mínimos determinados por cada iteração. As variantes do Peso de Inércia foram executadas sucessivamente por 30 vezes, conforme pode ser observado na Tabela 1.

### Resultados
Os resultados das 30 execuções para cada tipo de peso de inércia são apresentados no gráfico boxplot da Figura 6. Observa-se que o Peso de Inércia com Decrescimento Linear apresentou o melhor resultado, com valores de mínimo, primeiro quartil, mediana, terceiro quartil e valor máximo extremamente próximos.
