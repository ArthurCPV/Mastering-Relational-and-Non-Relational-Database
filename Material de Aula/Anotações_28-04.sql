-- =====================================================
-- EXCEPTIONS (PL/SQL - Oracle)
-- =====================================================

-- Conceito:
-- Exceptions são usadas para tratar erros em tempo de execução,
-- geralmente ligados a regras de negócio ou falhas em consultas.

-- Principais exceptions:
-- NO_DATA_FOUND     -> nenhum dado encontrado
-- TOO_MANY_ROWS     -> mais de uma linha retornada
-- DUP_VAL_ON_INDEX  -> valor duplicado em coluna única

-- Estrutura básica:
-- DECLARE
--    ...
-- BEGIN
--    ...
-- EXCEPTION
--    WHEN NOME_DA_EXCECAO THEN
--       comandos;
--    WHEN OTHERS THEN
--       comandos;
-- END;


-- =====================================================
-- EXEMPLO PRÁTICO
-- =====================================================

-- Limpa a tabela
DROP TABLE aluno CASCADE CONSTRAINTS;

-- Cria a tabela
CREATE TABLE aluno (
   ra   NUMBER(1),
   nome VARCHAR2(20)
);

-- Insere dados
INSERT INTO aluno VALUES (1,'Marcel');
INSERT INTO aluno VALUES (2,'Adriana');
INSERT INTO aluno VALUES (3,'Samuel');

COMMIT;

SET SERVEROUTPUT ON;


-- =====================================================
-- USO DE EXCEPTIONS
-- =====================================================

DECLARE
   V_RA   ALUNO.RA%TYPE := &ra;
   V_NOME ALUNO.NOME%TYPE;

BEGIN
   SELECT NOME
   INTO V_NOME
   FROM ALUNO
   WHERE RA >= V_RA;

   DBMS_OUTPUT.PUT_LINE(V_RA || ' - ' || V_NOME);

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Não há nenhum aluno com este RA');

   WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE('Há mais de um aluno');

   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Chame o técnico');
END;
/


-- =====================================================
-- EXCEPTION PERSONALIZADA (MODELO)
-- =====================================================

DECLARE
   NOME_DA_EXCECAO EXCEPTION;

BEGIN
   -- lógica

   IF ... THEN
      RAISE NOME_DA_EXCECAO;
   END IF;

EXCEPTION
   WHEN NOME_DA_EXCECAO THEN
      NULL; -- tratamento aqui
END;
/


-- =====================================================
-- EXEMPLO: TURMA CHEIA
-- =====================================================

DECLARE
   V_CONTA NUMBER(2);
   TURMA_CHEIA EXCEPTION;

BEGIN
   SELECT COUNT(RA)
   INTO V_CONTA
   FROM ALUNO;

   IF V_CONTA = 5 THEN
      RAISE TURMA_CHEIA;
   ELSE
      INSERT INTO ALUNO VALUES (&ra, '&nome');
   END IF;

EXCEPTION
   WHEN TURMA_CHEIA THEN
      DBMS_OUTPUT.PUT_LINE('Não foi possível incluir: turma cheia');
END;
/


-- =====================================================
-- CONSULTA FINAL
-- =====================================================

SELECT * FROM aluno;