USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELANULVP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAPELANULVP]
    (@nRutcart NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @cTipoImp CHAR (01) ,
    @cTipoper CHAR (02))
AS
BEGIN
SET NOCOUNT ON
 DECLARE @cFecEmi VARCHAR (40) ,
  @nDiaSem INTEGER  ,  
  @nDia  INTEGER  ,
   @nMes  INTEGER  ,
  @nAnn  INTEGER  ,
  @tipcart CHAR (25) ,
  @Forpa  CHAR (25) ,
  @Tipocli CHAR (25) ,
  @Tipcli  NUMERIC (05) ,
  @Tipret  CHAR (15) ,
  @Rutcli  NUMERIC (9,0) ,
  @Codcli  NUMERIC (9,0) ,
  @Nomcli  CHAR (40) ,
  @Dircli  CHAR  (40) ,
  @Foncli  CHAR (15) ,
  @Faxcli  CHAR (15) ,
  @Obser  CHAR (70) ,
  @Nomoper CHAR (40) ,
  @DigVeri CHAR (01) ,
  @Nompro  CHAR (40) ,
  @Dirpro  CHAR (40) ,
  @Rutpro  CHAR (12) ,
  @Fecpro  CHAR (10) ,
  @Total  NUMERIC (19,2) ,
  @Cust  CHAR (20) ,
  @NumSol  NUMERIC (9,0) ,
  @linea1  CHAR (70) ,
  @linea2  CHAR (65) ,
  @linea3  CHAR (65) ,
  @linea4  CHAR (65) ,
  @linea5  CHAR (65) ,
  @glocopia CHAR (25) ,
  @nCopia  INTEGER  ,
  @Pagina  INTEGER  ,
  @nTotPagina INTEGER  ,
  @contador NUMERIC (19,0) ,
  @contador2 NUMERIC (19,0) ,
  @nMtoComi NUMERIC (19,0) ,
  @fComision FLOAT  ,
  @nIva  NUMERIC (19,0) ,
  @hora  CHAR(8)  ,
  @cSettlement CHAR(50) ,
  @cPFE  CHAR(50) ,
  @cCCE  CHAR(50) ,
  @cEmisorInstPlazo CHAR(255)
 SELECT @glocopia = '.'
 IF @cTipoImp='P'
  SELECT @nTotPagina = 16
 ELSE
  SELECT @nTotPagina = 23
 SELECT @Total = (SELECT SUM(ROUND(movalven,2))
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper=@cTipoper and mostatreg='A')
 SELECT @tipcart = tbglosa
 FROM VIEW_TABLA_GENERAL_DETALLE, MDMO
 WHERE tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)=motipcart AND monumoper=@nNumoper AND morutcart=@nRutcart AND
  motipoper=@cTipoper and mostatreg='A'
 SELECT 
  @Forpa = glosa
 FROM 
  VIEW_FORMA_DE_PAGO,  
  MDMO    
 WHERE 
  codigo = moforpagi
        AND     monumoper = @nNumoper 
 AND morutcart = @nRutcart 
 AND  motipoper = @cTipoper 
 AND mostatreg = 'A'
  SELECT @Cust  = CASE mocondpacto
     WHEN 'S' THEN 'Con Custodia'
     ELSE 'Sin Custodia'
      END       ,
  @Obser  = moobserv      ,
  @linea1  = moobserv2      ,
  @nDiaSem = DATEPART(WEEKDAY,mofecpro)    ,
  @nDia  = DATEPART(DAY,mofecpro)    ,
  @nMes  = DATEPART(MONTH,mofecpro)    ,
  @nAnn  = DATEPART(YEAR,mofecpro)    ,
  @NumSol  = monsollin      ,
  @Rutcli  = morutcli      ,
  @Tipret  = CASE motipret
     WHEN 'I' THEN 'VIENEN'
     ELSE 'VAMOS'
      END 
       ,
  @Nompro  = ISNULL(rcnombre,'')     ,
  @Dirpro  = ISNULL(acDirprop,'')     ,
  @Rutpro  = STR(rcrut)+'-'+rcdv    ,
  @Fecpro  = CONVERT(CHAR(10),acfecproc,103)   ,
  @Nomoper = nombre      ,
  @nMtoComi = ISNULL(momtocomi,0)     ,
  @fComision = accomision/CONVERT(FLOAT,100)    ,
  @nIva  = ISNULL(momtocomi,0)     ,
  @Codcli  = mocodcli       ,  
  @hora  = mohora
 FROM 
  MDMO  ,
  VIEW_USUARIO ,
  MDAC  ,
  VIEW_ENTIDAD MDRC
 WHERE 
  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
        AND     morutcart=rcrut
 AND  motipoper=@cTipoper 
 AND mousuario=SUBSTRING(usuario,1,12)
 AND  mostatreg='A'
 IF @nMes= 1 SELECT @CFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
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
 SELECT 
  @Nomcli  = clnombre  ,
  @Dircli  = cldirecc  ,
  @Foncli  = clfono  ,
  @Faxcli  = clfax   ,
  @Tipcli  = cltipcli  ,
  @Digveri = ISNULL(cldv,' ')
 FROM 
  VIEW_CLIENTE
 WHERE 
  clrut=@Rutcli
 AND clcodigo=@codcli
 IF @nMtoComi=0
  SELECT @nIva  = 0 ,
   @nMtoComi = 0 ,
   @fComision = 0
 SELECT @Tipocli = tbglosa   ,
  @nMtoComi = ROUND(@Total*@fComision,0)
 FROM VIEW_TABLA_GENERAL_DETALLE
 WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)
 EXECUTE Sp_Papeleta_Limites @cTipoper     ,
     @nNumoper     ,
     @cSettlement   OUTPUT  ,
     @cPFE    OUTPUT  ,
     @cEmisorInstPlazo  OUTPUT  ,
     @cCCE    OUTPUT
 SELECT 'cNompro' = ISNULL(@Nompro,'')     ,
  'nRutpro' = ISNULL(@Rutpro,'')     ,
  'dFecpro' = ISNULL(@Fecpro,'')     ,
  'TipoCart' = ISNULL(@Tipcart,'')     ,
  'fecemi' = ISNULL(@cFecemi,'')     ,
  'näoper' = ISNULL(monumoper,0)     ,
  'TotalG' = ISNULL(@Total,0)     ,
  'fpago'  = ISNULL(@Forpa,'')     ,
  'Correla' = ISNULL(mocorrela,0)     ,
  'I_Seri' = ISNULL(moinstser,'')     ,
  'Nominal' = ISNULL(monominal,0)     ,
  'TIR'  = ISNULL(motir,0)      ,
  'MtPs'  = ISNULL(movalven,0)     ,
  'Custodia' = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END ,
  'Tipcli' = ISNULL(@TipoCli,'')     ,
  'Tipret' = ISNULL(@Tipret,'')     ,
  'Rutcli' = STR(@Rutcli)+'-'+@Digveri    ,
  'Codcli' = ISNULL(CONVERT(CHAR(9),@Codcli),'')    ,
  'Nomcli' = ISNULL(@Nomcli,'')     ,
  'Dircli' = ISNULL(@Dircli,'')     ,
  'Foncli' = ISNULL(@FonCli,'')     ,
  'Faxcli' = ISNULL(@Faxcli,'')     ,
  'Obser'  = ISNULL(@Obser,'')     ,
  'Operador' = ISNULL(@Nomoper,'')     ,
  'Emisor' = ISNULL(emgeneric,'')     ,
  'Moneda' = ISNULL(mnnemo,'')     ,
  'Linea1' = ISNULL(@linea1,'')     ,
  'Linea2' = ISNULL(@linea2,'')     ,
  'Linea3' = ISNULL(@linea3,'')     ,
  'Linea4' = ISNULL(@linea4,'')     ,
  'Linea5' = ISNULL(@linea5,'')     ,
  'vpb'  = ISNULL(mopvp,0)     ,
  'vpc'  = ISNULL(movpar,0)          ,
  'cDirpro' = ISNULL(@Dirpro,'')          ,
  'Copia'  = ISNULL(@glocopia,'')     ,
  'Pagina' = 0       ,
  'contador' = ISNULL(mocorvent,0)     ,
  'numdocu' = ISNULL(monumdocu,0)     ,
  'Totalpag' = 0       ,
  'comision' = @nMtoComi      ,
  'iva'  = @nIva-@nMtoComi     ,
  'vvcomi' = ISNULL(movviscom,0)     ,
  'hora'  = @hora       ,
  'clave'  = moclave_dcv      ,
  'Lim_Settle' = @cSettlement
 INTO #Temp
 FROM MDMO LEFT OUTER JOIN VIEW_EMISOR MDEM ON  morutemi = emrut 
				   LEFT OUTER JOIN VIEW_MONEDA ON momonemi = mncodmon
 WHERE monumoper	=	@nNumoper 
 AND morutcart		=	@nRutcart 
 AND motipoper		=	@cTipoper
 AND mostatreg		=	'A'
 ORDER BY mocorrela

-- REQ.7619 CASS 25-01-2011
-- FROM MDMO, VIEW_EMISOR MDEM, VIEW_MONEDA
-- WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper=@cTipoper AND
--  morutemi*=emrut AND momonemi*=mncodmon AND mostatreg='A'
-- ORDER BY mocorrela

 SELECT @contador = 0 ,
  @contador2 = 0 ,
  @pagina  = 1
 WHILE @pagina<>0
 BEGIN
  SET ROWCOUNT 1
  SELECT @nompro  = '*'
  SELECT @nompro  = cNompro ,
  
  @contador = contador
  FROM #Temp
  WHERE contador>@contador
  ORDER BY contador
  SET ROWCOUNT 0
  IF @nompro='*'
   BREAK
  SELECT @contador2 = @contador2 + 1
  UPDATE #TMP SET pagina = @pagina WHERE contador=@Contador
  UPDATE #TMP SET TotalPag = @pagina 
  IF @contador2=@nTotPagina
   SELECT @pagina  = @pagina + 1 ,
    @contador2 = 0
 END
 SELECT * FROM #Temp
      SET NOCOUNT OFF
 RETURN
END


GO
