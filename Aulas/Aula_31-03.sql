set serveroutput on;
set verify off;

declare
    v_num number(3) := &valor;
    v_contador number(3) := 1;
    v_impar number(3) := 0;
    v_par number(3) := 0;
begin
    loop
        if mod(v_contador, 2) = 0 then
            v_par := v_par + 1;
        else
            v_impar := v_impar + 1;
        end if;
        v_contador := v_contador + 1;
        exit when v_contador > v_num;
    end loop;
        dbms_output.put_line('Número de pares: '||v_par);
        dbms_output.put_line('Número de ímpares: '||v_impar);
end;


declare
    v_num number(3) := &valor;
    v_contador number(3) := 1;
    v_impar number(3) := 0;
    v_par number(3) := 0;
    v_media number(3) := 0;
begin
    loop
        if mod(v_contador, 2) = 0 then
            v_par := v_par + 1;
            v_media := v_media + v_contador;
        else
            v_impar := v_impar + 1;
        end if;
        v_contador := v_contador + 1;
        v_media := v_media / v_contador;
        exit when v_contador > v_num;
    end loop;
        dbms_output.put_line('Número de pares: '||v_par);
        dbms_output.put_line('Número de ímpares: '||v_impar);
        dbms_output.put_line('Média de pares: '||v_media);
        
end;
    