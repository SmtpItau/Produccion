USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FORMULARIOD3]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FORMULARIOD3]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @dFecpro DATETIME ,
  @acfecproc CHAR (10) ,
  @acfecprox CHAR (10) ,
  @uf_hoy  FLOAT  ,
  @uf_man  FLOAT  ,
  @ivp_hoy FLOAT  ,
  @ivp_man FLOAT  ,
  @do_hoy  FLOAT  ,
  @do_man  FLOAT  ,
  @da_hoy  FLOAT  ,
  @da_man  FLOAT  ,
  @acnomprop CHAR (40) ,
  @rut_empresa CHAR (12) ,
  @hora  CHAR (08)
 CREATE TABLE
 #TEMP1
  (
  Plazo INTEGER,
  Glosa CHAR(25),
  monto FLOAT ,
  tasa FLOAT ,
  Oper CHAR
  )
 CREATE TABLE
 #RESULTADO
  (
  banda_act INTEGER  ,
  plazo_act CHAR (22) ,
  glosa_act CHAR (25) ,
  cont_act INTEGER  ,
  mont_act FLOAT  ,
  min_act  FLOAT  ,
  max_act  FLOAT  ,
  prom_act FLOAT  ,
  banda_pas INTEGER  ,
  plazo_pas CHAR (22) ,
  glosa_pas CHAR (25) ,
  cont_pas INTEGER  ,
  mont_pas FLOAT  ,
  min_pas  FLOAT  ,
  max_pas  FLOAT  ,
  prom_pas FLOAT
  )
 SELECT 'acfecproc' = acfecproc  ,
  'acfecprox' = acfecprox  ,
  'UF_Hoy' = CONVERT(FLOAT,0) ,
  'UF_Man' = CONVERT(FLOAT,0) ,
  'IVP_Hoy' = CONVERT(FLOAT,0) ,
  'IVP_Man' = CONVERT(FLOAT,0) ,
  'DO_Hoy' = CONVERT(FLOAT,0) ,
  'DO_Man' = CONVERT(FLOAT,0) ,
  'DA_Hoy' = CONVERT(FLOAT,0) ,
  'DA_Man' = CONVERT(FLOAT,0) ,
  'acnomprop' = acnomprop  ,
  'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop))+ '-'+acdigprop,
  'hora'  = CONVERT(VARCHAR(30),GETDATE(),108)
 INTO #PARAMETROS
 FROM MDAC
  
 UPDATE #PARAMETROS
 SET uf_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA 
 WHERE vmfecha=acfecproc AND vmcodigo=998
 UPDATE #PARAMETROS
 SET uf_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecprox AND vmcodigo=998
 UPDATE #PARAMETROS
 SET ivp_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecproc AND vmcodigo=997
 UPDATE #PARAMETROS
 SET ivp_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA 
 WHERE vmfecha=acfecprox AND vmcodigo=997
 UPDATE #PARAMETROS
 SET do_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA 
 WHERE vmfecha=acfecproc AND vmcodigo=994
 UPDATE #PARAMETROS
 SET do_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA 
 WHERE vmfecha=acfecprox AND vmcodigo=994
 UPDATE #PARAMETROS
 SET da_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA 
 WHERE vmfecha=acfecproc AND vmcodigo=995
 UPDATE #PARAMETROS
 SET da_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA 
 WHERE vmfecha=acfecprox AND vmcodigo=995
 SELECT @acfecproc = CONVERT(CHAR(10),acfecproc,103)  ,
  @acfecprox = CONVERT(CHAR(10),acfecprox,103)  ,
  @uf_hoy  = uf_hoy     ,
  @uf_man  = uf_man     ,
  @ivp_hoy = ivp_hoy     ,
  @ivp_man = ivp_man     ,
  @do_hoy  = do_hoy     ,
  @do_man  = do_man     ,
  @da_hoy  = da_hoy     ,
  @da_man  = da_man     ,
  @acnomprop = acnomprop     ,
  @rut_empresa = rut_empresa     ,
  @hora  = hora
 FROM #PARAMETROS
 SELECT @dFecpro = acfecproc
 FROM MDAC
 --** Menos de 30 dias Activos
 INSERT INTO #TEMP1 SELECT 1, 'INTERBANCARIA NO REAJ.',movalcomp,motir,'A'
 FROM MDMO WHERE moinstser='ICOL' AND momonemi=999 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
--aND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
--((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5))
 INSERT INTO #TEMP1 SELECT 1, 'INTERBANCARIA REAJ.U.F',movalcomp,motir,'A'
 FROM MDMO WHERE moinstser='ICOL' AND momonemi=998 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
--AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 1, 'INTERBANCARIA REAJ. T.C',movalcomp,motir,'A'
 FROM MDMO WHERE moinstser='ICOL' AND momonemi=994 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 1, 'INTERBANCARIA EN US$',movalcomp,motir,'A'
 FROM MDMO WHERE moinstser='ICOL' AND momonemi=13 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 1, 'OPERACIONES NO REAJ.',movalcomp,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<30 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 1, 'OPERACIONES REAJ. U.F.',movalcomp,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<30 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 1, 'OPERACIONES REAJ. T.C.',movalcomp,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<30 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 1, 'OPERACIONES EN US$',movalcomp,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** Menos de 30 dias Pasivos
 INSERT INTO #TEMP1 SELECT 1, 'INTERBANCARIA NO REAJ.',movalcomp,motir,'P'
 FROM MDMO WHERE moinstser='ICAP' AND momonemi=999 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 1, 'INTERBANCARIA REAJ.U.F',movalcomp,motir, 'P'
 FROM MDMO WHERE moinstser='ICAP' AND momonemi=998 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 1, 'INTERBANCARIA REAJ. T.C',movalcomp,motir,'P'
 FROM MDMO WHERE moinstser='ICAP' AND momonemi=994 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 1, 'INTERBANCARIA EN US$',movalcomp,motir,'P'
 FROM MDMO WHERE moinstser='ICAP' AND momonemi=13 AND DATEDIFF(DAY,@dFecpro,mofecven)<30 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 1, 'OPERACIONES NO REAJ.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<30 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 1, 'OPERACIONES REAJ. U.F.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI'AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<30 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 1, 'OPERACIONES REAJ. T.C.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<30 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 1, 'OPERACIONES EN US$',movalinip,motaspact,'P'
 FROM MDMO WHERE  motipoper='VI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<30 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** de 30 a 90 dias Activos
 INSERT INTO #TEMP1 SELECT 2, 'INTERBANCARIA NO REAJ.',movalcomp,motir,'A'
 FROM MDMO WHERE moinstser='ICOL' AND momonemi=999 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecven)<90 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 2, 'INTERBANCARIA REAJ.U.F', movalcomp,motir,'A'
 FROM MDMO WHERE moinstser='ICOL' AND momonemi=998 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecven)<90 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 2, 'INTERBANCARIA REAJ. T.C',movalcomp,motir,'A'
 FROM MDMO WHERE moinstser='ICOL' AND momonemi=994 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecven)<90 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 2, 'INTERBANCARIA EN US$',movalcomp,motir,'A'
 FROM MDMO WHERE moinstser='ICOL' AND momonemi=13 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecven)<90 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 2, 'OPERACIONES NO REAJ.',movalcomp,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<90 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 2, 'OPERACIONES REAJ. U.F.',movalcomp,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<90 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 2, 'OPERACIONES REAJ. T.C.',movalcomp,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<90 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 2, 'OPERACIONES EN US$',movalcomp,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecven)<90 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** de 30 a 90 dias Pasivos
 INSERT INTO #TEMP1 SELECT 2, 'INTERBANCARIA NO REAJ.',movalcomp,motir,'P'
 FROM MDMO WHERE moinstser = 'ICAP' AND momonemi=999 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecven)<90 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 2, 'INTERBANCARIA REAJ.U.F',movalcomp,motir,'P'
 FROM MDMO WHERE moinstser = 'ICAP' AND momonemi=998 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecven)<90 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 2, 'INTERBANCARIA REAJ. T.C',movalcomp,motir,'P'
 FROM MDMO WHERE moinstser = 'ICAP' AND momonemi=994 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecven)<90 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 2, 'INTERBANCARIA EN US$',movalcomp,motir,'P'
 FROM MDMO WHERE moinstser = 'ICAP' AND momonemi=13 AND DATEDIFF(DAY,@dFecpro,mofecven)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<90 AND mostatreg=''
-- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) AND morutcli<>97029000
 AND ((moforpagi = 4 OR moforpagi = 5) OR (moforpagv = 4 OR moforpagv = 5)) AND morutcli<>97029000
 INSERT INTO #TEMP1 SELECT 2, 'OPERACIONES NO REAJ.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper ='VI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<90 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 2, 'OPERACIONES REAJ. U.F.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper ='VI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<90 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 2, 'OPERACIONES REAJ. T.C.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper ='VI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<90 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 2, 'OPERACIONES EN US$',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper ='VI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<90 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** de 90 a 1 año Activos
 INSERT INTO #TEMP1 SELECT 3, 'OPERACIONES NO REAJ.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp) >= 90 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<365 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 3, 'OPERACIONES REAJ. U.F.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<365 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 3, 'OPERACIONES REAJ. T.C.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<365 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 3, 'OPERACIONES EN US$',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<365 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** de 90 a 1 año Pasivos
 INSERT INTO #TEMP1 SELECT 3, 'OPERACIONES NO REAJ.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp) >= 90 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<365 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 3, 'OPERACIONES REAJ. U.F.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<365 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 3, 'OPERACIONES REAJ. T.C.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<365 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 3, 'OPERACIONES EN US$',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=30 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<365 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** de 1 año a 3 años Activos
 INSERT INTO #TEMP1 SELECT 4, 'OPERACIONES NO REAJ.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=365 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 4, 'OPERACIONES REAJ. U.F.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=365 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 4, 'OPERACIONES REAJ. T.C.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=365 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 4, 'OPERACIONES EN US$',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=365 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** de 1 año a 3 años Pasivos
 INSERT INTO #TEMP1 SELECT 4, 'OPERACIONES NO REAJ.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=365 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 4, 'OPERACIONES REAJ. U.F.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=365 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 4, 'OPERACIONES REAJ. T.C.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=365 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 4, 'OPERACIONES EN US$',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=365 AND DATEDIFF(DAY,@dFecpro,mofecvenp)<1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** de mas de 3 años Pasivos
 INSERT INTO #TEMP1 SELECT 5, 'OPERACIONES NO REAJ.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 5, 'OPERACIONES REAJ. U.F.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 5, 'OPERACIONES REAJ. T.C.',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 5, 'OPERACIONES EN US$',movalinip,motaspact,'A'
 FROM MDMO WHERE motipoper='CI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>=1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 --** de mas de 3 años Activos
 INSERT INTO #TEMP1 SELECT 5, 'OPERACIONES NO REAJ.',movalinip,motaspact, 'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=999 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 5, 'OPERACIONES REAJ. U.F.',movalinip,motaspact,'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=998 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 5, 'OPERACIONES REAJ. T.C.',movalinip,motaspact, 'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=994 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 INSERT INTO #TEMP1 SELECT 5, 'OPERACIONES EN US$',movalinip,motaspact, 'P'
 FROM MDMO WHERE motipoper='VI' AND momonpact=13 AND DATEDIFF(DAY,@dFecpro,mofecvenp)>1095 AND mostatreg=''
 AND morutcli<>97029000
---- AND ((moforpagi=4 AND moforpagv=4) OR (moforpagi=5 AND moforpagv=5)) 
 SELECT  Plazo      , 
  Glosa      , 
  'Imonto' = SUM(monto)   , 
  'Itasmin' = MIN(tasa)   , 
  'Itasmax' = MAX(tasa)   , 
  'Itaspon' = SUM(tasa*monto)/SUM(monto) ,
   Oper
 INTO #TEMP2 
 FROM #TEMP1
 GROUP BY Plazo, Glosa, Oper
 --** MENOS DE 30 DIAS
 INSERT INTO #RESULTADO SELECT 1,'Menos De 30 días', 'INTERBANCARIA NO REAJ.',1,0,0,0,0,1,'Menos DE 30 días','INTERBANCARIA NO REAJ.',1,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , 'INTERBANCARIA REAJ.U.F',2,0,0,0,0,1,'Menos DE 30 días','INTERBANCARIA REAJ.U.F',2,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , 'INTERBANCARIA REAJ. T.C',3,0,0,0,0,1,'Menos DE 30 días','INTERBANCARIA REAJ. T.C',3,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , 'INTERBANCARIA EN US$',4,0,0,0,0,1,'Menos DE 30 días','INTERBANCARIA EN US$',4,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , 'OPERACIONES NO REAJ.',5,0,0,0,0,1,'Menos DE 30 días','OPERACIONES NO REAJ.',5,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , 'OPERACIONES REAJ. U.F.',6,0,0,0,0,1,'Menos DE 30 días','OPERACIONES REAJ. U.F.',6,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , 'OPERACIONES REAJ. T.C.',7,0,0,0,0,1,'Menos DE 30 días','OPERACIONES REAJ. T.C.',7,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , 'OPERACIONES EN US$',8,0,0,0,0,1,'Menos DE 30 días','OPERACIONES EN US$',8,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , '',9,0,0,0,0,1,'Menos DE 30 días','',9,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , '',10,0,0,0,0,1,'Menos DE 30 días','',10,0,0,0,0
 INSERT INTO #RESULTADO SELECT 1,''                , '',11,0,0,0,0,1,'Menos DE 30 días','',11,0,0,0,0
 --** DE 30 A 90 DIAS
 INSERT INTO #RESULTADO SELECT 2,'De 30 A 90 Días', 'INTERBANCARIA NO REAJ.',12,0,0,0,0,2,'De 30 A 90 Días','INTERBANCARIA NO REAJ.',12,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''               , 'INTERBANCARIA REAJ. U.F.',13,0,0,0,0,2,'De 30 A 90 Días','INTERBANCARIA REAJ. U.F.',13,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , 'INTERBANCARIA REAJ. T.C.',14,0,0,0,0,2,'De 30 A 90 Días','INTERBANCARIA REAJ. T.C.',14,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , 'INTERBANCARIA EN US$',15,0,0,0,0,2,'De 30 A 90 Días','INTERBANCARIA EN US$',15,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , 'OPERACIONES NO REAJ..',16,0,0,0,0,2,'De 30 A 90 Días','OPERACIONES NO REAJ.',16,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , 'OPERACIONES REAJ. U.F.',17,0,0,0,0,2,'De 30 A 90 Días','OPERACIONES REAJ. U.F.',17,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , 'OPERACIONES REAJ. T.C.',18,0,0,0,0,2,'De 30 A 90 Días','OPERACIONES REAJ. T.C.',18,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , 'OPERACIONES EN US$',19,0,0,0,0,2,'De 30 A 90 Días','OPERACIONES EN US$',19,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , '',20,0,0,0,0,2,'De 30 A 90 Días','',20,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , '',21,0,0,0,0,2,'De 30 A 90 Días','',21,0,0,0,0
 INSERT INTO #RESULTADO SELECT 2,''   , '',22,0,0,0,0,2,'De 30 A 90 Días','',22,0,0,0,0
 --** de 90 a 1 año
 INSERT INTO #RESULTADO SELECT 3,'De 90 A 1 Año' , 'OPERACIONES NO REAJ.',23,0,0,0,0,3,'De 90 A 1 Año','OPERACIONES NO REAJ.',23,0,0,0,0
 INSERT INTO #RESULTADO SELECT 3,''  , 'OPERACIONES REAJ. U.F.',24,0,0,0,0,3,'De 90 A 1 Año','OPERACIONES REAJ. U.F.',24,0,0,0,0
 INSERT INTO #RESULTADO SELECT 3,''  , 'OPERACIONES REAJ. T.C.',25,0,0,0,0,3,'De 90 A 1 Año','OPERACIONES REAJ. T.C.',25,0,0,0,0
 INSERT INTO #RESULTADO SELECT 3,''  , 'OPERACIONES EN US$',26,0,0,0,0,3,'De 90 A 1 Año','OPERACIONES EN US$',26,0,0,0,0
 INSERT INTO #RESULTADO SELECT 3,''  , '',27,0,0,0,0,3,'De 90 A 1 Año','',27,0,0,0,0
 INSERT INTO #RESULTADO SELECT 3,''  , '',28,0,0,0,0,3,'De 90 A 1 Año','',28,0,0,0,0
 INSERT INTO #RESULTADO SELECT 3,''  , '',29,0,0,0,0,3,'De 90 A 1 Año','',29,0,0,0,0
 --** de 1 año a 3 años
 INSERT INTO #RESULTADO SELECT 4,'De 1 Año a 3 años', 'OPERACIONES NO REAJ.',30,0,0,0,0,4,'De 1 Año a 3 años','OPERACIONES NO REAJ.',30,0,0,0,0
 INSERT INTO #RESULTADO SELECT 4,''     , 'OPERACIONES REAJ. U.F.',31,0,0,0,0,4,'De 1 Año a 3 años','OPERACIONES REAJ. U.F.',31,0,0,0,0
 INSERT INTO #RESULTADO SELECT 4,''     , 'OPERACIONES REAJ. T.C.',32,0,0,0,0,4,'De 1 Año a 3 años','OPERACIONES REAJ. T.C.',32,0,0,0,0
 INSERT INTO #RESULTADO SELECT 4,''     , 'OPERACIONES EN US$',33,0,0,0,0,4,'De 1 Año a 3 años','OPERACIONES EN US$',33,0,0,0,0
 INSERT INTO #RESULTADO SELECT 4,''     , '',34,0,0,0,0,4,'De 1 Año a 3 años','',34,0,0,0,0
 INSERT INTO #RESULTADO SELECT 4,''     , '',35,0,0,0,0,4,'De 1 Año a 3 años','',35,0,0,0,0
 INSERT INTO #RESULTADO SELECT 4,''     , '',36,0,0,0,0,4,'De 1 Año a 3 años','',36,0,0,0,0
 --** mas de 3 años
 INSERT INTO #RESULTADO SELECT 5,'Más De 3 años' , 'OPERACIONES NO REAJ.',37,0,0,0,0,5,'Más De 3 años','OPERACIONES NO REAJ.',37,0,0,0,0
 INSERT INTO #RESULTADO SELECT 5,''  , 'OPERACIONES REAJ. U.F.',38,0,0,0,0,5,'Más De 3 años','OPERACIONES REAJ. U.F.',38,0,0,0,0
 INSERT INTO #RESULTADO SELECT 5,''  , 'OPERACIONES REAJ. T.C.',39,0,0,0,0,5,'Más De 3 años','OPERACIONES REAJ. T.C.',39,0,0,0,0
 INSERT INTO #RESULTADO SELECT 5,''  , 'OPERACIONES EN US$',40,0,0,0,0,5,'Más De 3 años','OPERACIONES EN US$',40,0,0,0,0
 INSERT INTO #RESULTADO SELECT 5,''  , '',41,0,0,0,0,5,'Más De 3 años','',41,0,0,0,0
 INSERT INTO #RESULTADO SELECT 5,''  , '',42,0,0,0,0,5,'Más De 3 años','',42,0,0,0,0
 INSERT INTO #RESULTADO SELECT 5,''  , '',43,0,0,0,0,5,'Más De 3 años','',43,0,0,0,0
 UPDATE #RESULTADO
 SET mont_act = Imonto ,
  min_act  = Itasmin ,
  max_act  = Itasmax ,
  prom_act  = Itaspon
 FROM #TEMP2
 WHERE banda_act=plazo AND glosa_act=glosa AND oper='A'
 UPDATE #RESULTADO
 SET mont_pas = Imonto ,
  min_pas  = Itasmin ,
  max_pas  = Itasmax ,
  prom_pas = Itaspon
 FROM #TEMP2
 WHERE  banda_pas=plazo AND glosa_pas=glosa AND oper='P'
 SELECT banda_act    ,
  plazo_act    ,
  glosa_act    ,
  cont_act    ,
  'mont_act' = ROUND(mont_act/1000,2),
  min_act     ,
  max_act     ,
  prom_act    ,
  banda_pas    ,
  plazo_pas    ,
  glosa_pas    ,
  cont_pas    ,
  'mont_pas' = ROUND(mont_pas/1000,2),
  min_pas     ,
  max_pas     ,
  prom_pas    ,
  'acfecproc' = @acfecproc  ,
  'hora'  = @hora   ,
  'entidad' = acnomprop
 FROM #RESULTADO, mdac 
 SET NOCOUNT OFF
END
-- sp_autoriza_ejecutar 'bacuser'
-- Sp_FormularioD3
-- select * from mdmo WHERE  motipoper='CI'
-- select vmfecha,vmvalor from view_valor_moneda where vmcodigo=433 and vmfecha>'20000101'
-- select vmfecha,vmvalor from view_valor_moneda where vmcodigo=432 and vmfecha>'20000101'
-- select vmfecha,vmvalor from view_valor_moneda where vmcodigo=431 and vmfecha>'20000101'
-- select * from view_serie where semascara='PTF-4'
-- select * from view_forma_de_pago
-- DELETE mdmo



GO
