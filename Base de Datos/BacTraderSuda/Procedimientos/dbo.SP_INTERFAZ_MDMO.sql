USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_MDMO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_MDMO]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nNumlin INTEGER
 SELECT 'fecha'   = CONVERT(CHAR(10),acfecproc,103)  ,  -- 1
   'ccosto'  = clcosto        ,  -- 2
   'oficina'  = CASE WHEN moforpagi > 10 THEN moforpagi ELSE 71 END,  -- 3
   'flagd3'  = 'S'         ,  -- 4
   'ejecutivo'  = clejecuti        ,  -- 5
   'rutcli'  = morutcli        ,  -- 6
   'dv'    = cldv         ,  -- 6
   'nomcli'  = SUBSTRING(clnombre,1,40)    ,  -- 7
   'numoper'  = monumoper        ,  -- 8
   'correla'  = mocorvent        ,
   'tipocuenta'  = 'P'         ,  -- 9
   'ctactble'  = ctacontable       ,  -- 10
   'monto'   = movalinip        ,  -- 11
   'signo'   = '+'         ,  -- 12
   'montoum'  = CASE
         WHEN momonpact=999 THEN movalinip
         ELSE ROUND(movalinip/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecinip),4)
       END         ,  -- 13
   'signoum'  = '+'         ,  -- 14
   'tasa'   = motaspact        ,  -- 15
   'moneda'  = momonpact       ,  -- 16
   'plazo'   = DATEDIFF(DAY,mofecinip,mofecvenp)  ,  -- 17
   'sistema'  = 'MD'         ,  -- 18
   'numlin'  = 0         ,  -- 19
   'fecinip'  = CONVERT(CHAR(10),mofecinip,103)  ,  -- 20
   'fecvenp'  = CONVERT(CHAR(10),mofecvenp,103)  ,  -- 21
   'ctactblerenta' = 0         ,  -- 22
   'error'   = 0         ,  -- 23
   'flagtipoper'  = 'N'         ,  -- 24
   'tipotasa'  = '1'         ,  -- 25
   'basfluct'  = 0         ,  -- 26
   'plztasa'  = CASE 
         WHEN DATEDIFF(DAY,mofecinip,mofecvenp)<30 THEN 1
         WHEN DATEDIFF(DAY,mofecinip,mofecvenp)>29 AND DATEDIFF(DAY,mofecinip,mofecvenp)<90 THEN 2
         WHEN DATEDIFF(DAY,mofecinip,mofecvenp)>89 AND DATEDIFF(MONTH,mofecinip,mofecvenp)<6 THEN 3
         WHEN DATEDIFF(MONTH,mofecinip,mofecvenp)>6 AND DATEDIFF(YEAR,mofecinip,mofecvenp)<1 THEN 4
         WHEN DATEDIFF(YEAR,mofecinip,mofecvenp)>1 AND DATEDIFF(YEAR,mofecinip,mofecvenp)<3 THEN 5
         ELSE 6
               END         ,  -- 27
   'spread'  = 0         ,  -- 28
   'filler'  = SPACE (26)          -- 29
  INTO #TEMPO
  FROM MDAC, MDMO, VIEW_CLIENTE, CARTERA_CUENTA
  WHERE motipoper='VI'
   AND clrut=morutcli
   AND clcodigo=mocodcli
   AND variable='valor_venta'
   AND mostatreg<>'A'
   AND (monumdocu=numdocu AND monumoper=numoper AND mocorrela=correla)
   AND t_movimiento='MOV'
   AND t_operacion='VI'
   AND moforpagi<>10
   AND morutcli<>97023000
 INSERT INTO
  #TEMPO
  SELECT CONVERT(CHAR(10),acfecproc,103)  ,
    clcosto        ,
    CASE WHEN moforpagi > 10 THEN moforpagi ELSE 71 END,
    'S'        ,
    clejecuti       ,
    morutcli       ,
    cldv        ,
    SUBSTRING(clnombre,1,40)   ,
    monumoper       ,
    mocorrela       ,
    'A'        ,
    ctacontable       ,
    movalcomp       ,
    '+'        ,
    CASE
      WHEN momonpact=999 THEN movalinip 
      ELSE ROUND(movalinip/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecinip),4)
    END        ,
    '+'        ,
    motaspact       ,
    momonpact       ,
    DATEDIFF(DAY,mofecinip,mofecvenp) ,
    'MD'        ,
    0         ,  -- 19
    CONVERT(CHAR(10),mofecinip,103)  ,
    CONVERT(CHAR(10),mofecvenp,103)  ,
    0         ,
    0         ,
    'N'        ,
    '1'        ,
    0         ,
    CASE 
      WHEN DATEDIFF(DAY,mofecinip,mofecvenp)<30 THEN 1
      WHEN DATEDIFF(DAY,mofecinip,mofecvenp)>29 AND DATEDIFF(DAY,mofecinip,mofecvenp)<90 THEN 2
      WHEN DATEDIFF(DAY,mofecinip,mofecvenp)>89 AND DATEDIFF(MONTH,mofecinip,mofecvenp)<6 THEN 3
      WHEN DATEDIFF(MONTH,mofecinip,mofecvenp)>6 AND DATEDIFF(YEAR,mofecinip,mofecvenp)<1 THEN 4
      WHEN DATEDIFF(YEAR,mofecinip,mofecvenp)>1 AND DATEDIFF(YEAR,mofecinip,mofecvenp)<3 THEN 5
     ELSE 6
    END        ,
    0         ,
    SPACE (26)
   FROM MDAC, MDMO, VIEW_CLIENTE, CARTERA_CUENTA
   WHERE motipoper='CI'
   AND clrut=morutcli
   AND clcodigo=mocodcli
   AND variable='valor_compra'
   AND mostatreg<>'A'
   AND (monumdocu=numdocu AND monumoper=numoper AND mocorrela=correla)
   AND t_movimiento='MOV'
   AND t_operacion='CI'
   AND moforpagi<>10
   AND morutcli<>97023000
 INSERT INTO
 #TEMPO
 SELECT CONVERT(CHAR(10),acfecproc,103)    ,
   clcosto           ,
   CASE WHEN moforpagi > 10 THEN moforpagi ELSE 71 END ,
   'S'           ,
   clejecuti        ,
   morutcli          ,
   cldv           ,
   SUBSTRING(clnombre,1,40)         ,
   monumoper          ,
   mocorrela          ,
   CASE WHEN mocodigo = 992 THEN 'A' ELSE 'P' END  ,
   ctacontable          ,
   movalcomp          ,
   '+'           ,
   CASE
     WHEN momonpact=999 THEN movalinip
     ELSE ROUND(movalinip/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecinip),4)
   END           ,
   '+'           ,
   motaspact          ,
   momonpact          ,
   DATEDIFF(DAY,mofecinip,mofecvenp)    ,
   'MD'           ,
   0            ,  -- 19
   CONVERT(CHAR(10),mofecinip,103)     ,
   CONVERT(CHAR(10),mofecvenp,103)     ,
   0            ,
   0            ,
   'N'           ,
   '1'           ,
   0            ,
   CASE 
     WHEN DATEDIFF(DAY,mofecinip,mofecvenp)<30 THEN 1
     WHEN DATEDIFF(DAY,mofecinip,mofecvenp)>29 AND DATEDIFF(DAY,mofecinip,mofecvenp)<90 THEN 2
     WHEN DATEDIFF(DAY,mofecinip,mofecvenp)>89 AND DATEDIFF(MONTH,mofecinip,mofecvenp)<6 THEN 3
     WHEN DATEDIFF(MONTH,mofecinip,mofecvenp)>6 AND DATEDIFF(YEAR,mofecinip,mofecvenp)<1 THEN 4
     WHEN DATEDIFF(YEAR,mofecinip,mofecvenp)>1 AND DATEDIFF(YEAR,mofecinip,mofecvenp)<3 THEN 5
    ELSE 6
   END           ,
   0            ,
   SPACE (26)
  FROM MDAC, MDMO, VIEW_CLIENTE, CARTERA_CUENTA
  WHERE motipoper='IB'
  AND clrut=morutcli
  AND clcodigo=mocodcli
  AND variable='valor_compra'
  AND mostatreg<>'A'
  AND moforpagi<>10
  AND morutcli<>97023000
 AND (monumdocu=numdocu AND monumoper=numoper AND mocorrela=correla)
  AND t_movimiento='MOV'
  AND t_operacion='CP'
  AND momonemi <> 994
 SELECT @nNumlin = COUNT(*) FROM #TEMPO
 UPDATE #TEMPO
  SET numlin = @nNumlin
 UPDATE #TEMPO
  SET ccosto = 2115
  WHERE ccosto = 0
 UPDATE MDAC SET acint_d3 = '1'
  IF @nNumlin=0
    SELECT 'NO', 'No Existen Datos'
  ELSE
  SELECT fecha    ,
   ccosto    ,
   oficina    ,
   flagd3    ,
   ejecutivo   ,
   rutcli    ,
   nomcli    ,
   numoper    ,
   tipocuenta   , 
   ctactble   ,
   SUM(monto)   ,
   signo     ,
   SUM(montoum)   ,
   signoum    ,
   tasa     ,
   moneda    ,
   plazo     ,
   sistema    ,
   numlin    ,
   fecinip    ,
   fecvenp    ,
   ctactblerenta   ,
   error     ,
   flagtipoper   ,
   tipotasa   ,
   basfluct   ,
   plztasa    ,
   spread    ,
   filler    ,
   correla    ,
   dv
  FROM #TEMPO
  GROUP BY
   fecha  ,
   ccosto  ,
   oficina  ,
   flagd3  ,
   ejecutivo ,
   rutcli  ,
   nomcli  ,
   numoper  ,
   correla  ,
   tipocuenta ,
   ctactble ,
   signo  ,
   signoum  ,
   tasa  ,
   moneda  ,
   plazo  ,
   sistema  ,
   numlin  ,
   fecinip  ,
   fecvenp  ,
   ctactblerenta ,
   error  ,
   flagtipoper ,
   tipotasa ,
   basfluct ,
   plztasa  ,
   spread  ,
   filler  ,
   dv
  ORDER BY rutcli
 SET NOCOUNT OFF
END
-- Sp_Interfaz_Mdmo
-- select * from mdmo where motipoper = 'IB'
-- select clcosto,clejecuti,* from VIEW_CLIENTE where clrut = 97042000
-- select clcosto,clejecuti,* from VIEW_CLIENTE where clrut = 97043000
-- select * from mdmo
-- select * from CARTERA_CUENTA where t_operacion = 'IB'
-- select * from view_plan_de_cuenta where cta_sbif <> ''
-- sp_Help view_plan_de_cuenta 
-- select * from  CARTERA_CUENTA where NumOper=47804
-- select * from mdci where cirutcli = 97042000
-- select * from mdvi where virutcli = 97042000
-- select * from mdci where cirutcli = 8946890
-- sp_help
-- select motipoper,moinstser,moforpagi,morutcli,mostatreg,* from mdmo
--
-- update view_cliente set clcosto = clcencos from mdcl where view_cliente.clrut = mdcl.clrut 
-- sp_autoriza_ejecutar 'BACUSER'
--3115620109
--3115621806
--update mdac set acsw_mesa = '0'
-- sp_Helptext sp_fdia
/*
update view_plan_de_cuenta set cta_sbif = ''
update view_plan_de_cuenta set cta_sbif = 430010305 where cuenta = 1120180238
update view_plan_de_cuenta set cta_sbif = 430010600 where cuenta = 1120180408
update view_plan_de_cuenta set cta_sbif = 2000036607 where cuenta = 1695520405
update view_plan_de_cuenta set cta_sbif = 2001002309 where cuenta = 1695520510
update view_plan_de_cuenta set cta_sbif = 2150020102 where cuenta = 1725580203
update view_plan_de_cuenta set cta_sbif = 2150020210 where cuenta = 1725580416
update view_plan_de_cuenta set cta_sbif = 2150020407 where cuenta = 1725580532
update view_plan_de_cuenta set cta_sbif = 430010109 where cuenta = 1120180009
update view_plan_de_cuenta set cta_sbif = 1950031104 where cuenta = 1735608114
*/


GO
