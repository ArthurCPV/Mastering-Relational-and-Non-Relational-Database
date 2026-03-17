-- Necessários para rodar qualquer código
set serveroutput on;
set verify off;


-- Criando tabela
create table boletim(
    rm number(3) not null,
    cd_disc number(3) not null,
    nm_disc varchar(30) not null,
    c_hora number(3) not null,
    cp1 number(4,2),
    cp2 number(4,2),
    cp3 number(4,2),
    media number(4,2),
    faltas number(3),
    situacao varchar(50)
);


-- Inserts manuais
insert into boletim values(1, 10, 'JAVA', 100, 10, 10, 8, null, 0, null);
insert into boletim values(1, 20, 'DEVOPS', 100, 5, 6, 8, null, 0, null);
insert into boletim values(1, 30, 'IOT', 100, 8, 10, 9, null, 0, null);


-- Programa 1:

declare
-- Bloco da média
    v_cp1 number(4,2);
    v_cp2 number(4,2);
    v_cp3 number(4,2);
    v_media number(4,2);

-- Bloco das faltas
    v_codDisc number(3) := &v_codDisc;
    v_cargaH number(3);
    v_faltas number(3);
    v_situacao varchar(50);
    v_limite number(4,2);

begin
    select c_hora, cp1, cp2, cp3, faltas
    into v_cargaH, v_cp1, v_cp2, v_cp3, v_faltas
    from boletim
    where cd_disc = v_codDisc;
    
    v_limite := v_cargaH / 4;

-- Bloco da média
    if v_cp1 <= v_cp2 and v_cp1 <= v_cp3 then
        v_media := (v_cp2 + v_cp3) / 2;
    elsif v_cp2 <= v_cp1 and v_cp2 <= v_cp3 then
        v_media := (v_cp1 + v_cp3) / 2;
    else
        v_media := (v_cp1 + v_cp2) / 2;
    end if;
    dbms_output.put_line('Sua média é: ' || v_media || '!');
    
    update boletim
    set media = v_media
    where cd_disc = v_codDisc;

-- Bloco das faltas
    if v_faltas < v_limite and v_media >= 6 then
    v_situacao := 'Aprovado';
    elsif v_faltas >= v_limite and v_media >= 6 then
    v_situacao := 'Reprovado por faltas';
    elsif v_faltas < v_limite and v_media >= 4 and v_media < 6 then
    v_situacao := 'Exame';
    elsif v_faltas < v_limite and v_media < 4 then
    v_situacao := 'Reprovado por nota';
    elsif v_faltas >= v_limite and v_media < 4 then
    v_situacao := 'Reprovado por nota e faltas';
    end if;
    dbms_output.put_line('Situação: ' || v_situacao || '!');
    
    update boletim
    set situacao = v_situacao
    where cd_disc = v_codDisc;
    
end;
