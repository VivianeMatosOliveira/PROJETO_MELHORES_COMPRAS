
create or replace PROCEDURE sp_ocorrencia_sac
is
  v_atendsac T_MC_SGV_SAC%rowtype;
   v_categoria_prod T_MC_CATEGORIA_PROD%rowtype;
   v_produto T_MC_PRODUTO%rowtype;
   v_end_cliente T_MC_END_CLI%rowtype;
   v_logradouro T_MC_LOGRADOURO%rowtype;
   v_bairro T_MC_BAIRRO%rowtype;
   v_cidade T_MC_CIDADE%rowtype;
   v_estado T_MC_ESTADO%rowtype;
   v_cliente T_MC_CLIENTE%rowtype;
   v_vl_unitario_lucro NUMBER(5,2);
   v_vl_perc_icms_estado NUMBER(3);
   v_vl_icms_calculado NUMBER(3);
       CURSOR Cur_SAC Is
      SELECT S.NR_SAC                    "NUMERO DA OCORRENCIA" ,
       S.DT_ABERTURA_SAC                 "DATA ABERTURA SAC" ,
       S.HR_ABERTURA_SAC                 "HORA ABERTURA SAC" ,
       S.TP_SAC                          "TIPO DO SAC" ,
       S.NR_INDICE_SATISFACAO            "INDICCE DE SATISFACAO" , 
       T.CD_CATEGORIA                    "CODIGO CATEGORIA PROD",
       T.TP_CATEGORIA                    "TIPO CATEGORIA PROD" ,
       T.DS_CATEGORIA                    "DESCRICAO DA CATEGORIA PROD" ,
       P.CD_PRODUTO                      "CODIGO PRODUTO"    ,
       P.DS_PRODUTO                      "NOME DO PRODUTO",
       P.TP_EMBALAGEM                    "EMBALAGEM DO PRODUTO",
       P.VL_UNITARIO                     "VALOR UNITARIO DE VENDA",
       P.VL_PERC_LUCRO                   "PERCENTUAL DE LUCRO",
       E.SG_ESTADO                       "SIGLA DO ESTADO",
       E.NM_ESTADO                       "NOME DO ESTADO",
       CID.NM_CIDADE                     "NOME DA CIDADE",
       B.NM_BAIRRO                       "NOME DO BAIRRO",
       C.NR_CLIENTE                      "NUMERO DO CLIENTE",
       C.NM_CLIENTE                      "NOME DO CLIENTE",
       C.QT_ESTRELAS                     "QUANTIDADE ESTRELAS CLIENTE"
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

        v_vl_unitario_lucro := ((v_produto.VL_PERC_LUCRO/100)*v_produto.VL_UNITARIO);
        v_vl_perc_icms_estado :=  ((pf0110.fun_mc_gera_aliquota_media_icms_estado (v_estado.SG_ESTADO)));
        v_vl_icms_calculado :=  ((v_vl_perc_icms_estado/100)*v_produto.VL_UNITARIO);
      declare
        v_nr_indice_satisfacao number(2) := v_atendsac.NR_INDICE_SATISFACAO;
        v_ds_indice_satisfacao varchar2(30) := '';   
       begin
        pf0110.prc_mc_gera_indice_satisfacao_atd(v_nr_indice_satisfacao, v_ds_indice_satisfacao);

     end;

           IF (v_atendsac.TP_SAC = 'S' AND v_categoria_prod.TP_CATEGORIA = 'V') THEN
               INSERT INTO T_MC_SGV_OCORRENCIA_SAC (NR_OCORRENCIA_SAC,DT_ABERTURA_SAC, HR_ABERTURA_SAC, 
               DS_TIPO_CLASSIFICACAO_SAC, DS_INDICE_SATISFACAO_ATD_SAC, CD_CATEGORIA_PROD, NM_TIPO_CATEGORIA_PROD, 
               DS_CATEGORIA_PROD, CD_PRODUTO, DS_PRODUTO, TP_EMBALAGEM, VL_UNITARIO_PRODUTO, VL_PERC_LUCRO, 
               VL_UNITARIO_LUCRO_PRODUTO, SG_ESTADO, NM_ESTADO, NM_CIDADE, NM_BAIRRO, NR_CLIENTE, NM_CLIENTE, 
               QT_ESTRELAS_CLIENTE, VL_ICMS_PRODUTO )
               VALUES (SQ_NR_SAC.NEXTVAL,v_atendsac.DT_ABERTURA_SAC, v_atendsac.HR_ABERTURA_SAC,'SUGESTAO', v_atendsac.NR_INDICE_SATISFACAO,
               v_categoria_prod.CD_CATEGORIA,'VIDEO', v_categoria_prod.DS_CATEGORIA , v_produto.CD_PRODUTO, 
               v_produto.DS_PRODUTO, v_produto.TP_EMBALAGEM ,v_produto.VL_UNITARIO,v_produto.VL_PERC_LUCRO, v_vl_unitario_lucro,v_estado.SG_ESTADO, 
               v_estado.NM_ESTADO, v_cidade.NM_CIDADE, v_bairro.NM_BAIRRO, v_cliente.NR_CLIENTE , v_cliente.NM_CLIENTE,v_cliente.QT_ESTRELAS,v_vl_icms_calculado); 
               Commit;
           ELSIF (v_atendsac.TP_SAC = 'D' AND v_categoria_prod.TP_CATEGORIA = 'P') THEN
               INSERT INTO T_MC_SGV_OCORRENCIA_SAC (NR_OCORRENCIA_SAC,DT_ABERTURA_SAC, HR_ABERTURA_SAC, 
               DS_TIPO_CLASSIFICACAO_SAC, DS_INDICE_SATISFACAO_ATD_SAC, CD_CATEGORIA_PROD, NM_TIPO_CATEGORIA_PROD, 
               DS_CATEGORIA_PROD, CD_PRODUTO, DS_PRODUTO, TP_EMBALAGEM, VL_UNITARIO_PRODUTO, VL_PERC_LUCRO, 
               VL_UNITARIO_LUCRO_PRODUTO, SG_ESTADO, NM_ESTADO, NM_CIDADE, NM_BAIRRO, NR_CLIENTE, NM_CLIENTE, 
               QT_ESTRELAS_CLIENTE, VL_ICMS_PRODUTO )
               VALUES (SQ_NR_SAC.NEXTVAL,v_atendsac.DT_ABERTURA_SAC, v_atendsac.HR_ABERTURA_SAC,'DUVIDA', v_atendsac.NR_INDICE_SATISFACAO,
               v_categoria_prod.CD_CATEGORIA,'PRODUTO', v_categoria_prod.DS_CATEGORIA , v_produto.CD_PRODUTO, 
               v_produto.DS_PRODUTO, v_produto.TP_EMBALAGEM ,v_produto.VL_UNITARIO,v_produto.VL_PERC_LUCRO, v_vl_unitario_lucro,v_estado.SG_ESTADO, 
               v_estado.NM_ESTADO, v_cidade.NM_CIDADE, v_bairro.NM_BAIRRO, v_cliente.NR_CLIENTE , v_cliente.NM_CLIENTE,v_cliente.QT_ESTRELAS,v_vl_icms_calculado); 
               Commit; 
           ELSIF (v_atendsac.TP_SAC = 'E') THEN
              INSERT INTO T_MC_SGV_OCORRENCIA_SAC (NR_OCORRENCIA_SAC,DT_ABERTURA_SAC, HR_ABERTURA_SAC, 
           DS_TIPO_CLASSIFICACAO_SAC, DS_INDICE_SATISFACAO_ATD_SAC, CD_CATEGORIA_PROD, NM_TIPO_CATEGORIA_PROD, 
           DS_CATEGORIA_PROD, CD_PRODUTO, DS_PRODUTO, TP_EMBALAGEM, VL_UNITARIO_PRODUTO, VL_PERC_LUCRO, 
           VL_UNITARIO_LUCRO_PRODUTO, SG_ESTADO, NM_ESTADO, NM_CIDADE, NM_BAIRRO, NR_CLIENTE, NM_CLIENTE, 
           QT_ESTRELAS_CLIENTE, VL_ICMS_PRODUTO )
           VALUES (SQ_NR_SAC.NEXTVAL,v_atendsac.DT_ABERTURA_SAC, v_atendsac.HR_ABERTURA_SAC,'ELOGIO', v_atendsac.NR_INDICE_SATISFACAO,
           v_categoria_prod.CD_CATEGORIA,v_categoria_prod.TP_CATEGORIA, v_categoria_prod.DS_CATEGORIA , v_produto.CD_PRODUTO, 
           v_produto.DS_PRODUTO, v_produto.TP_EMBALAGEM ,v_produto.VL_UNITARIO,v_produto.VL_PERC_LUCRO,v_vl_unitario_lucro,v_estado.SG_ESTADO, 
           v_estado.NM_ESTADO, v_cidade.NM_CIDADE, v_bairro.NM_BAIRRO, v_cliente.NR_CLIENTE , v_cliente.NM_CLIENTE,v_cliente.QT_ESTRELAS,v_vl_icms_calculado); 
             Commit;
		  ELSE
              INSERT INTO T_MC_SGV_OCORRENCIA_SAC (NR_OCORRENCIA_SAC,DT_ABERTURA_SAC, HR_ABERTURA_SAC, 
           DS_TIPO_CLASSIFICACAO_SAC, DS_INDICE_SATISFACAO_ATD_SAC, CD_CATEGORIA_PROD, NM_TIPO_CATEGORIA_PROD, 
           DS_CATEGORIA_PROD, CD_PRODUTO, DS_PRODUTO, TP_EMBALAGEM, VL_UNITARIO_PRODUTO, VL_PERC_LUCRO, 
           VL_UNITARIO_LUCRO_PRODUTO, SG_ESTADO, NM_ESTADO, NM_CIDADE, NM_BAIRRO, NR_CLIENTE, NM_CLIENTE, 
           QT_ESTRELAS_CLIENTE, VL_ICMS_PRODUTO )
           VALUES (SQ_NR_SAC.NEXTVAL,v_atendsac.DT_ABERTURA_SAC, v_atendsac.HR_ABERTURA_SAC,'CLASSIFICACAO INVALIDA', v_atendsac.NR_INDICE_SATISFACAO,
           v_categoria_prod.CD_CATEGORIA,'CATEGORIA INVALIDA', v_categoria_prod.DS_CATEGORIA , v_produto.CD_PRODUTO, 
           v_produto.DS_PRODUTO, v_produto.TP_EMBALAGEM ,v_produto.VL_UNITARIO,v_produto.VL_PERC_LUCRO, v_vl_unitario_lucro,v_estado.SG_ESTADO, 
           v_estado.NM_ESTADO, v_cidade.NM_CIDADE, v_bairro.NM_BAIRRO, v_cliente.NR_CLIENTE , v_cliente.NM_CLIENTE,v_cliente.QT_ESTRELAS,v_vl_icms_calculado);
              Commit;
		  END IF;

        END LOOP;
        CLOSE Cur_SAC;
    End;
    


 
     
    
 
  
  
