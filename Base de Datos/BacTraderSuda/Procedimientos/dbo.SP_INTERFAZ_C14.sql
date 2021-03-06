USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_C14]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_C14]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @fecproc CHAR (10)
 SELECT @fecproc = CONVERT(CHAR(10),acfecproc,112) FROM MDAC
 SELECT rut = CASE
    WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE cpmascara=semascara)
     END         ,
  ctacontable         ,
  moneda = CASE
    WHEN cpseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT semonemi FROM VIEW_SERIE WHERE cpmascara=semascara)
     END         ,
  valor = ROUND(cpvalcomu,4)       ,
  fecha = CONVERT(CHAR(10),cpfecven,112)     ,
  dv = '0'         ,
  tip = 'CP'         ,
  g = cpnumdocu        ,
  c = cpcorrela        ,
  i = 'N'
 INTO #TC14
 FROM MDCP, CARTERA_CUENTA
 WHERE (cpnumdocu=numdocu AND cpcorrela=correla AND t_operacion='CP')
 AND SUBSTRING(cpinstser,1,3)<>'DPX'
 AND variable='valor_compra'
 AND cpnominal>0
 AND cpcodigo<>888
 INSERT INTO
 #TC14
 SELECT rut = cirutcli  ,
  ctacontable   ,
  cimonpact   ,
  ROUND(civalcomu,4)  , 
  CONVERT(CHAR(10),cifecvenp,112) ,
  '0'    ,
  'CP'    ,
  cinumdocu   ,
  cicorrela   ,
  'N'
 FROM MDCI, CARTERA_CUENTA
 WHERE cicodigo=codigoinst
 AND numdocu=cinumdocu
 AND correla=cicorrela
 AND variable='valor_compra'
 AND ciinstser IN ('ICOL','ICAP')
 INSERT INTO
 #TC14
 SELECT rut = cirutcli  ,
  ctacontable   ,
  cimonpact   ,
  ROUND(civalcomu,4)  , 
  CONVERT(CHAR(10),cifecvenp,112) ,
  '0'    ,
  'CI'    ,
  cinumdocu   ,
  cicorrela   ,
  'N'
 FROM MDCI, CARTERA_CUENTA
 WHERE cicodigo=codigoinst
 AND numdocu=cinumdocu
 AND correla=cicorrela
 AND variable='valor_compra'
 AND NOT (ciinstser IN ('ICOL','ICAP') )
 INSERT INTO
 #TC14 
 SELECT rut = virutcli  ,
  ctacontable   ,
  vimonpact   ,
  ROUND(vivalvemu,4)  ,
  CONVERT(CHAR(10),vifecvenp,112) ,
  '0'    ,
  'VI'    ,
  vinumoper   ,
  vicorrela   ,
  'N'
 FROM MDVI, CARTERA_CUENTA, VIEW_CLIENTE
 WHERE vinumdocu=numdocu
 AND vicorrela=correla
 AND vinumoper=numoper
 AND variable='valor_compra'
 AND vicodigo<>888
 AND (virutcli=clrut AND CONVERT(INTEGER,cltipcli) in (1,3) )
 INSERT INTO
 #TC14
 SELECT CASE
   WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
   ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
  END        ,
         ctacontable       ,
  CASE
   WHEN cpseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
   ELSE (SELECT semonemi FROM VIEW_SERIE WHERE cpmascara=semascara)
  END        ,
  cpinteresc       ,
  CONVERT(CHAR(10),cpfecven,112)     ,
  '0'        ,
  'CP'        ,
  cpnumdocu       ,
  cpcorrela       ,
  'S'
 FROM MDCP, CARTERA_CUENTA
 WHERE cpnumdocu=numdocu
 AND cpcorrela=correla
 AND t_operacion='DVCP'
 AND SUBSTRING(cpinstser,1,3)<>'DPX'
 AND variable='interes_papel'
 AND cpcodigo<>888
 AND  cpnominal>0
 DELETE #TC14 WHERE rut='97029000' OR rut='97018000'
 INSERT INTO
 #TC14 
 SELECT rut = cirutcli ,
  ctacontable  ,
  cimonpact  ,
  ciinteresci  ,
  CONVERT(CHAR(10),cifecvenp,112) ,
  '0'   ,
  'CI'   ,
  cinumdocu  ,
  cicorrela  ,
  'S'
 FROM MDCI, CARTERA_CUENTA
 WHERE cicodigo=codigoinst
 AND numdocu=cinumdocu
 AND correla=cicorrela
 AND variable='Interes_pacto'
 AND NOT ( ciinstser IN ('ICOL','ICAP')) 
 INSERT INTO
 #TC14 
 SELECT rut = cirutcli ,
  ctacontable  ,
  cimonpact  ,
  ciinteresci  ,
  CONVERT(CHAR(10),cifecvenp,112),
  '0'   ,
  'IB'   ,
  cinumdocu  ,
  cicorrela  ,
  'S'
 FROM MDCI, CARTERA_CUENTA
 WHERE cicodigo=codigoinst
 AND numdocu=cinumdocu
 AND correla=cicorrela
 AND variable='Interes_papel'
 AND ciinstser IN ('ICAP')
 INSERT INTO
 #TC14 
SELECT rut = cirutcli ,
  ctacontable  ,
  cimonpact ,
  ciinteresci  ,
  CONVERT(CHAR(10),cifecvenp,112),
  '0'   ,
  'IB'   ,
  cinumdocu  ,
  cicorrela  ,
  'S'
 FROM MDCI, CARTERA_CUENTA
 WHERE cicodigo=codigoinst
 AND numdocu=cinumdocu
 AND correla=cicorrela
 AND variable='Interes_pacto'
 AND ciinstser IN ('ICOL')
 INSERT INTO
 #TC14 
 SELECT rut = virutcli  ,
  ctacontable   ,
  vimonpact   ,
  viinteresvi   ,
  CONVERT(CHAR(10),vifecvenp,112) ,
  '0'    ,
  'VI'    ,
  vinumoper   ,
  vicorrela   ,
  'S'
 FROM MDVI, CARTERA_CUENTA, VIEW_CLIENTE
 WHERE vinumdocu=numdocu
 AND vicorrela=correla
 AND vinumoper=numoper
 AND variable='interes_pacto'
 AND vicodigo<>888
 AND (virutcli=clrut AND CONVERT(INTEGER,cltipcli)<4)
 UPDATE #TC14
 SET valor = ROUND(valor/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha=@fecproc AND vmcodigo=moneda),4)
 WHERE i='S' AND moneda<>999
 UPDATE #TC14 SET dv = cldv FROM VIEW_CLIENTE WHERE rut=clrut 
 UPDATE #TC14 SET dv = emdv FROM VIEW_EMISOR WHERE rut=emrut AND dv=0
 DELETE #TC14 WHERE rut='97029000' OR rut='97018000'
 DELETE #TC14
 FROM  VIEW_CLIENTE
 WHERE  rut=clRut
 AND NOT (CONVERT(INTEGER,cltipcli) in (1,3))
 UPDATE MDAC SET acint_c14 = '1'
 SELECT rut = isnull(rut,0) ,
   ctacontable ,
   moneda = isnull(moneda,0)    ,
   valor  ,
   fecha  ,
   dv  ,
   tip  ,
   g  ,
   c
 FROM #TC14
 ORDER BY tip,g,c
 SET NOCOUNT OFF
END
-- SP_INTERFAZ_C14
-- delete view_noserie
-- SELECT * FROM CARTERA_CUENTA WHERE Instrumento = 'ICAP'
-- SELECT * FROM CARTERA_CUENTA WHERE t_operacion = 'DICO'
-- select * from MDCI
-- select * from view_cliente where cltipcli=2
-- SELECT CPRUTEMIS FROM MDCP


GO
