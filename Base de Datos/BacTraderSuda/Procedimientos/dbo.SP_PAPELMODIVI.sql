USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELMODIVI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAPELMODIVI]
    (@nRutcart NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @cTipoImp CHAR (01))
AS
BEGIN
SET NOCOUNT ON
 DECLARE @tipcart VARCHAR (25) ,
  @nDiaSem INTEGER  ,
  @nDia  INTEGER  ,
  @nMes  INTEGER  ,
  @nAnn  INTEGER  ,
  @cFecEmi VARCHAR (40) ,
  @Forpac  VARCHAR (20) ,
  @Forpav  VARCHAR (20) ,
  @Tipocli VARCHAR (25) ,
  @Tipcli  NUMERIC (05) ,
  @Cust  VARCHAR (01) ,
  @Custodia VARCHAR (25) ,
  @Rutcli  NUMERIC (9,0) ,
  @Dig  VARCHAR (01) ,
  @Codcli  NUMERIC (9,0) ,
  @Nomcli  VARCHAR (40) ,
  @Dircli  VARCHAR (40) ,
  @Foncli  VARCHAR (15) ,
  @Faxcli  VARCHAR (15) ,
  @Nomoper VARCHAR (40) ,
  @Ret  VARCHAR (01) ,
  @Retiro  VARCHAR (15) ,
  @Totalc  NUMERIC (19,4) ,
  @Totalv  NUMERIC (19,4) ,
  @Monpact CHAR (05) ,
  @monpacto NUMERIC (03,0) ,
  @monglo  CHAR (20) ,
  @Observ  CHAR (70) ,
  @valmon  NUMERIC (19,4) ,
  @nValIniP FLOAT  ,
  @nValVenP FLOAT  ,
  @nMtoVenta FLOAT  ,
  @MtoEsc  VARCHAR (100) ,
  @MtoRecompra FLOAT  ,
  @cFecVen VARCHAR (100) ,
  @comcli  CHAR (20) ,
  @Pagina  INTEGER  ,
  @nTotPagina INTEGER  ,
  @contador NUMERIC (19,0) ,
  @contador2 NUMERIC (19,0) ,
  @NumSol  NUMERIC (9,0) , 
  @linea1  CHAR (70) ,
  @linea2  CHAR (65) ,
  @linea3  CHAR (65) ,
  @linea4  CHAR (65) ,
  @linea5  CHAR (65) ,
  @glocopia CHAR (25) ,
  @nCopia  INTEGER  ,
  @hora  CHAR(8)  ,
  @cSettlement CHAR(50) ,
  @cPFE  CHAR(50) ,
  @cCCE  CHAR(50) ,
  @cEmisorInstPlazo CHAR(255)
 IF @cTipoImp='P'
  SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=@nNumoper
 ELSE
  SELECT @nCopia = paconimp FROM MDPA WHERE panumoper=@nNumoper
 SELECT @glocopia = '.'
 IF @cTipoImp='P'
  SELECT @nTotPagina = 12
 ELSE
  SELECT @nTotPagina = 10
 SELECT @Monpact = ISNULL(mnnemo,'') ,
  @Monpacto = momonpact  ,
  @monglo  = RTRIM(mnglosa) ,
  @hora  = mohora
 FROM MDMO, VIEW_MONEDA
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI' AND
  momonpact=mncodmon
 SELECT @Totalc = SUM(movalinip) ,
  @Totalv = SUM(movalvenp)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI'
 SELECT @tipcart = tbglosa 
 FROM VIEW_TABLA_GENERAL_DETALLE, MDMO
 WHERE tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)= motipcart AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='VI'
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecinip) ,
  @nDia  = DATEPART(DAY,mofecinip) ,
  @nMes  = DATEPART(MONTH,mofecinip) ,
  @nAnn  = DATEPART(YEAR,mofecinip)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI'
 IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
        IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn)
        IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
        IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)
 IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  +@cFecEmi
 IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    +@cFecEmi
 IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   +@cFecEmi
 IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+@cFecEmi
 IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   +@cFecEmi
 IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  +@cFecEmi
 IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   +@cFecEmi
 SELECT @NumSol = monsollin
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI'
 SELECT @linea2 = ' ' ,
  @linea3 = ' ' ,
  @linea4 = ' '
 SELECT @Forpac = tbglosa 
 FROM VIEW_TABLA_GENERAL_DETALLE, MDMO
 WHERE tbcateg=1 AND CONVERT(NUMERIC(6),tbcodigo1)=moforpagi --forma de pago
          AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='VI'
 SELECT @Forpav = tbglosa 
 FROM VIEW_TABLA_GENERAL_DETALLE, MDMO
 WHERE tbcateg=1 AND CONVERT(NUMERIC(6),tbcodigo1)=moforpagv --forma de pago
          AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='VI'
 SELECT @Cust  = ISNULL(mocondpacto,'')  ,
  @Observ  = moobserv   ,
  @linea1  = moobserv2   ,
  @Ret  = motipret   ,
  @nDiaSem = DATEPART(WEEKDAY,mofecvenp) ,
  @nDia  = DATEPART(DAY,mofecvenp) ,
  @nMes  = DATEPART(MONTH,mofecvenp) ,
  @nAnn  = DATEPART(YEAR,mofecvenp) ,
  @Rutcli  = morutcli   ,
  @Nomoper = nombre
 FROM MDMO, VIEW_USUARIO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI' AND
  mousuario=SUBSTRING(usuario,1,12) AND mostatreg <> 'A'
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
  @Dig = ISNULL(cldv,'') ,
  @comcli = (SELECT view_ciudad_comuna.nom_ciu FROM VIEW_CIUDAD_COMUNA WHERE view_ciudad_comuna.cod_pai = clpais AND view_ciudad_comuna.cod_ciu = clciudad and view_ciudad_comuna.cod_com =clcomuna)
 FROM VIEW_CLIENTE
 WHERE clrut=@Rutcli
 SELECT @Tipocli = ISNULL(tbglosa ,'')
 FROM VIEW_TABLA_GENERAL_DETALLE
 WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)
 IF @Ret='V'
  SELECT @Retiro = 'Vamos'
 ELSE
  SELECT @Retiro = 'Vienen'
 SELECT @nMtoVenta = ISNULL(SUM(mocapitali),0) ,
  @MtoRecompra = ISNULL(SUM(movalvenp),0)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI'
 EXECUTE SP_MONTOESCRITO @nMtoVenta, @MtoEsc OUTPUT
 IF @nMes= 1 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 2 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 3 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 4 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 5 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Mayo  de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 6 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 7 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 8 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn) 
        IF @nMes= 9 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
        IF @nMes=10 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn)
        IF @nMes=11 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
        IF @nMes=12 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)
 IF @nDiaSem=1 SELECT @cFecVen = 'Domingo '  + @cFecVen
 IF @nDiaSem=2 SELECT @cFecVen = 'Lunes '    + @cFecVen
        IF @nDiaSem=3 SELECT @cFecVen = 'Martes '   + @cFecVen
        IF @nDiaSem=4 SELECT @cFecVen = 'Miercoles '+ @cFecVen
        IF @nDiaSem=5 SELECT @cFecVen = 'Jueves '   + @cFecVen
        IF @nDiaSem=6 SELECT @cFecVen = 'Viernes '  + @cFecVen
        IF @nDiaSem=7 SELECT @cFecVen = 'Sabado '   + @cFecVen
 SELECT @valmon = vmvalor
 FROM VIEW_VALOR_MONEDA, MDMO
 WHERE vmcodigo=momonpact AND vmfecha=mofecinip AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='VI' AND mostatreg <> 'A'
 IF @valmon=NULL SELECT @valmon = 1
 EXECUTE SP_PAPELETA_LIMITES 'VI'     ,
     @nNumoper    ,
     @cSettlement  OUTPUT  ,
     @cPFE   OUTPUT  ,
     @cEmisorInstPlazo OUTPUT  ,
     @cCCE   OUTPUT
 SELECT 'nomemp' = ISNULL(rcnombre,'')      ,
  'rutemp' = STR(rcrut)+'-'+rcdv     ,
  'fecpro' = ISNULL(CONVERT(CHAR(10),acfecproc,103),CHAR(10))  ,
  'tipcart' = ISNULL(@tipcart,'')      ,
  'fecemi' = ISNULL(@cFecEmi,'')      ,
  'numoper' = ISNULL(monumoper,0)      ,
  'totalV' = ISNULL(@TotalC,0)      ,
  'forpai' = ISNULL(@forpac,'')      ,
  'totalc' = ISNULL(@TotalV,0)      ,
  'forpav' = ISNULL(@forpav,'')      ,
  'tasapacto' = ISNULL(motaspact,0)      ,
  'base'  = ISNULL(mobaspact,0)      ,
  'dias'  = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)   ,
  'fecven' = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')   ,
  'correla' = ISNULL(mocorrela,0)      ,
  'serie'  = ISNULL(moinstser,'')      ,
  'nominal' = ISNULL(monominal,0)      ,
  'tasa'  = ISNULL(motir,0)      ,
  'total'  = ISNULL(movpresen,0)      ,
  'custodia' = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END,
  'tipcli' = ISNULL(@Tipocli,'')      ,
  'tipcon' = ISNULL(@Retiro,'')      ,
  'rut'  = STR(@Rutcli)+'-'+@Dig      ,
  'codcli' = ISNULL(@Codcli,0)      ,
  'nomcli' = ISNULL(@Nomcli,'')      ,
  'dircli' = ISNULL(@Dircli,'')      ,
  'fono'  = ISNULL(@Foncli,'')      ,
  'faxcli' = ISNULL(@Faxcli,'')      ,
  'observa' = ISNULL(@Observ,'')      ,
  'nomope' = ISNULL(@Nomoper,'')      ,
  'Emisor' = ISNULL(emgeneric,'')      ,
  'Moneda' = ISNULL(mnnemo,'')      ,
  'MonPact' = ISNULL(@Monpact,'')      ,
  'Fecha_Emi' = CONVERT(CHAR(10),mofecemi,103)    , 
  'Fecha_Ven' = CONVERT(CHAR(10),mofecven,103)    ,
  'ValInip' = ISNULL(ROUND(movalinip/@valmon,4),0)    ,
  'ValVenp' = ISNULL(movalvenp,0)      ,
  'MtoVenta' = ISNULL(movalinip,0)      ,
  'MtoEscrito' = @MtoEsc       ,
  'MtoRecompra' = ISNULL(movalvenp,0)      ,
  'Fec_Ven' = @cFecVen       ,
  'diremp' = ISNULL(acdirprop,'')      ,
  'comemp' = ISNULL(accomprop,'')       ,
  'comcli' = ISNULL(@monglo,'')       ,
  'copia'  = ISNULL(@glocopia,'')      ,
  'Pagina' = 0        ,
  'contador' = ISNULL(mocorvent,0)      ,
  'numdocu' = ISNULL(monumdocu,0)      ,
  'TotalPag' = 0        ,
  'linea1' = ISNULL(@linea1,'')      ,
  'hora'  = ISNULL(@hora,'')      ,
  'Lim_Settle' = @cSettlement       ,
  'Lim_PFE' = @cPFE                                                  ,
                'clave_dcv' = moclave_dcv       ,
  'Lim_CCE' = @cCCE
 INTO #Temp
 FROM MDAC
--  REQ. 7619
    , MDMO LEFT OUTER JOIN VIEW_EMISOR ON morutemi = emrut
           LEFT OUTER JOIN VIEW_MONEDA ON momonemi = mncodmon
--  REQ. 7619
/*  , VIEW_EMISOR 
    , VIEW_MONEDA  */
    , VIEW_ENTIDAD 
 WHERE morutcart=@nRutcart 
   AND morutcart = rcrut 
   AND monumoper=@nNumoper 
   AND motipoper='VI' 
--  REQ. 7619
/*   AND morutemi*=emrut 
   AND momonemi*=mncodmon  */
   AND mostatreg <> 'A'
 ORDER BY mocorrela
 SELECT @contador = 0 ,
  @contador2 = 0 ,
  @pagina  = 1
 WHILE @pagina <> 0
 BEGIN
  SELECT @tipcart = '*'
  SET ROWCOUNT 1
  SELECT @tipcart = tipcart ,
   @contador = contador
  FROM #Temp
  WHERE contador>@contador
  ORDER BY contador
  SET ROWCOUNT 0
  IF @tipcart='*'
   BREAK
  SELECT @contador2 = @contador2 + 1
  UPDATE #TMP SET pagina  = @pagina WHERE contador=@Contador
  UPDATE #TMP SET TotalPag = @pagina
  IF @contador2=@nTotPagina
   SELECT @pagina  = @pagina + 1 ,
    @contador2 = 0
 END
 SELECT * FROM #TEMP
SET NOCOUNT OFF
 RETURN
END

GO
