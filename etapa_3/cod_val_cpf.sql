create or replace function fnc_validar_cpf(p_num_cpf in number)
  return number is
  v_total       number := 0;
  v_digito      number := 0;
  v_str_num_cpf varchar2(11);
begin
  if nvl(p_num_cpf, 0) = 0 then
    return 1;
  else
    v_str_num_cpf := lpad(p_num_cpf, 11, '0');
  end if;
  for i in 1 .. 9
  loop
    v_total := v_total + substr(v_str_num_cpf, i, 1) * (11 - i);
  end loop;
  v_digito := 11 - mod(v_total, 11);
  if v_digito > 9 then
    v_digito := 0;
  end if;
  if v_digito != substr(v_str_num_cpf, 10, 1) then
    return 1;
  end if;
  v_total := 0;
  for i in 1 .. 10
  loop
    v_total := v_total + substr(v_str_num_cpf, i, 1) * (12 - i);
  end loop;
  v_digito := 11 - mod(v_total, 11);
  if v_digito > 9 then
    v_digito := 0;
  end if;
  if v_digito != substr(v_str_num_cpf, 11, 1) then
    return 1;
  end if;
  return 0;
end fnc_validar_cpf;


SET SERVEROUTPUT ON

BEGIN
    dbms_output.put_line (fnc_validar_cpf (012345678910));
END;

-- RETORNO DA EXECUÇÃO DA FUNÇÃO DE VALIDAÇÃO DE CPF - 1 (FALSO) ; 0 (VERDADEIRO)

1

Procedimento PL/SQL concluído com sucesso.
