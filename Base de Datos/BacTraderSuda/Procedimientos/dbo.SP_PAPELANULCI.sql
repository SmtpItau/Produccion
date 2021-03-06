USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELANULCI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAPELANULCI]
          (@nRutcart NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @cTipoImp CHAR(01) )
AS
BEGIN
SET NOCOUNT ON
 DECLARE @Tipcart CHAR (25) ,
  @nDiaSem INTEGER  ,
  @nDia  INTEGER  ,
  @nMes  INTEGER  ,
  @nAnn  INTEGER  ,
  @cFecEmi CHAR (40) ,
  @cFecVen CHAR (40) ,
  @Forpai  CHAR (25) ,
  @Forpav  CHAR (25) ,
  @Tipocli CHAR (25) ,
  @Tipcli  NUMERIC (05) ,
  @Cust  CHAR (01) ,
  @Custodia CHAR (25) ,
  @Rutcli  NUMERIC (9,0) ,
  @Dig  CHAR (01) ,
  @Codcli  NUMERIC (9,0) ,
  @Nomcli  CHAR (40) ,
  @Comcli  CHAR (25) ,
  @Dircli  CHAR (40) ,
  @Foncli  CHAR (15) ,
  @Faxcli  CHAR (15) ,
  @Nomoper CHAR (40) ,
  @Ret  CHAR (01) ,
  @Retiro  CHAR (15) ,
  @nRutcar NUMERIC (09,0) ,
  @nomemp  CHAR (40) ,
  @rutpro  CHAR (12) ,
  @comemp  CHAR (25) ,
  @Diremp  CHAR (40) ,
  @fecpro  CHAR (10) ,
  @Totalc  NUMERIC (19,2) ,
  @Totalv  NUMERIC (19,2) ,
  @monpac  CHAR (05) ,
  @monpacto NUMERIC (03,0) ,
  @monglo  CHAR (20) ,
  @mtoesc  CHAR (170) ,
  @Obser  CHAR (60) ,
  @valmon  NUMERIC (19,4) ,
  @NumSol  NUMERIC (9,0) ,
  @linea1  CHAR (65) ,
  @linea2  CHAR (65) ,
  @linea3  CHAR (65) ,
  @linea4  CHAR (65) ,
  @linea5  CHAR (65) ,
  @glocopia CHAR (25) ,
  @nCopia  INTEGER         ,
  @Pagina  INTEGER  ,
  @nTotPagina INTEGER  ,
  @contador NUMERIC (19,0) ,
  @contador2 NUMERIC (19,0) ,
  @hora  CHAR(8)  ,
  @cSettlement CHAR(50) ,
  @cPFE  CHAR(50) ,
  @cCCE  CHAR(50) ,
  @cEmisorInstPlazo CHAR(255)
 SELECT @glocopia = '.'
 IF @cTipoImp='P'
  SELECT @nTotPagina = 12
 ELSE
  SELECT @nTotPagina = 10
 SELECT @Totalc  = SUM(movalinip) ,
  @Totalv  = SUM(movalvenp)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CI' AND mostatreg='A'
 SELECT @tipcart = tbglosa 
 FROM VIEW_TABLA_GENERAL_DETALLE, MDMO
 WHERE tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)=motipcart AND monumoper=@nNumoper AND morutcart=@nRutcart AND
  motipoper='CI' AND mostatreg='A'
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecinip) ,
  @nDia  = DATEPART(DAY,mofecinip) ,
  @nMes  = DATEPART(MONTH,mofecinip) ,
  @nAnn  = DATEPART(YEAR,mofecinip)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CI' AND mostatreg='A'
 IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn) 
 IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
 IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '  +CONVERT(CHAR(4),@nAnn)
 IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
 IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)
 IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  +@cFecEmi
 IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    +@cFecEmi
 IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   +@cFecEmi
 IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+@cFecEmi
 IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   +@cFecEmi
 IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  +@cFecEmi
 IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   +@cFecEmi
 SELECT @linea2 = ' ' ,
  @linea3 = ' ' ,
  @linea4 = ' '
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecvenp)  ,
  @nDia  = DATEPART(DAY,mofecvenp),
  @nMes  = DATEPART(MONTH,mofecvenp),
  @nAnn  = DATEPART(YEAR,mofecvenp)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CI' AND mostatreg='A'
 IF @nMes= 1 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 2 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 3 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 4 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 5 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Mayo de '      +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 6 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 7 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 8 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
 IF @nMes= 9 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
 IF @nMes=10 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn)
 IF @nMes=11 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
 IF @nMes=12 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)
 IF @nDiaSem=1 SELECT @cFecVen = 'Domingo '  +@cFecVen
 IF @nDiaSem=2 SELECT @cFecVen = 'Lunes '    +@cFecVen
 IF @nDiaSem=3 SELECT @cFecVen = 'Martes '   +@cFecVen 
 IF @nDiaSem=4 SELECT @cFecVen = 'Miercoles '+@cFecVen
 IF @nDiaSem=5 SELECT @cFecVen = 'Jueves '   +@cFecVen
 IF @nDiaSem=6 SELECT @cFecVen = 'Viernes '  +@cFecVen
 IF @nDiaSem=7 SELECT @cFecVen = 'Sabado '   +@cFecVen
 SELECT @Forpai = glosa FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagi --Forma pago c¢digo 1 no existe como forma de pago
            AND monumoper=@nNumoper AND morutcart=@nRutcart AND
  motipoper='CI' AND mostatreg='A'
 SELECT @Forpav = glosa 
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagv --Forma de pago
          AND monumoper=@nNumoper AND morutcart=@nRutcart AND
  motipoper='CI' AND mostatreg='A'
 SELECT @Cust  = mocondpacto ,
  @Obser   = moobserv ,
  @linea1  = moobserv2 ,
  @NumSol  = monsollin ,
  @Rutcli  = morutcli ,
  @Ret  = motipret ,
  @Nomoper = nombre ,
  @hora  = mohora
 FROM MDMO,VIEW_USUARIO
        WHERE monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND  motipoper='CI' 
 AND  mostatreg='A' 
 AND mousuario=SUBSTRING(usuario,1,12)
 IF @Cust='S'
  SELECT @Custodia = 'Con Custodia'
 ELSE
  SELECT @Custodia = 'Sin Custodia'
          
 SELECT @Nomcli = clnombre  ,
  @Dircli = cldirecc  ,
  @Foncli = clfono  ,
  @Faxcli = clfax   ,
  @Codcli = clcodigo  ,
  @Tipcli = cltipcli  ,
  @Dig    = ISNULL(cldv,'')
 FROM VIEW_CLIENTE
 WHERE clrut=@Rutcli
 SELECT @Comcli = ISNULL(view_ciudad_comuna.nom_ciu,'')
 FROM VIEW_CLIENTE, VIEW_CIUDAD_COMUNA
 WHERE clrut=@Rutcli AND view_ciudad_comuna.cod_ciu = clciudad AND view_ciudad_comuna.cod_com=clcomuna
 SELECT @Tipocli = tbglosa 
 FROM VIEW_TABLA_GENERAL_DETALLE
 WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)
 IF @Ret='V'
  SELECT @Retiro = 'Vamos'
 ELSE
  SELECT @Retiro = 'Vienen'
 SELECT @nomemp = ISNULL(acnomprop,'')    ,
  @rutpro = STR(acrutprop)+'-'+acdigprop   ,
  @comemp = ISNULL(accomprop,'')    ,
  @diremp = ISNULL(acdirprop,'')    ,
  @fecpro = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')
 FROM MDAC
 
 SELECT @Monpac  = mnnemo  ,
  @Monpacto  = momonpact  ,
  @monglo  = RTRIM(mnglosa)
 FROM VIEW_MONEDA, MDMO
 WHERE morutcart=@nRutcart AND monumoper=@nNumoper AND motipoper='CI' AND mostatreg='A' AND
  momonpact=mncodmon
 SELECT @valmon = vmvalor
 FROM VIEW_VALOR_MONEDA, MDMO
 WHERE vmcodigo=momonpact AND vmfecha=mofecinip AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='CI' AND mostatreg='A'
 IF @valmon=NULL
  SELECT @valmon = 1
 EXECUTE SP_MONTOESCRITO @TotalC, @Mtoesc OUTPUT
 EXECUTE SP_PAPELETA_LIMITES  'CI'      ,
     @nNumoper     ,
     @cSettlement   OUTPUT  ,
     @cPFE    OUTPUT  ,
     @cEmisorInstPlazo  OUTPUT  ,
     @cCCE
 
 SELECT 'nomemp' = ISNULL(rcnombre,'')     ,
  'rutemp'       = ISNULL(convert(char(10),rcrut),'')   ,
  'fecpro'       = ISNULL(@fecpro,'')     ,
  'tipcart'      = ISNULL(@tipcart,'')     ,
  'fecemision'    = ISNULL(@cFecEmi,'')     ,
         'numoper'      = ISNULL(monumoper,0)     ,
  'totalc'       = ISNULL(ROUND(movalinip/@valmon,4),0)   ,
  'forpai'       = ISNULL(@forpai,'')      ,
  'totalv'       = ISNULL(movalvenp,0)     ,
  'forpav'       = ISNULL(@forpav,'')      ,
  'tasapacto'    = ISNULL(motaspact,0)      ,
  'base'         = ISNULL(mobaspact,0)      ,
  'plazo'         = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)  ,
  'fecvto'       = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')  ,
  'correla'      = ISNULL(mocorrela,0)     ,
  'serie'        = ISNULL(moinstser,'')     ,
  'emisor'       = ISNULL(emgeneric,'')     ,
  'Moneda'       = ISNULL(mnnemo,'')     ,
  'nominal'      = ISNULL(monominal,0)     ,
  'tasa'         = ISNULL(motir,0)     ,
  'total'        = ISNULL(movpresen,0)     ,
  'Custodia' = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END ,
  'tipcli'       = ISNULL(@Tipocli,'')     ,
         'tipret'       = ISNULL(@Retiro,'')     ,
  'rutcli'        = STR(@Rutcli)+'-'+@Dig     ,
  'codcli'       = ISNULL(@Codcli,0)     ,
  'nomcli'      = ISNULL(@Nomcli,'')     ,
  'dircli'       = ISNULL(@Dircli,'')     ,
  'foncli'        = ISNULL(@Foncli,'')     ,
  'faxcli'       = ISNULL(@Faxcli,'')     ,
  'observa'      = ISNULL(@Obser,'')     ,
  'nomope'       = ISNULL(@Nomoper,'')     ,
  'Monpacto' = ISNULL(@monpac,'')     ,
  'Fec_emi' = ISNULL(CONVERT(CHAR(10),mofecemi,103),'')  ,
  'Fec_ven' = ISNULL(CONVERT(CHAR(10),mofecven,103),'')  ,
  'Mtoesc' = ISNULL(SUBSTRING(@mtoesc,1,120),'')   ,
  'Fec_Compra'    = ISNULL(CONVERT(CHAR(10),mofecinip,103),'')  ,
  'sFecven' = ISNULL(@cFecven,'')     ,
  'comcli' = ISNULL(@monglo,'')     ,
  'comemp' = ISNULL(@comemp,'')     ,
  'Diremp' = ISNULL(@diremp,'')     ,
  'Linea1'    = ISNULL(@linea1,'')     ,
  'Linea2'    = ISNULL(@linea2,'')     ,
  'Linea3'    = ISNULL(@linea3,'')     ,
   'Linea4'    = ISNULL(@linea4,'')     ,
  'Linea5'    = ISNULL(@linea5,'')     ,
  'copia'    = ISNULL(@glocopia,'')     ,
  'Pagina' = 0       ,
  'contador'     = ISNULL(mocorrela,0)     ,
  'vvista'     = ISNULL(movvista,0)     ,
  'TotalPag' = 0       ,
  'hora'  = @hora       ,
  'clave_dcv' = moclave_dcv      ,
  'Lim_Settle' = @cSettlement      ,
  'Lim_PFE' = @cPFE       ,
  'Lim_CCE' = @cCCE   
 INTO #TEMP
 FROM 
  MDAC ,
  MDMO ,
  VIEW_EMISOR  MDEM ,
  VIEW_MONEDA ,
  VIEW_ENTIDAD MDRC
 WHERE 
  morutcart=@nRutcart 
 AND monumoper=@nNumoper
 AND motipoper='CI' 
 AND morutcart = rcrut  /* Vbarra Se cambio rccodcar por RCRUT */
 AND mostatreg='A' 
 AND morutemi=emrut 
 AND momonemi=mncodmon
 ORDER BY mocorrela
 SELECT @contador = 0 ,
  @contador2 = 0 ,
  @pagina  = 1
 WHILE @pagina<>0
 BEGIN
  
  SELECT  @tipcart = '*'
  SET ROWCOUNT 1
  SELECT  @tipcart = tipcart ,
   @contador = contador
  FROM #TEMP
  WHERE contador>@contador
  ORDER BY contador
  SET ROWCOUNT 0
  IF @tipcart='*'
   BREAK
   
  SELECT @contador2 = @contador2 + 1
  UPDATE #TMP SET pagina = @pagina WHERE contador=@Contador
  UPDATE #TMP SET TotalPag=@pagina
  IF @contador2=@nTotPagina
   SELECT @pagina  = @pagina + 1 ,
    @contador2 = 0
 END
 SELECT * FROM #TMP
 SET NOCOUNT OFF
 RETURN
END

GO
