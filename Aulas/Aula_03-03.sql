-- Necessários para rodar qualquer código
set serveroutput on;
set verify off;

// Exemplo 1:

declare
    valor_carro number(6.2) := &value;
    valor_carro_juros number(6.2) := valor_carro + (valor_carro*0.03);
    valor_juros number(6.2) := valor_carro_juros - valor_carro;
    valor_carro_parcela number(6.2) := valor_carro_juros/10;
begin
    dbms_output.put_line('Valor do carro R$:'|| valor_carro ||'.00'); 
    dbms_output.put_line('Valor do carro com juros R$:'|| valor_carro_juros||'.00'); 
    dbms_output.put_line('Valor do juros bruto R$:'|| valor_juros||'.00'); 
    dbms_output.put_line('Valor de cada parcela R$:'|| valor_carro_parcela||'.00'); 
end;

// DIA 03/03:

-- EXERCICIO 01 - Criar um bloco PL-SQL para descobrir o sexo do usuário

-- Versão case sensitive:
declare
    sexo char(1) := '&sexo';
    begin
    if sexo = 'M' or sexo = 'm' then
        dbms_output.put_line('Seu sexo é macho!'); 
    elsif sexo = 'F' or sexo = 'f' then
        dbms_output.put_line('Seu sexo é fêmea!');
    else
        dbms_output.put_line('Sei seu sexo não vei');
    end if;
end;

-- Versão sem case sensitive:
declare
    sexo char(1) := '&sexo';
    begin
    if sexo = 'M' or sexo = 'm' then
        dbms_output.put_line('Seu sexo é macho!'); 
    elsif sexo = 'F' or sexo = 'f' then
        dbms_output.put_line('Seu sexo é fêmea!');
    else
        dbms_output.put_line('Sei seu sexo não vei');
    end if;
end;


-- EXERCICIO 04: Criar um blocoPL-SQL para calcular o valor de cada parcela de uma compra de um carro, nas seguints condições:
    -- Parcelas para aquisição em 6 pagamentos.
    -- Parcelas para aquisição em 12 pagamentos.
    -- Parcelas para aquisição em 18 pagamentos.
-- OBSERVAÇÃO:
-- 1 - Deverá ser dada uma entrada de 20% do valor da compra.
-- 2 - Deverá ser aplicada uma taxa de juros, no saldo restante, nas seguintes condições:
-- 3 - No final informar o valor das parcelas para as 3 formas de pagamento, com o Valor de aquisição de 10.000 e o mesmo com entrada de dados via teclado( em tempo de execução)
-- A - Pagamento em 6 parcelas: 10%.
-- B - Pagamento em 12 parcelas: 15%.
-- C - Pagamento em 18 parcelas: 20%.

-- R:

declare
    valor_carro number(6.2) := 10000;
    valor_entrada number(6.2) := valor_carro*0.2;
    valor_juros_em_6_parcelas number(6.2) := (((valor_carro - valor_entrada) * 0.1) +(valor_carro - valor_entrada))/6;
    valor_juros_em_12_parcelas number(6.2) := ((valor_carro - valor_entrada) * 0.15 +(valor_carro - valor_entrada))/12;
    valor_juros_em_18_parcelas number(6.2) := ((valor_carro - valor_entrada) * 0.20 +(valor_carro - valor_entrada))/18;
begin
    dbms_output.put_line('Valor do carro R$:'|| valor_carro ||'.00');
    dbms_output.put_line('Valor da entrada R$:'|| valor_entrada ||'.00');
    dbms_output.put_line('Valor parcelado em 6 vezes com juros de 10%. R$:'|| valor_juros_em_6_parcelas ||'.00');
    dbms_output.put_line('Valor parcelado em 12 vezes com juros de 15%. R$:'|| valor_juros_em_12_parcelas ||'.00');
    dbms_output.put_line('Valor parcelado em 18 vezes com juros de 18%. R$:'|| valor_juros_em_18_parcelas ||'.00');
end;
    

/* Decisão - If - Lista de exercícios */

-- Crie um bloco anônimo PL/SQL que verifique se um número fornecido é positivo, negativo ou zero.
-- Exiba uma mensagem apropriada usando a estrutura IF.

//Exemplo de Saída:
    -- "Número positivo"
    -- "Número negativo"
    -- "Número é zero"

-- R:

declare
    numero number(10) := &numero;
begin
    if numero > 0 then
    dbms_output.put_line('Seu número é positivo!');
    elsif numero < 0 then
    dbms_output.put_line('Seu número é negativo!');
    else
    dbms_output.put_line('Seu número é zero! Bobão. >:c');
    end if;
end;
 
/*
Crie um bloco PL/SQL que avalie a idade de uma pessoa e determine se ela é criança, adolescente, adulto ou idoso.
Considere as faixas etárias:

-Criança: 0 a 12 anos
-Adolescente: 13 a 17 anos
-Adulto: 18 a 64 anos
-Idoso: 65 anos ou mais
*/

-- R:

declare
    idade number(10) := &idade;
begin
    if idade >= 0 and idade <= 12 then
    dbms_output.put_line('Você é pirralho');
    elsif idade >= 13 and idade <= 17  then
    dbms_output.put_line('Você é aborrecente');
    elsif idade >= 18 and idade <= 64  then
    dbms_output.put_line('Você é adulto');
    elsif idade >= 65 then
    dbms_output.put_line('Você é véi');
    else
    dbms_output.put_line('Insira uma idade válida!');
    end if;
end;
 
-- Crie um bloco PL/SQL que verifique se um ano informado é bissexto. 

// Um ano é bissexto se for divisível por 4, mas não divisível por 100,  a menos que também seja divisível por 400.

-- R:

declare
    ano number(10) := &ano;
begin
    if MOD(ano,4) = 0 and MOD(ano,100) != 0 or MOD(ano,400) = 0 then
    dbms_output.put_line('Seu ano é bissexto!');
    else
    dbms_output.put_line('Seu ano não é bissexto!');
    end if;
end;
 
-- Crie um bloco PL/SQL que receba dois números e compare:

// Se o primeiro número for maior que o segundo, exiba "Maior".
// Se o primeiro número for menor que o segundo, exiba "Menor".
// Se forem iguais, exiba "Igual".

-- R:

declare
    numeroMaior number(10,2) := &numero1;
    numeroMenor number(10,2) := &numero2;
begin
    if numeroMaior > numeroMenor then
    dbms_output.put_line('Maior');
    elsif numeroMenor > numeroMaior then
    dbms_output.put_line('Menor');
    elsif numeroMaior = numeroMenor then
    dbms_output.put_line('Iguais');
    else
    dbms_output.put_line('Sei lá');
    end if;
end;
    
 
-- Crie um bloco PL/SQL que simule uma calculadora básica, realizando a operação indicada pelo usuário:

// Se o operador for  +, realize uma soma.
// Se o operador for  -, realize uma subtração.
// Se o operador for  *, realize uma multiplicação.
// Se o operador for  ", realize uma divisão.
 
-- R:

    
    
//'duiahduiah' || sexo || 'adioashdio'
//dbms_output.put_line