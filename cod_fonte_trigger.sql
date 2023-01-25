
 set serveroutput on 
 CREATE OR REPLACE TRIGGER tr_val_cpf
      BEFORE  INSERT OR UPDATE ON T_MC_CLI_FISICA
        FOR EACH ROW
            DECLARE p_num_cpf  T_MC_CLI_FISICA.NR_CPF%type;
            v_Retorno_Validacao NUMBER(3);
                BEGIN                
                    v_Retorno_Validacao:= fnc_validar_cpf(p_num_cpf); 
                    IF (v_Retorno_Validacao = 0) THEN
                        dbms_output.put_line ( 'CPF Valido: ' || p_num_cpf);                        
                    ELSE
                        dbms_output.put_line ( 'CPF Invalido: ' || p_num_cpf);
                        RAISE_APPLICATION_ERROR (-20202,'CPF Invalido');
                    END IF;
  END;
  
  -- TESTANDO A TRIGGER
  
  SET SERVEROUTPUT ON
UPDATE T_MC_CLI_FISICA  SET NR_CPF = 01234567891  WHERE NR_CLIENTE = 8

 -- RESULTADO DE EXECUÇÃO DE TRIGGER
 
 CPF Invalido: 

Erro a partir da linha : 136 no comando -
UPDATE T_MC_CLI_FISICA  SET NR_CPF = 01234567891  WHERE NR_CLIENTE = 8
Relatório de erros -
ORA-20202: CPF Invalido
ORA-06512: em "RM93900.TR_VAL_CPF", line 9

