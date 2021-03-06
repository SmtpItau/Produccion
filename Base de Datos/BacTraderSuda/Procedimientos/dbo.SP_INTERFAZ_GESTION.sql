USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_GESTION]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_GESTION]
    (
    @dFecha DATETIME
    )
AS
BEGIN 
 SET NOCOUNT ON
 DECLARE @dFecinicio DATETIME ,
  @dFecvcto DATETIME
 SELECT @dFecinicio = CONVERT(DATETIME,STR(DATEPART(YEAR,@dFecha))+REPLACE(STR(DATEPART(MONTH,@dFecha),2),' ','0')+'01')
 SELECT @dFecvcto = DATEADD(DAY,-1,DATEADD(MONTH,1,@dFecinicio))
 SELECT 'codigo_insu' = CONVERT(CHAR(12),' ')  ,
  'tip_oper' = motipoper   ,
  'codigo_inst' = CONVERT(CHAR(10),mocodigo) ,
  'monto'  = CASE WHEN movpresen = 0  THEN movalcomp
     ELSE movpresen
     END ,
--  'monto'  = CASE
--     WHEN CHARINDEX(motipoper,'CP -IB -CI ')>0 THEN movpresen --movalcomp
--     WHEN CHARINDEX(motipoper,'VP -VI -RC -RCA')>0 THEN movpresen --movalven
--     ELSE movalinip
--      END    ,
  'moneda' = CONVERT(CHAR(10),(CASE WHEN motipoper='VI' AND motipopero='CI' THEN (SELECT momonpact from MDMH a WHERE  a.monumoper=b.monumdocu AND a.mocorrela=b.mocorrela) WHEN motipopero IN ('CI') THEN momonpact ELSe momonemi END)),
  'centro' = ISNULL((SELECT clcosto FROM VIEW_CLIENTE WHERE clrut=morutcli AND clcodigo=mocodcli),7110) ,
  'pacto'  = (CASE WHEN motipopero='CI' THEN 'S' ELSE 'N' END) ,
  'inti'  = CASE
     WHEN motipoper='CI' AND momonpact=999 THEN '1'
     WHEN motipoper='CI' AND momonpact<>999 THEN '2'
     ELSE ' '
      END
 INTO #GESTION_TEMP
 FROM MDMH b
 WHERE (mofecpro>=@dFecinicio AND mofecpro<=@dFecvcto) AND motipoper<>'IB'
 INSERT INTO
 #GESTION_TEMP
 SELECT ' '  ,
  'VP'  ,
  rscodigo ,
  rsflujo  ,
  rsmonemi ,
  ISNULL((SELECT clcosto FROM VIEW_CLIENTE WHERE clrut=rsrutcli AND clcodigo=rscodcli),7110),
  'N'  ,
  ' '
 FROM MDRS
 WHERE (rsfecha>=@dFecinicio AND rsfecha<=@dFecvcto) 
 AND  rstipoper = 'VC'
 AND rsvalvenc = 0 -- No Seriados 
 AND NOT(rsinstser in ('ICOL','ICAP'))
 IF @dFecha=(SELECT acfecproc FROM MDAC)
 BEGIN
  INSERT INTO
  #GESTION_TEMP
  SELECT ' '  ,
   'VI'  ,
   vicodigo ,
   vivptirv ,
   CONVERT(CHAR(10),(CASE WHEN vitipoper='CI' THEN (SELECT cimonpact FROM MDCI WHERE  cinumdocu=vinumdocu AND cicorrela=vicorrela) ELSE vimonpact END)) ,
   ISNULL((SELECT clcosto FROM VIEW_CLIENTE WHERE clrut=virutcli AND clcodigo=vicodcli),7110),
   CASE
    WHEN vitipoper='CI' THEN 'S'
    ELSE 'N'
   END  ,
   ' '
  FROM MDVI 
  WHERE vifecinip=@dFecha
  INSERT INTO
  #GESTION_TEMP
  SELECT ' '  ,
   'CI'  ,
   cicodigo ,
   civalcomp ,
   cimonpact ,
   ISNULL((SELECT clcosto FROM VIEW_CLIENTE WHERE clrut=cirutcli AND clcodigo=cicodcli),7110),
   'S'  ,
   CASE
    WHEN cimonpact=999 THEN '1'
    ELSE '2'
   END
  FROM MDCI 
  WHERE cifecinip=@dFecha
  AND NOT (ciinstser IN ('ICAP','ICOL'))
  INSERT INTO
  #GESTION_TEMP
  SELECT ' '  ,
   'CP'  ,
   mocodigo ,
   movalcomp ,
   CASE
    WHEN moseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE morutcart=nsrutcart AND monumdocu=nsnumdocu AND mocorrela=nscorrela)
    ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=mocodigo AND momascara=semascara)
   END ,
   ISNULL((SELECT clcosto FROM VIEW_CLIENTE WHERE clrut=morutcli AND clcodigo=mocodcli),7110),
   ' ' ,
   ' '
  FROM MDMO
  WHERE motipoper = 'CP'
  AND mostatreg <> 'A'
 END
-- Sp_Interfaz_Gestion '20010831'
 UPDATE #GESTION_TEMP
 SET codigo_insu = ISNULL((SELECT codigo FROM GESTION WHERE instrument=moneda AND opera=tip_oper ),' ')
 WHERE pacto='S'
 UPDATE #GESTION_TEMP
 SET codigo_insu = ISNULL((SELECT codigo FROM GESTION WHERE RTRIM(instrument)=RTRIM(codigo_inst) AND opera=tip_oper ),' ')
 WHERE pacto<>'S'
--select count(*) from #GESTION_TEMP
 
--select distinct tip_oper, codigo_inst, pacto from  #GESTION_TEMP  WHERE codigo_insu=' '
 DELETE #GESTION_TEMP WHERE codigo_insu=' '
--select count(*) from #GESTION_TEMP
 IF NOT EXISTS(SELECT * FROM #GESTION_TEMP)
 BEGIN 
--- Preguntar 
--UPDATE MDAC SET acint_ges = '1'
  SELECT 'OK'
  RETURN
 END
 SELECT codigo_insu  ,
  monto     ,
--  centro = ISNULL((CASE WHEN centro=0 THEN '7110' ELSE centro END),'7110'),
  centro ,
  inti
 INTO #temp1
 FROM #GESTION_TEMP
/*
 SELECT codigo_insu  ,
  COUNT(*)  ,
  SUM(monto)
 FROM #TEMP1
 group by codigo_insu
 order by codigo_insu
*/
 UPDATE MDAC SET acint_ges = '1'
 UPDATE #TEMP1
 SET centro = 7110
 WHERE centro = 0
 OR centro = NULL
 SELECT codigo_insu  ,
  monto = SUM(monto) ,
  centro   ,
  cant = COUNT(*) ,
  inti
 FROM #TEMP1
 GROUP BY codigo_insu, centro, inti
 ORDER BY codigo_insu, centro, inti
 SET NOCOUNT OFF
END
-- Sp_Interfaz_Gestion '20010831'
-- select morutcli,mocodcli,* from mdmh where mofecpro = '20010831'
-- select movalcomp,movpresen,moinstser,* from mdmh where motipoper = 'RV'
-- select movalinip,movpresen,* from mdmh where mocodigo = 7 and motipoper IN ('RC','VI','RCA') and movalinip > 900000000 and movalinip < 1100000000
-- select movalinip,movpresen,* from mdmh where monumoper = 47379
-- select ( select SUM(movalinip) from mdmh where mocodigo = 7 and motipoper IN ('RC','VI','RCA') ) + (select SUM(movalinip) from mdmo where mocodigo = 7 and motipoper IN ('RC','VI','RCA'))
-- select * from gestion
-- select * from mdin
-- sp_help gestion
-- select mofecpro,movpresen,movalcomp from mdmh where motipoper = 'CP' and mocodigo = 6 and mostatreg <> 'A'
-- select count(*),sum(movpresen),SUM(movalcomp) from mdmh where motipoper = 'CP' and mocodigo = 6 and mostatreg <> 'A'
--  56.313.069.930,00
-- SP_INTERFAZ_GESTION


GO
