Aula 1 - 10/02/26

Comandos de ambiente
Habilitando saída de dados
set serveroutput on

Desabilitando resposta de variaveis
set verify off

Estrutura de um bloco anonimo

declare
    area de variaveis
    opcional
    begin
        processamento, decisão, looping
        saida de dados...
        corpo do programa
        obrigatorio
    exception
        tratamento de erros
        opcional
    end;


1o programa

begin
    dbms_output.put_line('Oi');
    end;
    
begin
    dbms_output.put_line(37);
    end;

begin
    dbms_output.put_line(10+3);
    end;

begin
    dbms_output.put_line('Oi');
    dbms_output.put_line('Isso e FIAP');
    end;

Variaveis de memoria

Declare
    v_n1 number(4,2) := 10;
    v_n2 varchar(25) := 'Isso é FIAP';
    begin
    dbms_output.put_line(v_n1);
    dbms_output.put_line(v_n2);
    end;
    
    Declare
    v_n1 number(4,2) := 10;
    v_n2 varchar(25) := 'Isso é FIAP';
    begin
    dbms_output.put_line(v_n1||' - '||v_n2);
    end;
    
    Declare
    v_n1 number(4,2) := 10;
    v_n2 number(4,2) := 10;
    v_n3 number(4,2);
    begin
    v_n3 := v_n1 + v_n2;
    dbms_output.put_line('A soma dos valores é: '||v_n3);
    end;
    
    Declare
    v_n1 number(4,2) := 10;
    v_n2 number(4,2) := 10;
    v_n3 number(4,2) := v_n1 + v_n2;
    begin
        dbms_output.put_line('A soma dos valores é: '||v_n3);
    end;
    
Variaveis de substituição e herança de estrutura

Declare
    v_n1 number(8,2) := &valor1;
    v_n2 v_n1%type := &valor2;
    v_n3 v_n1%type;
    begin
    v_n3 := v_n1 + v_n2;
    dbms_output.put_line('A soma dos valores é: '||v_n3);
    end;
    
Criar um programa que apresente a média aritmética de 4 números reais

declare
-- declarando variaveis
    n1 number(8,2) := &valor1;
    n2 n1%type := &valor2;
    n3 n1%type := &valor3;
    n4 n1%type := &valor4;
-- calculando a média
    media n1%type := (n1 + n2 + n3 + n4) / 4;
    begin
-- exibindo resultado
        dbms_output.put_line(' A média vale: '||media);
    end;

Aula 2 - 24/02/26

Criar um bloco PL-SQL para calcular o valor do novo 
salário mínimo que deverá ser de 25% em cima do atual, que é de R$???

declare
    v_sal number(10,2) := &salario;
    v_sal_final number(10,2) := v_sal * 1.25;
begin
    dbms_output.put_line('Salario Minimo R$ '||v_sal);
    dbms_output.put_line('Salario Minimo com + 25 % R$ '||v_sal_final);
end;

Criar um bloco PL-SQL para calcular o valor de cada 
parcela de uma compra de um carro, nas seguintes condições:
- Parcelas para aquisição em 6 pagamentos. 
- Parcelas para aquisição em 12 pagamentos. 
- Parcelas para aquisição em 18 pagamentos. 
OBSERVAÇÃO: 
1 – Deverá ser dada uma entrada de 20% do valor da compra. 
2 – Deverá ser aplicada uma taxa juros, no saldo restante, nas 
seguintes condições: 
3 – No final informar o valor das parcelas para as 3 formas de 
pagamento, com o Valor de aquisição de 10.000.
A – Pagamento em 6 parcelas: 10%. 
B – Pagamento em 12 parcelas: 15%. 
C – Pagamento em 18 parcelas: 20%.

declare
    v_total number(10,2) := 10000;
    v_financiado v_total%type := v_total * 0.8;
    v_parcela v_total%type;
    begin
    v_parcela := (v_financiado * 1.1) / 6;
    dbms_output.put_line('Valor da parcela em 6x - R$'||v_parcela);
    v_parcela := (v_financiado * 1.15) / 12;
    dbms_output.put_line('Valor da parcela em 12x - R$'||v_parcela);
    v_parcela := (v_financiado * 1.2) / 18;
    dbms_output.put_line('Valor da parcela em 18x - R$'||v_parcela);
end;

declare 
    v1 number(6,2) := &valor1;
    v2 v1%type := &valor2;
    v3 v1%type := &valor3;
    v4 v1%type := &valor4;
    v_media v1%type := (v1 + v2 + v3+ v4)/4;
    begin
        if v_media >= 6 then
            dbms_output.put_line('Média = '||v_media||' Situação aprovado');
        elsif v_media>= 4 and v_media <= 5.9 then
            dbms_output.put_line('Média = '||v_media||' Situação DP');
        else
            dbms_output.put_line('Média = '||v_media||' Situação reprovado');
        end if;
    end;