-- Arthur dos Santos Cabral RM 566515
set verify off;
set SERVEROUTPUT on;


/*
Exercício 1
 
Criar um bloco PL/SQL (usando cursor) para atualizar a tabela abaixo,
conforme segue:
 Produtos categoria A deverão ser reajustados em 5%
 Produtos categoria B deverão ser reajustados em 10%
 Produtos categoria C deverão ser reajustados em 15%
CREATE TABLE PRODUTO_Cp (
CODIGO NUMBER(4),
CATEGORIA CHAR(1),
VALOR NUMBER(4,2));
INSERT INTO PRODUTO_CpVALUES (1001,'A',7.55);
INSERT INTO PRODUTO_CpVALUES (1002,'B',5.95);
INSERT INTO PRODUTO_CpVALUES (1003,'C',3.45); 
*/

-- Tabela
CREATE TABLE PRODUTO_CP (
    CODIGO NUMBER(4) primary key,
    CATEGORIA CHAR(1),
    VALOR NUMBER(4,2)
);

INSERT INTO PRODUTO_CP VALUES (1001,'A',7.55);
INSERT INTO PRODUTO_CP VALUES (1002,'B',5.95);
INSERT INTO PRODUTO_CP VALUES (1003,'C',3.45);
COMMIT;

-- Bloco com cursor
DECLARE
    CURSOR c_produto IS 
        SELECT CODIGO, CATEGORIA FROM PRODUTO_CP;
BEGIN
    FOR v_produto IN c_produto LOOP
        
        UPDATE PRODUTO_CP
        SET VALOR = CASE 
            WHEN v_produto.CATEGORIA = 'A' THEN VALOR * 1.05
            WHEN v_produto.CATEGORIA = 'B' THEN VALOR * 1.10
            WHEN v_produto.CATEGORIA = 'C' THEN VALOR * 1.15
        END
        WHERE CODIGO = v_produto.CODIGO;

    END LOOP;
    
    COMMIT;
END;
/

SELECT * FROM PRODUTO_CP;

/*
Exercício 2
 
Criar um bloco que receberá um RA, um NOME e quatro notas conforme a
sequência: (RA,NOME,A1,A2,A3,A4), mínimo de dados: 2 linhas uma para
aprovado e uma para reprovado.

A partir criar um bloco usando cursores para processar o cálculo da média
somando o maior valor entre A1 e A2 às notas A3 e A4 e dividindo o valor
obtido por três (achando a média).

Se a média for menor que 6 (seis) o aluno estará REPROVADO e se a média
for igual ou superior a 6 (seis) o aluno estará APROVADO.

O bloco deverá inserir os valores acima numa tabela denominada ALUNO com
as seguintes colunas RA,NOME,A1,A2,A3,A4,MEDIA,RESULTADO.

create table aluno_cp (ra number(2) primary key, nome varchar(20),
A1 number(4,2), A2 number(4,2), A3 number(4,2), A4 number(4,2),
media number(4,2), resultado varchar(15));

*/
-- Tabela
CREATE TABLE ALUNO_CP (
    RA NUMBER(2) PRIMARY KEY,
    NOME VARCHAR2(20),
    A1 NUMBER(4,2),
    A2 NUMBER(4,2),
    A3 NUMBER(4,2),
    A4 NUMBER(4,2),
    MEDIA NUMBER(4,2),
    RESULTADO VARCHAR2(15)
);

-- Dados
BEGIN
    INSERT INTO ALUNO_CP VALUES (1, 'Ronaldo Bolinha', 9, 8, 6, 5, NULL, NULL);
    INSERT INTO ALUNO_CP VALUES (2, 'Fernanda Jussara', 3, 5, 2, 6, NULL, NULL);
    COMMIT;
END;
/

-- Bloco com cursor
DECLARE
    CURSOR c_aluno IS 
        SELECT * FROM ALUNO_CP;
        
    v_media NUMBER(4,2);
BEGIN
    FOR v_aluno IN c_aluno LOOP
        
        -- Calcula média
        IF v_aluno.A1 >= v_aluno.A2 THEN
            v_media := (v_aluno.A1 + v_aluno.A3 + v_aluno.A4) / 3;
        ELSE
            v_media := (v_aluno.A2 + v_aluno.A3 + v_aluno.A4) / 3;
        END IF;

        -- Atualiza tudo em um único UPDATE
        UPDATE ALUNO_CP
        SET 
            MEDIA = v_media,
            RESULTADO = CASE 
                WHEN v_media >= 6 THEN 'Aprovado'
                ELSE 'Reprovado'
            END
        WHERE RA = v_aluno.RA;

    END LOOP;

    COMMIT;
END;
/

SELECT * FROM ALUNO_CP;

/*
Exercício 3

Dadas as tabelas criar um bloco PL com cursores que transfira apenas os dados diferentes entre as tabelas A e B para a tabela C

Tabela A                Tabela B                      Tabela C
1 - Água                1 - Café
2 - Refrigerante       2 - Refrigerante
3 - Arroz               3 - Macarrão
4 - Sal                 4 - Vinagre
5 - Vinagre             5 - Arroz
6 - Pão Integral        6 - Pão de Forma
7 - Danone              7 - Energético
8 - Energético          8 - Molho de Tomate
*/

-- Tabelas
CREATE TABLE TABELA_A (
    ID NUMBER(2) PRIMARY KEY,
    NOME VARCHAR2(50)
);

CREATE TABLE TABELA_B (
    ID NUMBER(2) PRIMARY KEY,
    NOME VARCHAR2(50)
);

CREATE TABLE TABELA_C (
    ID NUMBER(2) PRIMARY KEY,
    NOME VARCHAR2(50)
);

-- Inserts
BEGIN
INSERT INTO TABELA_A VALUES (1, 'Água');
INSERT INTO TABELA_A VALUES (2, 'Refrigerante');
INSERT INTO TABELA_A VALUES (3, 'Arroz');
INSERT INTO TABELA_A VALUES (4, 'Sal');
INSERT INTO TABELA_A VALUES (5, 'Vinagre');
INSERT INTO TABELA_A VALUES (6, 'Pão Integral');
INSERT INTO TABELA_A VALUES (7, 'Danone');
INSERT INTO TABELA_A VALUES (8, 'Energético');

INSERT INTO TABELA_B VALUES (1, 'Café');
INSERT INTO TABELA_B VALUES (2, 'Refrigerante');
INSERT INTO TABELA_B VALUES (3, 'Macarrão');
INSERT INTO TABELA_B VALUES (4, 'Vinagre');
INSERT INTO TABELA_B VALUES (5, 'Arroz');
INSERT INTO TABELA_B VALUES (6, 'Pão de Forma');
INSERT INTO TABELA_B VALUES (7, 'Energético');
INSERT INTO TABELA_B VALUES (8, 'Molho de Tomate');

COMMIT;
END;
/

-- Bloco com cursor
DECLARE
    CURSOR c_a IS SELECT NOME FROM TABELA_A;
    CURSOR c_b IS SELECT NOME FROM TABELA_B;

    v_existe NUMBER;
    v_id NUMBER := 1;
BEGIN
    -- Itens de A que não estão em B
    FOR reg_a IN c_a LOOP
        
        SELECT COUNT(*) INTO v_existe
        FROM TABELA_B
        WHERE NOME = reg_a.NOME;

        IF v_existe = 0 THEN
            INSERT INTO TABELA_C VALUES (v_id, reg_a.NOME);
            v_id := v_id + 1;
        END IF;

    END LOOP;

    -- Itens de B que não estão em A
    FOR reg_b IN c_b LOOP
        
        SELECT COUNT(*) INTO v_existe
        FROM TABELA_A
        WHERE NOME = reg_b.NOME;

        IF v_existe = 0 THEN
            INSERT INTO TABELA_C VALUES (v_id, reg_b.NOME);
            v_id := v_id + 1;
        END IF;

    END LOOP;

    COMMIT;
END;
/

SELECT * FROM TABELA_C;