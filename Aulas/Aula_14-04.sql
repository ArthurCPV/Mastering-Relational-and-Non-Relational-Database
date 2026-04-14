-- Arthur Dos Santos Cabral - 566515
-- Vitor Fria Dalmagro - 566052
 
set serveroutput on
set verify off

-- Exercício 1: 

/*

Criar um bloco PL/SQL (usando cursor) para atualizar a tabela abaixo,
conforme segue:
 Produtos categoria A deverão ser reajustados em 5%
 Produtos categoria B deverão ser reajustados em 10%
 Produtos categoria C deverão ser reajustados em 15%
 
 */

CREATE TABLE PRODUTO_Cp (
    CODIGO NUMBER(4),
    CATEGORIA CHAR(1),
    VALOR NUMBER(4,2)
);

INSERT INTO PRODUTO_CpVALUES (1001,'A',7.55);
INSERT INTO PRODUTO_CpVALUES (1002,'B',5.95);
INSERT INTO PRODUTO_CpVALUES (1003,'C',3.45);
 
-- Exercício 2: 
/*
Criar um bloco que receberá um RA, um NOME e quatro notas conforme a
sequência: (RA,NOME,A1,A2,A3,A4), mínimo de dados: 2 linhas uma para
aprovado e uma para reprovado.

A partir disso criar um bloco usando cursores para processar o cálculo da média
somando o maior valor entre A1 e A2 às notas A3 e A4 e dividindo o valor
obtido por três (achando a média).

Se a média for menor que 6 (seis) o aluno estará REPROVADO e se a média
for igual ou superior a 6 (seis) o aluno estará APROVADO.

O bloco deverá inserir os valores acima numa tabela denominada ALUNO com
as seguintes colunas RA,NOME,A1,A2,A3,A4,MEDIA,RESULTADO.

*/

create table aluno_cp (
    ra number(2) primary key,
    nome varchar(20),
    A1 number(4,2),
    A2 number(4,2),
    A3 number(4,2),
    A4 number(4,2),
    media number(4,2),
    resultado varchar(15)
);

-- Exercício 3:

/*
Dadas as tabelas criar um bloco PL com cursores que transfira apenas os dados diferentes entre as tabelas A e B para a tabela C

Tabela A          Tabela B                      Tabela C
1 - Água          1 - Café
2 - Refrigerante      2 - Refrigerante
3 - Arroz           3 - Macarrão
4 - Sal             4 - Vinagre
5 - Vinagre         5 - Arroz
6 - Pão Integral      6 - Pão de Forma
7 - Danone         7 - Energético
8 - Energético      8 - Molho de Tomate
*/
