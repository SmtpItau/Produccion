USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OMA1]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_OMA1]
AS
BEGIN
   SELECT acfecproc,
          acfecprox,
          'uf_hoy'    = CONVERT(FLOAT, 0),
          'uf_man'    = CONVERT(FLOAT, 0),
          'ivp_hoy'   = CONVERT(FLOAT, 0),
          'ivp_man'   = CONVERT(FLOAT, 0),
          'do_hoy'    = CONVERT(FLOAT, 0),
          'do_man'    = CONVERT(FLOAT, 0),
          'da_hoy'    = CONVERT(FLOAT, 0),
          'da_man'    = CONVERT(FLOAT, 0),
          acnomprop,
          'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
      INTO #PARAMETROS
      FROM MDAC
/* RESCATA VALOR DE UF -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET uf_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
  FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
  WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
   AND VIEW_VALOR_MONEDA.vmcodigo = 998
 UPDATE #PARAMETROS SET uf_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
 UPDATE #PARAMETROS SET ivp_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
 UPDATE #PARAMETROS SET ivp_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET do_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
 UPDATE #PARAMETROS SET do_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET da_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
 UPDATE #PARAMETROS SET da_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
/* DECLARE @dFecpro DATETIME ,
  @dFecprox DATETIME ,
  @cNombre CHAR (40) ,
  @cFono  CHAR (15) ,
  @pdbc_po NUMERIC (19,2) ,
  @pdbc_rc NUMERIC (19,2) ,
  @pdbc_rv NUMERIC (19,2) ,
  @pdbc_rs NUMERIC (19,2) ,
  @pdbc_spD NUMERIC (19,2) ,
  @pdbc_stD NUMERIC (19,2) ,
  @pdbc_spI NUMERIC (19,2)  ,
  @pdbc_stI NUMERIC (19,2) ,
  @prbc_po NUMERIC (19,2) ,
  @prbc_rc NUMERIC (19,2) ,
  @prbc_rv NUMERIC (19,2) ,
  @prbc_rs NUMERIC (19,2) ,
  @prbc_spD NUMERIC (19,2) ,
  @prbc_stD NUMERIC (19,2) ,
  @prbc_spI NUMERIC (19,2) ,
  @prbc_stI NUMERIC (19,2) ,
  @prc_po  NUMERIC (19,2) ,
  @prc_rc  NUMERIC (19,2) ,
  @prc_rv  NUMERIC (19,2) ,
  @prc_rs  NUMERIC (19,2) ,
  @prc_spD NUMERIC (19,2) ,
  @prc_stD NUMERIC (19,2) ,
  @prc_spI NUMERIC (19,2) ,
  @prc_stI NUMERIC (19,2) ,
  @ptf_po  NUMERIC (19,2) ,
  @ptf_rc  NUMERIC (19,2) ,
  @ptf_rv  NUMERIC (19,2) ,
  @ptf_rs  NUMERIC (19,2) ,
  @ptf_spD NUMERIC (19,2) ,
  @ptf_stD NUMERIC (19,2) ,
  @ptf_spI NUMERIC (19,2) ,
  @ptf_stI NUMERIC (19,2)
*/
  CREATE TABLE #TEMP
     (
     serie  CHAR (10) NULL ,
     cliente  NUMERIC (10,0) NULL ,
     tipoper  CHAR (03) NULL ,
     monto  NUMERIC (19,2) NULL ,
     tasa  NUMERIC (19,2) NULL ,
     dias  NUMERIC (19,0) NULL ,
     contador  NUMERIC (19,0) IDENTITY (1,1) NOT NULL
     )
  CREATE TABLE #TEMP2
     (
     serie  CHAR (10) NULL ,
     cliente  NUMERIC (10,0) NULL ,
     tipoper  CHAR (3) NULL ,
     monto  NUMERIC (19,2) NULL ,
     tasa  NUMERIC (19,2) NULL ,
     dias  NUMERIC (19,0) NULL
     )
  INSERT INTO #TEMP
    (
    serie      ,
    cliente      ,
    tipoper      ,
    monto      ,
    tasa      ,
    dias
    )
  SELECT
    inserie      ,
    morutcli     ,
    SUBSTRING(mdmo.motipoper,1,1)   ,
    monominal     ,
    monominal * motir    ,
    monominal * DATEDIFF(DAY,mofecinip,mofecvenp)
  FROM  MDMO, VIEW_INSTRUMENTO
  WHERE  incodigo=mocodigo AND (motipoper='CI' OR motipoper='VI') AND
    mostatreg<>'A'
  INSERT INTO #TEMP
    (
    serie      ,
    cliente      ,
    tipoper      ,
    monto      ,
    tasa      ,
    dias
    )
  SELECT
    inserie      ,
    morutcli     ,
    SUBSTRING(motipoper,1,1)   ,
    monominal     ,
    monominal * motir    ,
    monominal * DATEDIFF(DAY,mofecpro,mofecven)
  FROM  MDMO, VIEW_INSTRUMENTO
  WHERE  incodigo=mocodigo AND motipoper='CP' AND (mostatreg<>'A')
  INSERT INTO #TEMP
    (
    serie      ,
    cliente      ,
    tipoper      ,
    monto      ,
    tasa      ,
    dias
    )
  SELECT
    inserie      ,
    morutcli     ,
    SUBSTRING(motipoper,1,1)   ,
    monominal     ,
    monominal * motir    ,
    monominal * DATEDIFF(DAY,cpfeccomp,mofecven)
  FROM MDMO, VIEW_INSTRUMENTO ,MDCP
  WHERE incodigo=mocodigo AND motipoper='VP' AND cpnumdocu=monumdocu AND
   cpcorrela=mocorrela AND (mostatreg<>'A')
  UPDATE #TEMP
  SET cliente = CONVERT(NUMERIC(10,0),cltipcli)
  FROM VIEW_CLIENTE
  WHERE clrut=cliente AND cliente<>97029000
  UPDATE #TEMP
  SET cliente = 3
  WHERE cliente=97029000
  INSERT INTO #TEMP2
    (
    serie  ,
    cliente  ,
    tipoper  ,
    monto  ,
    tasa  ,
    dias
    )
  SELECT
    serie  ,
    cliente  ,
    tipoper  ,
    SUM(monto) ,
    SUM(tasa) ,
    SUM(dias)
  FROM #TEMP
  GROUP BY serie,cliente,tipoper
  UPDATE #TEMP2
  SET tasa = ROUND(tasa/monto,2) ,
   dias = ROUND(dias/monto,0)
  UPDATE #TEMP2
  SET monto = ROUND(monto/1000,2)
  WHERE serie<>'PDBC'
  UPDATE #TEMP2
  SET monto = ROUND(monto/1000000,2)
  WHERE serie='PDBC'
  DELETE FROM MD_OMA
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AA3','PDBC','1','AA0','AA1','AA2','MILLONES $','NOM.',1)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AA4','PDBC','2','AA0','AA1','AA2','MILLONES $','NOM.',1)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AA5','PDBC','3','AA0','AA1','AA2','MILLONES $','NOM.',1)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AA6','PDBC','4','AA0','AA1','AA2','MILLONES $','NOM.',1)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AA7','PDBC','5','AA0','AA1','AA2','MILLONES $','NOM.',1)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAB','PRBC','1','AA8','AA9','AAA','MILES U.F.','REAL',2)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAC','PRBC','2','AA8','AA9','AAA','MILES U.F.','REAL',2)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAD','PRBC','3','AA8','AA9','AAA','MILES U.F.','REAL',2)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAE','PRBC','4','AA8','AA9','AAA','MILES U.F.','REAL',2)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAF','PRBC','5','AA8','AA9','AAA','MILES U.F.','REAL',2)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAJ','PRC' ,'1','AAG','AAH','AAI','MILES U.F.','REAL',3)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAK','PRC' ,'2','AAG','AAH','AAI','MILES U.F.','REAL',3)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAL','PRC' ,'3','AAG','AAH','AAI','MILES U.F.','REAL',3)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAM','PRC' ,'4','AAG','AAH','AAI','MILES U.F.','REAL',3)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAN','PRC' ,'5','AAG','AAH','AAI','MILES U.F.','REAL',3)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAR','PTF' ,'1','AAO','AAP','AAQ','MILES U.F.','REAL',4)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAS','PTF' ,'2','AAO','AAP','AAQ','MILES U.F.','REAL',4)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAT','PTF' ,'3','AAO','AAP','AAQ','MILES U.F.','REAL',4)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAU','PTF' ,'4','AAO','AAP','AAQ','MILES U.F.','REAL',4)
  INSERT INTO MD_OMA(omacodigo,omagrupo,omatipcli,omacodigo1,omacodigo2,omacodigo3,omamoneda,omatiptasa,omaorden) VALUES ('AAV','PTF' ,'5','AAO','AAP','AAQ','MILES U.F.','REAL',4)
  UPDATE MD_OMA
  SET omaventmon = 0 ,
   omaventtas = 0 ,
   omaventpla = 0 ,
   omacompmon = 0 ,
   omacomptas = 0 ,
   omacomppla = 0
  UPDATE MD_OMA SET omacompmon = omacompmon + monto,omacomptas=tasa,omacomppla=dias  FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '1' AND cliente = 2 AND tipoper = 'C'
  UPDATE MD_OMA SET omacompmon = omacompmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '3' AND cliente = 2 AND tipoper = 'C'
  UPDATE MD_OMA SET omacompmon = omacompmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '5' AND cliente = 2 AND tipoper = 'C'
  UPDATE MD_OMA SET omacompmon = omacompmon + monto,omacomptas=tasa,omacomppla=dias  FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '2' AND cliente = 1 AND tipoper = 'C'
  UPDATE MD_OMA SET omacompmon = omacompmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '3' AND cliente = 1 AND tipoper = 'C'
  UPDATE MD_OMA SET omacompmon = omacompmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '5' AND cliente = 1 AND tipoper = 'C'
  UPDATE MD_OMA SET omacompmon = omacompmon + monto,omacomptas=tasa,omacomppla=dias  FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '4' AND cliente = 3 AND tipoper = 'C'
  UPDATE MD_OMA SET omacompmon = omacompmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '5' AND cliente = 3 AND tipoper = 'C'
  UPDATE MD_OMA SET omaventmon = omaventmon + monto,omaventtas=tasa,omaventpla=dias  FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '1' AND cliente = 2 AND tipoper = 'V'
  UPDATE MD_OMA SET omaventmon = omaventmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '3' AND cliente = 2 AND tipoper = 'V'
  UPDATE MD_OMA SET omaventmon = omaventmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '5' AND cliente = 2 AND tipoper = 'V'
  UPDATE MD_OMA SET omaventmon = omaventmon + monto,omaventtas=tasa,omaventpla=dias  FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '2' AND cliente = 1 AND tipoper = 'V'
  UPDATE MD_OMA SET omaventmon = omaventmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '3' AND cliente = 1 AND tipoper = 'V'
  UPDATE MD_OMA SET omaventmon = omaventmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '5' AND cliente = 1 AND tipoper = 'V'
  UPDATE MD_OMA SET omaventmon = omaventmon + monto,omaventtas=tasa,omaventpla=dias  FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '4' AND cliente = 3 AND tipoper = 'V'
  UPDATE MD_OMA SET omaventmon = omaventmon + monto      FROM #TEMP2 WHERE omagrupo=serie AND omatipcli = '5' AND cliente = 3 AND tipoper = 'V'
  UPDATE MD_OMA SET omaglogrupo='1.- P.D.B.C.'  WHERE omagrupo='PDBC'
  UPDATE MD_OMA SET omaglogrupo='2.- P.R.B.C.' WHERE omagrupo='PRBC'
  UPDATE MD_OMA SET omaglogrupo='3.- P.R.C.'  WHERE omagrupo='PRC'
  UPDATE MD_OMA SET omaglogrupo='4.- P.T.F.'  WHERE omagrupo='PTF'
  UPDATE MD_OMA SET omaglocli='Inst.Financ'  WHERE omatipcli='1'
  UPDATE MD_OMA SET omaglocli='Publico'   WHERE omatipcli='2'
  UPDATE MD_OMA SET omaglocli='Sub-Total'  WHERE omatipcli='3'
  UPDATE MD_OMA SET omaglocli='Bco. Central'  WHERE omatipcli='4'
  UPDATE MD_OMA SET omaglocli='Total'   WHERE omatipcli='5'
                 SELECT 'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
                        'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
                        uf_hoy,
                        uf_man,
                        ivp_hoy,
                        ivp_man,
                        do_hoy,
                        do_man,
                        da_hoy,
                        da_man,
                        acnomprop,
                        rut_empresa,
                        'hora' = CONVERT(varchar(10), GETDATE(), 108),
          omacodigo ,  --1
                 omaglogrupo ,  --2
                        omaglocli ,  --3
   omaventmon ,  --4
   omaventtas ,  --5
   omaventpla ,  --6
   omacompmon ,  --7
   omacomptas ,  --8
   omacomppla ,  --9
   omacodigo1 ,  --10
   omacodigo2 ,  --11
   omacodigo3 ,  --12
   omamoneda ,  --13
   omaorden ,  --14
   omatiptasa
  FROM MD_OMA, #PARAMETROS 
  ORDER BY omaorden,omatipcli
 
END
-- sp_helptext sp_oma 1
-- sp_oma 2
-- select cifecvenp,* from MdCi
-- select cltipcli,* from VIEW_CLIENTE where clrut=97029000
-- sp_help VIEW_CLIENTE
-- SELECT MONOMINAL * DATEDIFF(DAY,MOFECPRO,MOFECVEN) FROM MDMO WHERE MOTIPOPER = 'CP'
-- update VIEW_CLIENTE set cltipcli='1' where cltipcli='0'
-- select * from mdmo  --16027 -1146
-- select * from MDCP where cpnumdocu =  16027
-- update mdac set acfecprox = '10/08/1997'
-- update mdac set acnom_resoma = 'MARCELO QUILODRAN M.',acfon_resoma='22222222'
-- select * from MdVi where substring(viinstser,1,3)='PDB'

GO
