-- declare
--     cursor c_aluno is
--     select ra, nome from aluno;
--     v_aluno c_aluno%rowtype;

-- nome_do_cursor%found
-- nome_do_cursor%notfound
-- nome_do_cursor%rowcount
-- nome_do_cursor%isopen

set serveroutput on;
set verify off;

drop table funcionarios cascade constraints;

create table funcionarios(
    cd_fun number(2),
    nm_fun varchar2(20),
    salario number(10,2),
    dt_adm date
);

declare
    cursor c_exibe is select nm_fun, salario from funcionarios;
begin

    insert into funcionarios values(1, 'Marcel', 10000, '17/04/2000');
    insert into funcionarios values(2, 'Claudia', 16000, '02/10/1998');
    insert into funcionarios values(3, 'Joaquim', 5500, '10/07/2010');
    insert into funcionarios values(4, 'Valéria', 7300, '08/06/2015');
    
    for v_exibe in c_exibe loop
        dbms_output.put_line('Nome: '||v_exibe.nm_fun||' - Salário: '||v_exibe.salario);
    end loop;
end;
/

alter table funcionarios
add tempo number(5);

declare
    cursor c_exibe is select * from funcionarios;
begin
    for v_exibe in c_exibe loop
        update funcionarios set tempo = sysdate - v_exibe.dt_adm
        where cd_fun = v_exibe.cd_fun;
    end loop;
end;
/

declare
    cursor c_exibe is select * from funcionarios;
begin
    for v_exibe in c_exibe loop
        if v_exibe.tempo/30 >= 150 then
            update funcionarios set salario = salario * 1.1
            where cd_fun = v_exibe.cd_fun;
        else
            update funcionarios set salario = salario * 1.05
            where cd_fun = v_exibe.cd_fun;
        end if;
    end loop;
end;
/

