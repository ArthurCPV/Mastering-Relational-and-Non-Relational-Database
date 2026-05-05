/*
Avaliação Prática 2 – Funcionários e Departamentos

Considere as tabelas:
FUNCIONARIOS (id_func, nome, salario, id_departamento, bonus)
DEPARTAMENTOS (id_departamento, nome_departamento)

Desenvolva um bloco PL/SQL que:
1. Utilize um cursor explícito para percorrer os funcionários
2. Para cada funcionário:
      Leia o nome do departamento
3. Realize o seguinte processamento:
      Salário ≥ 5000 → bônus = 10% do salário
      Salário entre 3000 e 4999 → bônus = 5%
      Caso contrário → bônus = 2%
4. Faça uma atualização do bônus na tabela FUNCIONARIOS
5. Ao final, exiba:
      Total de funcionários processados
      Soma total dos bônus pagos
*/

set serveroutput on
set verify off

drop table funcionarios cascade constraint;
drop table departamentos cascade constraint;

create table departamentos(
    id_departamento number(4) primary key,
    nome_departamento varchar(200)
);

create table funcionarios (
    id_func number(4) primary key,
    nome varchar2(200),
    salario number (7,2),
    bonus number(7,2),
    id_departamento number(4)
    references departamentos(id_departamento)
);

insert into departamentos values(1, 'Administrativo');
insert into departamentos values(2, 'Financeiro');
insert into departamentos values(3, 'Segurança');

insert into funcionarios values(1, 'Robson', 5000, 0, 1);
insert into funcionarios values(2, 'Diana', 3500, 0, 2);
insert into funcionarios values(3, 'Mike Wasalski', 1500, 0, 3);

declare
    cursor c_exibe is select * from funcionarios;
    func_count number(4) := 0;
    bonus_soma number(7,2) := 0;
begin
    for v_exibe in c_exibe loop
        if v_exibe.salario >= 5000 then
            bonus_soma := bonus_soma + ((v_exibe.salario * 1.1) - v_exibe.salario);
            update funcionarios set bonus = bonus_soma where id_func = v_exibe.id_func;
            update funcionarios set salario = salario * 1.1 where id_func = v_exibe.id_func;
        elsif v_exibe.salario >= 3000 and v_exibe.salario <= 4999 then
            bonus_soma := bonus_soma + ((v_exibe.salario * 1.05) - v_exibe.salario);
            update funcionarios set bonus = bonus_soma where id_func = v_exibe.id_func;
            update funcionarios set salario = salario * 1.05 where id_func = v_exibe.id_func;
        else
            bonus_soma := bonus_soma + ((v_exibe.salario * 1.02) - v_exibe.salario);
            update funcionarios set bonus = bonus_soma where id_func = v_exibe.id_func;
            update funcionarios set salario = salario * 1.02 where id_func = v_exibe.id_func;
        end if;
        func_count := func_count + 1;
    end loop;
    dbms_output.put_line('Funcionários percorridos: '|| func_count);
    dbms_output.put_line('Soma dos bônus: '|| bonus_soma);
end;

