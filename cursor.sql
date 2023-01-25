SET SERVEROUTPUT ON

DECLARE
   v_atendsac T_MC_SGV_SAC%rowtype;
   v_categoria_prod T_MC_CATEGORIA_PROD%rowtype;
   v_produto T_MC_PRODUTO%rowtype;
   v_end_cliente T_MC_END_CLI%rowtype;
   v_logradouro T_MC_LOGRADOURO%rowtype;
   v_bairro T_MC_BAIRRO%rowtype;
   v_cidade T_MC_CIDADE%rowtype;
   v_estado T_MC_ESTADO%rowtype;
   v_cliente T_MC_CLIENTE%rowtype;
      CURSOR Cur_SAC Is
      SELECT S.NR_SAC ,
       S.DT_ABERTURA_SAC ,
       S.HR_ABERTURA_SAC ,
       S.TP_SAC ,
       S.NR_INDICE_SATISFACAO ,
       T.CD_CATEGORIA ,
       T.TP_CATEGORIA ,
       T.DS_CATEGORIA ,
       P.CD_PRODUTO ,
       P.DS_PRODUTO ,
       P.TP_EMBALAGEM ,
       P.VL_UNITARIO ,
       P.VL_PERC_LUCRO ,
       E.SG_ESTADO ,
       E.NM_ESTADO ,
       CID.NM_CIDADE ,
       B.NM_BAIRRO ,
       C.NR_CLIENTE ,
       C.NM_CLIENTE ,
       C.QT_ESTRELAS
    FROM T_MC_SGV_SAC S 
    INNER JOIN T_MC_CLIENTE C
         ON (S.NR_CLIENTE = C.NR_CLIENTE)
         INNER JOIN T_MC_PRODUTO P 
         ON (P.CD_PRODUTO = S.CD_PRODUTO)
         INNER JOIN T_MC_CATEGORIA_PROD T
         ON (T.CD_CATEGORIA = P.CD_CATEGORIA)
         INNER JOIN T_MC_END_CLI EC
         ON C.NR_CLIENTE = EC.NR_CLIENTE
         INNER JOIN T_MC_LOGRADOURO L
         ON CD_LOGRADOURO_CLI = CD_LOGRADOURO
         INNER JOIN T_MC_BAIRRO B
         ON B.CD_BAIRRO = L.CD_BAIRRO
         INNER JOIN T_MC_CIDADE CID
         ON CID.CD_CIDADE = B.CD_CIDADE
         INNER JOIN T_MC_ESTADO E
         ON E.SG_ESTADO = CID.SG_ESTADO;
Begin
      OPEN Cur_SAC;
      LOOP
         FETCH Cur_SAC INTO v_atendsac.NR_SAC,v_atendsac.DT_ABERTURA_SAC, v_atendsac.HR_ABERTURA_SAC , v_atendsac.TP_SAC, v_atendsac.NR_INDICE_SATISFACAO ,
        v_categoria_prod.CD_CATEGORIA, v_categoria_prod.TP_CATEGORIA ,v_categoria_prod.DS_CATEGORIA , v_produto.CD_PRODUTO, v_produto.DS_PRODUTO, 
        v_produto.TP_EMBALAGEM ,v_produto.VL_UNITARIO, v_produto.VL_PERC_LUCRO,v_estado.SG_ESTADO, 
        v_estado.NM_ESTADO, v_cidade.NM_CIDADE, v_bairro.NM_BAIRRO, v_cliente.NR_CLIENTE , v_cliente.NM_CLIENTE,v_cliente.QT_ESTRELAS;
        EXIT WHEN Cur_SAC%NOTFOUND;
        dbms_output.put_line
          ('NUMERO DA OCORRENCIA: ' || v_atendsac.NR_SAC);
        dbms_output.put_line
          ('DATA ABERTURA SAC: ' || v_atendsac.DT_ABERTURA_SAC);
        dbms_output.put_line
          ('HORA ABERTURA SAC: ' || v_atendsac.HR_ABERTURA_SAC);
        dbms_output.put_line
          ('TIPO DO SAC: '  || v_atendsac.TP_SAC);
        dbms_output.put_line
          ('INDICCE DE SATISFACAO: '  || v_atendsac.NR_INDICE_SATISFACAO);
        dbms_output.put_line
          ('CODIGO CATEGORIA PROD: '  || v_categoria_prod.CD_CATEGORIA);
        dbms_output.put_line
          ('TIPO CATEGORIA PROD: '  || v_categoria_prod.TP_CATEGORIA);
        dbms_output.put_line
          ('DESCRICAO DA CATEGORIA PROD: '  || v_categoria_prod.DS_CATEGORIA);
        dbms_output.put_line
          ('CODIGO PRODUTO:  '  || v_produto.CD_PRODUTO);
        dbms_output.put_line
          ('NOME DO PRODUTO:  '  || v_produto.DS_PRODUTO);
        dbms_output.put_line
          ('EMBALAGEM DO PRODUTO:  '  || v_produto.TP_EMBALAGEM);
        dbms_output.put_line
          ('VALOR UNITARIO DE VENDA: '  || v_produto.VL_UNITARIO);
        dbms_output.put_line
          ('PERCENTUAL DE LUCRO: '  || v_produto.VL_PERC_LUCRO);
        dbms_output.put_line
          ('SIGLA DO ESTADO: '  || v_estado.SG_ESTADO);
        dbms_output.put_line
          ('NOME DO ESTADO:  '  || v_estado.NM_ESTADO);
        dbms_output.put_line
          ('NOME DA CIDADE: '  || v_cidade.NM_CIDADE);
        dbms_output.put_line
          ('NOME DO BAIRRO:  '  || v_bairro.NM_BAIRRO);
        dbms_output.put_line
          ('NUMERO DO CLIENTE:  '  || v_cliente.NR_CLIENTE);
        dbms_output.put_line
          ('NOME DO CLIENTE:  '  || v_cliente.NM_CLIENTE);
        dbms_output.put_line
          ('QUANTIDADE ESTRELAS CLIENTE:  '  || v_cliente.QT_ESTRELAS);
        END LOOP;
        CLOSE Cur_SAC;
    End;
	
	
	Procedimento PL/SQL concluído com sucesso.

NUMERO DA OCORRENCIA: 1
DATA ABERTURA SAC: 01/03/22
HORA ABERTURA SAC: 
TIPO DO SAC: D
INDICCE DE SATISFACAO: 
CODIGO CATEGORIA PROD: 13
TIPO CATEGORIA PROD: P
DESCRICAO DA CATEGORIA PROD: UTILIDADES DOMESTICAS
CODIGO PRODUTO:  5
NOME DO PRODUTO:  JOGO DE PANELAS BRINOX REVESTIMENTO CERÂMICO
EMBALAGEM DO PRODUTO:  
VALOR UNITARIO DE VENDA: 699
PERCENTUAL DE LUCRO: 
SIGLA DO ESTADO: MT
NOME DO ESTADO:  MATO GROSSO
NOME DA CIDADE: VARZEA GRANDE
NOME DO BAIRRO:  CRISTO REI
NUMERO DO CLIENTE:  8
NOME DO CLIENTE:  JULIA LEMES DE LIMA
QUANTIDADE ESTRELAS CLIENTE:  1
