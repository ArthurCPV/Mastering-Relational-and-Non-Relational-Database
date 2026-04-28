/* 
Criar um bloco PL/SQL (usando cursor) para atualizar a tabela abaixo, conforme segue, não esqueça de
implementar as exceptions possiveis para tratamento de erros:
 
Produtos categoria A deverão ser reajustados em 5%
Produtos categoria B deverão ser reajustados em 10%
Produtos categoria C deverão ser reajustados em 15%
*/

drop table produto_cp cascade constraints;
 
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

