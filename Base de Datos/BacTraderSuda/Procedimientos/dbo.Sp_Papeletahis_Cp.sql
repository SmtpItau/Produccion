USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Papeletahis_Cp]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Objeto:  procedimiento  almacenado dbo.SP_PAPELETAHIS_CP    fecha de la secuencia de comandos: 05/04/2001 13:13:47 ******/
CREATE PROCEDURE [dbo].[Sp_Papeletahis_Cp]
    (@nRutcart NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @cTipoImp CHAR (01) )
AS
BEGIN
 DECLARE @cFecEmi VARCHAR (40) ,
  @nDiaSem INTEGER  ,
  @nDia  INTEGER  ,
  @nMes  INTEGER  ,
  @nAnn  INTEGER  ,
  @tipcart CHAR (25) ,
  @Forpa  CHAR (25) ,
  @Tipocli CHAR (25) ,
  @Tipcli  CHAR (05) ,
  @Tipret  CHAR (15) ,
  @Rutcli  NUMERIC (9,0) ,
  @Codcli  NUMERIC (9,0) ,
  @Nomcli  CHAR (40) ,
  @Dircli  CHAR (40) ,
  @Foncli  CHAR (15) ,
  @Faxcli  CHAR (15) ,
  @Obser  CHAR (70) ,
  @Nomoper CHAR (40) ,
  @DigVeri CHAR (01) ,
  @Nompro  VARCHAR (40) ,
  @Rutpro  CHAR (12) ,
  @Fecpro  VARCHAR (10) ,
  @Dirpro  VARCHAR (40) ,
  @Cust  CHAR (15) ,
  @Total  NUMERIC (19,2) ,
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
  @nIva  NUMERIC (19,0)
 IF @cTipoImp='P'
  SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=@nnumoper
 ELSE
  SELECT @nCopia = paconimp FROM MDPA WHERE panumoper=@nnumoper
 IF @cTipoImp='P'
  SELECT @nTotPagina = 16
 ELSE
  SELECT @nTotPagina = 23
 IF @cTipoImp='P'
  SELECT @glocopia = CASE
      WHEN @nCopia=1 THEN 'COPIA MESA'
      WHEN @nCopia=2 THEN 'COPIA INVERSIONES'
      WHEN @nCopia=3 THEN 'COPIA CUSTODIA'
      ELSE ' '
       END
 ELSE
  SELECT @glocopia = CASE
      WHEN @nCopia=1 THEN 'ORIGINAL CLIENTE'
      WHEN @nCopia=2 THEN 'COPIA CLIENTE'
      ELSE ' '
       END
 SELECT @Cust  = CASE mocondpacto
     WHEN 'S' THEN 'Con Custodia'
     ELSE 'Sin Custodia'
      END       ,
  @Obser  = ISNULL(moobserv,'')     ,
  @linea1  = ISNULL(moobserv2,'')     ,
  @Rutcli  = ISNULL(morutcli,0)     ,
  @Tipret  = CASE motipret
     WHEN 'I' THEN 'VIENEN'
     ELSE 'VAMOS'
      END       ,
  @Nomoper = nombre      ,
  @Nompro  = ISNULL(rcnombre,'')     ,
  @Rutpro  = STR(rcrut)+'-'+rcdv     ,
  @Dirpro  = ISNULL(rcdirecc,'')     ,
  @Fecpro  = CONVERT(CHAR(10),mofecpro,103)   ,
  @nMtoComi = ISNULL(momtocomi,0)     ,
  @fComision = accomision/CONVERT(FLOAT,100)    ,
  @nIva  = ISNULL(momtocomi,0)
 FROM MDMH (INDEX=Mh01), view_usuario, view_entidad,mdac
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CP' AND mousuario=usuario AND rcrut = morutcart
 SELECT @Total = (SELECT SUM(movalcomp) 
 FROM MDMH (INDEX=Mh01)
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CP')
 SELECT @tipcart = tbglosa
 FROM VIEW_TABLA_GENERAL_DETALLE, MDMH (INDEX=Mh01)
 WHERE tbcateg=204 AND convert(NUMERIC(6),tbcodigo1)=motipcart AND monumoper=@nNumoper AND morutcart=@nRutcart AND
  motipoper='CP'
 SELECT @Forpa  = glosa
 FROM VIEW_FORMA_DE_PAGO, MDMH
 WHERE codigo=CONVERT(NUMERIC(5,0),moforpagi) AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='CP'
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecpro) ,
  @nDia  = DATEPART(DAY,mofecpro) ,
  @nMes  = DATEPART(MONTH,mofecpro) ,
  @nAnn  = DATEPART(YEAR,mofecpro)
 FROM MDMH (INDEX=Mh01)
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CP'
 IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+ CONVERT(CHAR(4),@nAnn)
 IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '   + CONVERT(CHAR(4),@nAnn)
 IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' + CONVERT(CHAR(4),@nAnn)
 IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' + CONVERT(CHAR(4),@nAnn)
 IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  + @cFecEmi
 IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    + @cFecEmi
 IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   + @cFecEmi
 IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+ @cFecEmi
 IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   + @cFecEmi
 IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  + @cFecEmi
 IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   + @cFecEmi
-- SELECT @NumSol = monsollin
-- FROM MdMh
-- WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CP'
 SELECT @NumSol = 0
 SELECT @Nomcli  = clnombre  ,
  @Dircli  = cldirecc  ,
  @Foncli  = clfono  ,
  @Faxcli  = clfax   ,
  @Codcli  = clcodigo  ,
  @Tipcli  = convert(CHAR(5),cltipcli),
  @Digveri = ISNULL(cldv,' ')
 FROM VIEW_CLIENTE
 WHERE clrut=@Rutcli
 IF @nMtoComi=0
  SELECT @nIva  = 0 ,
   @nMtoComi = 0 ,
   @fComision = 0
 SELECT @Tipocli = tbglosa   ,
  @nMtoComi = ROUND(@Total*@fComision,0)
 FROM VIEW_TABLA_GENERAL_DETALLE
 WHERE tbcateg=207 AND convert(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)
 SELECT 'cNompro' = ISNULL(@Nompro,'')     ,
  'nRutpro' = ISNULL(@Rutpro,'')     ,
  'dFecpro' = ISNULL(@Fecpro,'')     ,
  'TipoCart' = ISNULL(@Tipcart,'')     ,
  'fecemi' = ISNULL(@cFecemi,'')     ,
  'nooper' = ISNULL(monumoper,0)     ,
  'Total'  = ISNULL(@Total,0)     ,
  'fpago'  = ISNULL(@Forpa,'')     ,
  'Correla' = ISNULL(mocorrela,0)     ,
  'I_Seri' = ISNULL(moinstser,'')     ,
  'Nominal' = ISNULL(monominal,0)     ,
  'tir'  = ISNULL(motir,0)     ,
  'MtPs'  = ISNULL(movalcomp,0)     ,
  'Custodia' = ISNULL(@Cust,'')     ,
  'Tipcli' = ISNULL(@TipoCli,'')     ,
  'Tipret' = ISNULL(@Tipret,'')     ,
  'Rutcli' = STR(@Rutcli)+'-'+@Digveri    ,
  'Codcli' = ISNULL(CONVERT(CHAR(9),@Codcli),'')   ,
  'Nomcli' = ISNULL(@Nomcli,'')     ,
  'Dircli' = ISNULL(@Dircli,'')     ,
  'Foncli' = ISNULL(@FonCli,'')     ,
  'Faxcli' = ISNULL(@Faxcli,'')     ,
  'Obser'  = ISNULL(@Obser,'')     ,
  'Operador' = ISNULL(@Nomoper,'')     ,
  'emisor' = ISNULL(emgeneric,'')     ,
  'Moneda' = ISNULL(mnnemo,'')     ,
  'Linea1' = ISNULL(@linea1,'')     ,
  'Linea2' = ISNULL(@linea2,'')     ,
  'Linea3' = ISNULL(@linea3,'')     ,
  'Linea4' = ISNULL(@linea4,'')     ,
  'Linea5' = ISNULL(@linea5,'')     ,
  'vpb'  = ISNULL(mopvp,0)     ,
  'vpc'  = ISNULL(movpar,0)     ,
  'cDirpro' = ISNULL(@Dirpro,'')     ,
  'copia'  = ISNULL(@glocopia,'')     ,
  'Pagina' = 0       ,
  'contador' = ISNULL(mocontador,1)     ,
  'vvista' = ISNULL(movvista,0)     ,
  'TotalPag' = 0       ,
  'comision' = @nMtoComi      ,
  'iva'  = @nIva-@nMtoComi     ,
  'vvcomi' = ISNULL(movviscom,0)
 INTO #TEMP
 FROM MDMH (INDEX=Mh01), VIEW_EMISOR , VIEW_MONEDA
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CP' AND
  morutemi*=emrut AND momonemi*=mncodmon
 ORDER BY mocorrela
 SELECT @contador = 0 ,
  @contador2 = 0 ,
  @pagina  = 1
 WHILE @pagina<>NULL
 BEGIN
  SET ROWCOUNT 1
  SELECT @nompro = '*'
  SELECT @nompro  = cNompro ,
   @contador = ISNULL(contador,1)
  FROM #Temp
  WHERE contador>@contador
  ORDER BY contador
  SET ROWCOUNT 0
  IF @nompro='*'
   BREAK
  SELECT @contador2 = @contador2 + 1
  UPDATE #TMP SET pagina   = @pagina WHERE contador=@Contador
  UPDATE #TMP SET TotalPag = @pagina 
  IF @contador2=@nTotPagina
   SELECT @pagina  = @pagina + 1 ,
    @contador2 = 0
 END
 SELECT * FROM #TEMP
 RETURN
END
-- select * from MdMh where motipoper='CP'
-- SP_PAPELETAHIS_CP 97024000, 25318, 'P'
-- SELECT  papapimp FROM MdPa WHERE panumoper = 25318
GO
