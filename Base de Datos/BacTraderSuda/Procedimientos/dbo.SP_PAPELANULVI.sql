USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELANULVI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAPELANULVI]
    (@nRutcart NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @cTipoImp CHAR (01) )
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
  @cPFECCE CHAR(50) ,
  @cEmisorInstPlazo CHAR(255),
  @cCCE   char(50)
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
  @monglo  = RTRIM(mnglosa)
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
 SELECT @Forpac = glosa 
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagi --Forma de pago
        AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='VI'
 SELECT @Forpav = glosa 
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagv --forma de pago
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
  @Nomoper = nombre   ,
  @hora  = mohora
 FROM MDMO, VIEW_USUARIO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI' AND
  mousuario=SUBSTRING(usuario,1,12) AND mostatreg='A'
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
  @comcli = (SELECT view_ciudad_comuna.nom_ciu FROM VIEW_CIUDAD_COMUNA WHERE cod_ciu = clciudad AND cod_com =clcomuna)
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
 EXECUTE Sp_Montoescrito @nMtoVenta, @MtoEsc OUTPUT
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
  morutcart=@nRutcart AND motipoper='VI' AND mostatreg='A'
 IF @valmon=NULL SELECT @valmon = 1
 EXECUTE Sp_Papeleta_Limites 'VI'     ,
     @nNumoper    ,
     @cSettlement  OUTPUT  ,
     @cPFECCE  OUTPUT  ,
     @cEmisorInstPlazo OUTPUT  ,
     @cCCE          output
 SELECT 'nomemp' = ISNULL(rcnombre,'')      ,--1
  'rutemp' = STR(rcrut)+'-'+rcdv      ,--2
  'fecpro' = ISNULL(CONVERT(CHAR(10),acfecproc,103),CHAR(10))  ,--3
  'tipcart' = ISNULL(@tipcart,'')      ,--4
  'fecemi' = ISNULL(@cFecEmi,'')      ,--5
  'numoper' = ISNULL(monumoper,0)      ,--6
  'totalV' = ISNULL(@TotalC,0)      ,--7
  'forpai' = ISNULL(@forpac,'')      ,--8
  'totalc' = ISNULL(@TotalV,0)      ,--9
  'forpav' = ISNULL(@forpav,'')      ,--10
  'tasapacto' = ISNULL(motaspact,0)      ,--11
  'base'  = ISNULL(mobaspact,0)      ,--12
  'dias'  = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)   ,--13
  'fecven' = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')   ,--14
  'correla' = ISNULL(mocorrela,0)      ,--15
  'serie'  = ISNULL(moinstser,'')      ,--16
  'nominal' = ISNULL(monominal,0)      ,--17
  'tasa'  = ISNULL(motir,0)      ,--18
  'total'  = ISNULL(movpresen,0)      ,--19
  'custodia' = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END,--20
  'tipcli' = ISNULL(@Tipocli,'')      ,--21
  'tipcon' = ISNULL(@Retiro,'')      ,--22
  'rut'  = STR(@Rutcli)+'-'+@Dig      ,--23
  'codcli' = ISNULL(@Codcli,0)      ,--24
  'nomcli' = ISNULL(@Nomcli,'')      ,--25
  'dircli' = ISNULL(@Dircli,'')      ,--26
  'fono'  = ISNULL(@Foncli,'')      ,--27
  'faxcli' = ISNULL(@Faxcli,'')      ,--28
  'observa' = ISNULL(@Observ,'')      ,--29
  'nomope' = ISNULL(@Nomoper,'')      ,--30
  'Emisor' = ISNULL(emgeneric,'')      ,--31
  'Moneda' = ISNULL(mnnemo,'')      ,--32
  'MonPact' = ISNULL(@Monpact,'')      ,--33
  'Fecha_Emi' = CONVERT(CHAR(10),mofecemi,103)    ,--34
  'Fecha_Ven' = CONVERT(CHAR(10),mofecven,103)    ,--35
  'ValInip' = ISNULL(ROUND(movalinip/@valmon,4),0)    ,--36
  'ValVenp' = ISNULL(movalvenp,0)      ,--37
  'MtoVenta' = ISNULL(movalinip,0)      ,--38
  'MtoEscrito' = @MtoEsc       ,--39
  'MtoRecompra' = ISNULL(movalvenp,0)      ,--40
  'Fec_Ven' = @cFecVen       ,--41
  'diremp' = ISNULL(acdirprop,'')      ,--42
  'comemp' = ISNULL(accomprop,'')       ,--43
  'comcli' = ISNULL(@monglo,'')       ,--44
  'copia'  = ISNULL(@glocopia,'')      ,--45
  'Pagina' = 0        ,--46
  'contador' = ISNULL(mocorvent,0)      ,--47
  'numdocu' = ISNULL(monumdocu,0)      ,--48
  'TotalPag' = 0        ,--49
  'linea1' = ISNULL(@linea1,'')      ,--50
  'hora'  = @hora        ,--51
  'Lim_Settle' = @cSettlement       ,--52
  'Lim_PFECCE' = @cPFECCE       ,--53
  'clave_dcv' = moclave_dcv        --54
 INTO #TEMP
 FROM MDAC
 , MDMO LEFT OUTER JOIN VIEW_EMISOR MDEM ON morutemi = emrut 
		LEFT OUTER JOIN VIEW_MONEDA ON momonemi = mncodmon 
 , BacparamSuda..ENTIDAD MDRC
 WHERE morutcart=@nRutcart 
 AND morutcart = rcrut 
 AND monumoper=@nNumoper 
 AND motipoper='VI' 
 AND mostatreg='A'
 ORDER BY mocorrela

--REQ.7619 CASS 25-01-2011
-- FROM MDAC, MDMO, VIEW_EMISOR MDEM, VIEW_MONEDA, BACPARAEMTROS..ENTIDAD MDRC
-- WHERE morutcart=@nRutcart AND morutcart = rcrut AND monumoper=@nNumoper AND motipoper='VI' AND
--  morutemi*=emrut AND momonemi*=mncodmon AND mostatreg='A'
-- ORDER BY mocorrela

 SELECT @contador = 0 ,
  @contador2 = 0 ,
  @pagina  = 1
 WHILE @pagina <> 0
 BEGIN
  SELECT @tipcart = '*'
  SET ROWCOUNT 1
  SELECT @tipcart = tipcart ,
   @contador = contador
  FROM #TEMP
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
