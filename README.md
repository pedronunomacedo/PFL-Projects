# PFL-Project
Projects done during the class Functional programming and Logical (PFL), in the 3rd Year and 1st Semester in MIEIC, FEUP.

## Autores

- Gonçalo Jorge Soares Ferreira - up202004761
- Pedro Nuno Ferreira Moura de Macedo - up202007531

## Escolha de representação interna de polinómios

Para representar os polinómios nós optamos por criar dois novos data types, 'Term' e 'Expo'. O 'Expo' contém as variavéis e respetivos expoentes, (exemplo: 'x^2' ficaria "Expo {var = 'x', exponant = 2}"), enquanto que o 'Term' contém o coeficiente e uma lista de 'Expo', (exemplo: '3* x^2' ficaria "Term {number = 3.0, expos = [Expo {var = 'x', exponant = 2}]}"). Desta forma os polinómios ficam melhor organizados e torna-se mais fácil a sua manipulação.

## Estratégia de implementação de cada funcionalidade

É importante referir que qualquer polinómio (string) inserido pelo utilizador é transformado no formato do novo data type 'Term', é modificado, e por fim é transformado de novo em string para o output.

#### Normalizar Polinómios

Para isto, inicialmente dividimos a string inserida em várias strings de monómios, separando a string inicial por '+' e '-'. Após isso, passamos cada um desses monómios para 'Term' e organizamo-los por expoente e variável para ser mais fácil comparar, removemos as váriaveis de expoente zero e os polinómios com coeficiente zero. Damos sort do polinómio por variável para facilitar a soma. Depois fazemos a soma final, ou seja, somamos os coeficientes dos polinómios com as mesmas variáveis e expoentes. Finalmente, realizamos um sort final para ordenar o polinómio resultante por variável e expoente.

#### Adicionar Polinómios

Adicionar polinómios foi bastante simples. Apenas concatenamos os dois polinómios escritos pelo utilizador na mesma string, e aplicamos a função de normalizar polinómios realizada na opção anterior.

#### Multiplicar Polinómios

Para multiplicar polinómios nós primeiramente normalizamos ambos usando a função de normalizar polinómios realizada anteriormente. Após isso aplicamos a propriedade distributiva da multiplicação entre eles.

#### Derivada de um Polinómio

Quanto à derivação de um polinómio, como sempre, normalizamos o polinómio antes. Para derivar o utilizador tem de escolher a variável a derivar e após isso são aplicadas as regras da derivação, ou seja, multiplicar o coeficiente pelo expoente e subtrair 1 ao expoente.

## Exemplos de utilização

Inicialmente chamamos a função 'main' de modo a iniciar o programa.

<img src="https://user-images.githubusercontent.com/84196064/197405714-a74b6b48-31eb-40f5-b657-7cfc30f33582.png" width="400">

Após isso podemos escolher a opção que pretendemos.

#### Opção 1

<img src="https://user-images.githubusercontent.com/84196064/197405856-2be5c2f7-30f2-4659-afb2-403b5da7ef48.png" width="400">

#### Opção 2

<img src="https://user-images.githubusercontent.com/84196064/197405861-872fe5e3-961a-4cd3-bc0f-5059e9a03195.png" width="400">

#### Opção 3

<img src="https://user-images.githubusercontent.com/84196064/197405867-d1457467-6fbd-438d-9cd4-458b6921c394.png" width="400">

#### Opção 4

<img src="https://user-images.githubusercontent.com/84196064/197405870-e1be85e7-2a9a-4b36-a3c7-a411e56c0bda.png" width="400">
