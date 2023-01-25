# PROJETO_MELHORES_COMPRAS

Esse repositório apresenta o Projeto desenvolvido no curso de Banco de Dados (1º ano)

Esse projeto está dividido em etapas:

*1ª Etapa:* Construir um banco de dados lógico e fisico (relacional) atendendo às regras de negócio

*2ª Etapa:* Popular o banco de dados, manipular os dados com instruções DML e exibir dados utilizando o comando SELECT

*3ª Etapa:* Ampliar a consistência do negócio, aprimorar a segurança e o desempenho dos dados - Projeto Gerenciamento De Vídeos Da Melhores Compras Ltda (SGV) - Criando procedimentos armazenados em banco de dados relacionais.

Nessa etapa foram desenvolvidas as seguintes atividades:

*  Script DML  que popula dados iniciais na nova versão do projeto SGV

*  Código fonte do procedimento de carga de dados para a tabela T_MC_OCORRENCIA_SAC a partir das regras de negócio

*  Evidência de execução do procedimento anterior, exibindo os dados cadastrados na tabela (*.docx), com conteúdos significativos

*  Código-fonte do procedimento de validação de CPF

*  Código-fonte da trigger for each row sobre a tabela T_MC_CLI_FISICA.

*4ª Etapa:* Potencializando o desempenho com NoSQL 

Nessa etapa foram desenvolvidas as seguintes atividades

Analisar os três cenários abaixo descritos:

1º cenário: Quando um cliente seleciona um produto, a plataforma de e-commerce exibe adicionalmente recomendações de outras compras de quem comprou esse produto e outras promoções correlatas. No contexto atual, esse cálculo está demorando muito tempo para ser feito utilizando estruturas relacionais, dado o volume de dados envolvidos.

2º cenário: A definição da entrega de um produto em 24h depende da disponibilidade de estoque do centro de distribuição mais próximo do endereço de entrega, e se o cliente optar por essa entrega fast é necessário realizar a reserva no centro de distribuição e, automaticamente, atualizar o estoque para atender a outros clientes. Nos testes preliminares com o uso do modelo relacional, o desempenho foi frustrante, influenciado principalmente pelo volume de dados e frequência de atualização.

3º cenário: A tela de detalhes de um produto sempre recebe novas informações e, hoje em dia, possui informações que podem ser armazenadas juntamente com o produto, tais como: reviews do produto; suas versões; informações de entrega; imagens; recomendações; dicas, entre outras.

Existem situações em que temos poucos dados para um produto e outras situações com centenas de informações para outro produto. Essas estruturas variáveis compostas por diversas cardinalidades tornam o gerenciamento complexo em estruturas relacionais.  Sabe-se que existem formas de armazenamento que trabalham com estruturas de dados variáveis e isso pode ser um ponto de partida para atender a essa necessidade.

Responder às três perguntas a seguir:

*  Escolha um cenário dentre os três e defina qual seria o nome do melhor banco de dados NoSQL para atender às necessidades de negócio. Justifique sua escolha citando um exemplo prático.

*  Instale esse Banco de Dados NoSQL (cloud, on premise, VM), realize o setup inicial e crie uma prática implementando uma nova estrutura de dados inicial pertinente ao cenário escolhido e apresente como é possível manipular e exibir dados nesse ambiente de trabalho.


* 5ª Etapa: Hands On Big Data

 Nessa etapa foram desenvolvidas as seguintes atividades: 
 
*  Dentro da VM Big Data, criar o diretório MelhoresCompras dentro do HDFS.

*  Transferir os arquivos vendas_melhores_compras.xlsx, clientes.xml e Impressora_3D_Metal.mp4 para o diretório criado no item a (*não se esqueça de apresentar os comandos de transferência dos arquivos e a evidência de que os arquivos foram transferidos com sucesso).

*  Utilizando o sqoop, transferir os dados da view pf0110.v_faturamento_ano_mes para o HDFS.
