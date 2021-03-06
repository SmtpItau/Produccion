USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETARCA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAPELETARCA](
    @nRutcart NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @cTipoimp CHAR (01) 
    )
AS
BEGIN

/*=======================================================================*/
 DECLARE @firma1 char(15)
 DECLARE @firma2 char(15)


	  Select @firma1=res.Firma1,
		 @firma2=res.Firma2
	   From BacLineas..detalle_aprobaciones res
	   Where res.Numero_Operacion=@nNumoper
/*=======================================================================*/



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
  @Tipcli  numeric (05) ,
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
  @valmon  FLOAT  ,
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
  @EstadoPeracion VARCHAR (100)
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
 FROM 
  MDMO , 
  VIEW_MONEDA
 WHERE 
  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND  motipoper='RCA' 
 AND momonpact=mncodmon
 SELECT @Totalc = SUM(movalinip),
  @Totalv = SUM(movalvenp)
 FROM MDMO
 WHERE 
  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND  motipoper='RCA'
/*
 SELECT @tipcart=tbglosa 
 FROM VIEW_TABLA_GENERAL_DETALLE,
  MDMO
 WHERE tbcateg =204 
 AND CONVERT(NUMERIC(6),tbcodigo1) = motipcart 
 AND  monumoper=@nNumoper 
 AND morutcart=@nRutcart 
 AND  motipoper='RCA'
*/
 SELECT Distinct @tipcart =  IsNull(rcnombre,'')
 FROM BacParamSuda..TIPO_CARTERA, MDMO
 WHERE rcsistema = 'BTR' And rcrut = motipcart AND monumoper=@nNumoper AND 
 morutcart=@nRutcart AND motipoper='RCA'


 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecvenp) ,
  @nDia  = DATEPART(DAY,mofecvenp) ,
  @nMes  = DATEPART(MONTH,mofecvenp) ,
  @nAnn           = DATEPART(YEAR,mofecvenp)
 FROM 
  MDMO
 WHERE 
  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND  motipoper='RCA'
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
 IF @nDiaSem=3 SELECT @cFecEmi = 'Martes'   +@cFecEmi
 IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+@cFecEmi
 IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   +@cFecEmi
 IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  +@cFecEmi
 IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   +@cFecEmi
 SELECT @NumSol = monsollin
 FROM MdMo
 WHERE 
  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND  motipoper='RCA'
 SELECT  @foncli = '...' ,
  @linea2 = ' ' ,
  @linea3 = ' ' ,
  @linea4 = ' '
 SELECT 
  @Forpac = glosa 
 FROM 
  VIEW_FORMA_DE_PAGO ,  
  MDMO
 WHERE 
  codigo=moforpagi 
 AND monumoper=@nNumoper 
 AND morutcart=@nRutcart 
 AND motipoper='RCA'
 SELECT 
  @Forpav = glosa 
 FROM 
  VIEW_FORMA_DE_PAGO ,
  MDMO
 WHERE 
  codigo=moforpagv  
 AND monumoper=@nNumoper 
 AND morutcart=@nRutcart 
 AND  motipoper='RCA'
 SELECT @Cust  = ''     ,
  @Observ  = moobserv   ,
  @linea1  = moobserv2   ,
  @Ret  = motipret   ,
  @nDiaSem = DATEPART(WEEKDAY,mofecvenp) ,
  @nDia  = DATEPART(DAY,mofecvenp) ,
  @nMes  = DATEPART(MONTH,mofecvenp) ,
  @nAnn  = DATEPART(YEAR,mofecvenp) ,
  @Rutcli  = morutcli   ,
  @Nomoper = nombre   ,
  @codcli  = mocodcli   ,
  @EstadoPeracion = CASE mostatreg
              WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION'
     ELSE ''
      END 
 FROM 
  MDMO ,
  VIEW_USUARIO
 WHERE 
  monumoper=@nNumoper 
 AND morutcart=@nRutcart 
 AND motipoper='RCA' 
 AND mousuario=usuario
 IF @Cust='S'
  SELECT @Custodia = 'Con Custodia'
 ELSE
  SELECT @Custodia = 'Sin Custodia'
        
 SELECT @Nomcli = clnombre  , 
  @Dircli = cldirecc  , 
  @Foncli = CASE  LTRIM(clfono)
    WHEN  NULL  THEN '...' 
    ELSE clfono 
     END ,
  @Faxcli = CASE  LTRIM(clfax) 
    WHEN  NULL THEN '...' 
    ELSE clfax 
     END ,
  @Tipcli = cltipcli  ,
  @Dig = ISNULL(cldv,'') ,
  @comcli = (SELECT view_ciudad_comuna.nom_ciu FROM VIEW_CIUDAD_COMUNA WHERE view_ciudad_comuna.cod_ciu = clciudad AND view_ciudad_comuna.cod_com = clcomuna)
 FROM 
  VIEW_CLIENTE
 WHERE 
  clrut=@Rutcli
 AND clcodigo=@codcli
 SELECT 
  @Tipocli = ISNULL(tbglosa ,'')
 FROM 
  VIEW_TABLA_GENERAL_DETALLE
 WHERE 
  tbcateg =207 
 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)
 IF @Ret ='V'
  SELECT @Retiro = 'Vamos'
 ELSE
  SELECT @Retiro = 'Vienen'
 SELECT @nMtoVenta = ISNULL(SUM(movalinip),0) ,
  @MtoRecompra = ISNULL(SUM(movalvenp),0)
 FROM 
  MDMO
 WHERE 
  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND  motipoper='RCA'
 EXECUTE Sp_MontoEscrito @nMtoVenta, @MtoEsc OUTPUT
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
 SELECT @valmon = 1.0
 SELECT @valmon = vmvalor
 FROM 
  VIEW_VALOR_MONEDA,
  MDMO   ,
  MDAC
 WHERE 
  vmcodigo=(CASE WHEN momonpact = 13 Then 994 ELSE momonpact END)
 AND  vmfecha=acfecproc 
 AND  monumoper=@nNumoper 
 AND morutcart=@nRutcart 
 AND  motipoper='RCA' 
 AND momonpact<>999
 IF @valmon=NULL
  SELECT @valmon = 1.0
 CREATE TABLE #paso_error ( Mensaje_Error VARCHAR(255),
     Monto  NUMERIC(19,4),
     sw  CHAR(1),
     NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1))
 INSERT INTO #paso_error
 SELECT Mensaje, Monto, 'N'
 FROM view_limite_transaccion_error
 WHERE NumeroOperacion = @nnumoper
 AND id_sistema = 'BTR'
 DECLARE @NumeroCorre_Detalle INTEGER
 DECLARE @nMontoError  NUMERIC(19,4)
 DECLARE @cMontoFMT  CHAR(20)
 WHILE 1=1
 BEGIN
  SET ROWCOUNT 1
  SELECT @NumeroCorre_Detalle = 0
  SELECT @NumeroCorre_Detalle = NumeroCorre_Detalle,
   @nMontoError  = Monto
  FROM #paso_error
  WHERE sw='N'
  SET ROWCOUNT 0
  IF @NumeroCorre_Detalle = 0 BREAK
  EXECUTE sp_retorna_monto_formateado @nMontoError, 0, @cMontoFMT OUTPUT
  UPDATE #paso_error
  SET  Mensaje_Error = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT,
   sw='S'
  WHERE @NumeroCorre_Detalle = NumeroCorre_Detalle
 END
 SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
 SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
 SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3
-- SELECT @linea4 = operador FROM view_linea_transaccion WHERE NumeroOperacion = @nnumoper and NumeroCorrelativo = 1 and id_sistema = "BTR"
 IF EXISTS(SELECT Operador_Ap_LINEAS FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)
 BEGIN
  SELECT @EstadoPeracion = CASE Estado
      WHEN 'A' THEN 'OPERACION APROBABA POR :   '  + Operador_Ap_LINEAS
      WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
      Else ''
      END
  FROM view_aprobacion_operaciones,
   mdac
  WHERE id_sistema = 'BTR'
  AND NumeroOperacion = @nNumoper
  AND FechaOperacion = acfecproc
 END
 SELECT 'nomemp' = ISNULL(acnomprop,'')      ,
  'rutemp' = STR(acrutprop)+'-'+acdigprop     ,
  'fecpro' = ISNULL(CONVERT(CHAR(10),acfecproc,103),CHAR(10))   ,
  'tipcart' = ISNULL(@tipcart,'')      ,
  'fecemi' = ISNULL(@cFecEmi,'')      ,
  'numoper' = ISNULL(MDMO.monumoper,0)     ,
  'totalV' = ISNULL(@TotalC,0)      ,
  'forpai' = ISNULL(@forpac,'')      ,
  'totalc' = ISNULL(@TotalV,0)      ,
  'forpav' = ISNULL(@forpav,'')      ,
  'tasapacto' = ISNULL(MDMO.motasant,0)     ,
  'base'  = ISNULL(MDMO.mobaspact,0)     ,
  'dias'  = ISNULL(DATEDIFF(DAY,MDMO.mofecinip,MDMO.mofecvenp),0)  ,
  'fecven' = ISNULL(CONVERT(CHAR(10),MDMO.mofecvenp,103),'')   ,
  'correla' = ISNULL(MDMO.mocorrela,0)     ,
  'serie'  = ISNULL(MDMO.moinstser,'')     ,
  'nominal' = ISNULL(MDMO.monominal,0)     ,
  'tasa'  = ISNULL(MDMO.motir,0)      ,
  'total'  = ISNULL(MDMO.movpresen,0)     ,
  'custodia' = ISNULL(@Custodia,'')      ,
  'tipcli' = ISNULL(@Tipocli,'')      ,
  'tipcon' = ISNULL(@Retiro,'')      ,
  'rut'  = STR(@Rutcli)+'-'+@Dig      ,
  'codcli' = ISNULL(@Codcli,0)      ,
  'nomcli' = ISNULL(@Nomcli,'')      ,
  'dircli' = ISNULL(@Dircli,'')      ,
  'fono'  = ISNULL(@Foncli,'..')      ,
  'faxcli' = ISNULL(@Faxcli,'..')      ,
  'observa' = ISNULL(@Observ,'')      ,
  'nomope' = ISNULL(@Nomoper,'')      ,
  'Emisor' = ISNULL(emgeneric,'')      ,
  'Moneda' = ISNULL(mnnemo,'')      ,
  'MonPact' = ISNULL(@Monpact,'')      ,
  'Fecha_Emi' = CONVERT(CHAR(10),MDMO.mofecemi,103)    ,
  'Fecha_Ven' = CONVERT(CHAR(10),MDMO.mofecven,103)    ,
  'ValInip' = ISNULL(ROUND(MDMO.movalvenp/@valmon,4),0)   ,
  'ValVenp' = isnull(MDMO.movalvenp,0)            ,
  'MtoVenta' = ISNULL(MDMO.movalinip,0)     ,
  'MtoEscrito' = @MtoEsc       ,
  'MtoRecompra' = ISNULL(MDMO.movalvenp,0)     ,
  'Fec_Ven' = @cFecVen       ,
  'diremp' = ISNULL(acdirprop,'')      ,
  'comemp' = ISNULL(accomprop,'')       ,
  'comcli' = ISNULL(@monglo,'')       ,
  'copia'  = ISNULL(@glocopia,'')      ,
  'xPagina' = 0        ,
  'contador' = ISNULL(MDMO.mocontador,0)     ,
  'numdocu' = ISNULL(MDMO.monumdocu,0)     ,
  'xTotalPag' = 0        ,
  'linea1' = ISNULL(@linea1,'')      ,
  'fecharca' = CONVERT(CHAR(10),MDMO.mofecpro,103)    ,
  'tasarca' = ISNULL(MDMO.motaspact,0)     ,
  'montorca' = CONVERT(FLOAT,0)      ,
  'diferencia' = CONVERT(FLOAT,0)      ,
  'fechainicial'  = CONVERT(CHAR(10),MDMO.mofecinip,103)     ,
  'plazoreal'     = DATEDIFF(DAY,MDMO.mofecpro,MDMO.mofecvenp)   ,
  'valorumrca'    = CONVERT(FLOAT,0)      ,
  'numvista' = ISNULL(MDMO.movvista,0)     ,
  'hora'  = mohora       ,
  'EstadoPeracion'= @EstadoPeracion ,
  'Firma1'=@firma1 ,
  'Firma2'=@firma2

 INTO 
  #TEMPORAL
 FROM 
  MDAC  ,
  MDMO  LEFT OUTER JOIN VIEW_EMISOR ON morutemi = emrut 
		LEFT OUTER JOIN VIEW_MONEDA ON MDMO.momonemi = mncodmon
 WHERE 
  MDMO.morutcart=@nRutcart 
 AND MDMO.monumoper=@nNumoper
 AND MDMO.motipoper='RCA' 
 ORDER BY MDMO.mocorrela

--  REQ.7619 CASS 28-01-2011
--  FROM 
--  MDAC  ,
--  MDMO  , 
--  VIEW_EMISOR  ,
--  VIEW_MONEDA 
-- WHERE 
--  MDMO.morutcart=@nRutcart 
-- AND MDMO.monumoper=@nNumoper 
-- AND MDMO.motipoper='RCA' 
-- AND MDMO.morutemi*=emrut 
-- AND MDMO.momonemi*=mncodmon
-- ORDER BY MDMO.mocorrela
    
  /* Se Saca Valor Final Original del Archivo Historico 
 ================================================== */
 UPDATE  #TEMPORAL SET  mtorecompra  = (SELECT SUM(movalvenp) FROM MdMh WHERE monumoper=@nnumoper AND motipoper='VI')
 UPDATE  #TEMPORAL SET  montorca     = (SELECT SUM(movalvenp) FROM MDMO WHERE monumoper=@nnumoper AND motipoper='RCA')
 UPDATE  #TEMPORAL SET  diferencia   = mtoventa --ROUND( mtoventa/@valmon,4)
 UPDATE  #TEMPORAL SET  valorumrca   = CONVERT(FLOAT,ROUND(montorca/@valmon,4))
 SELECT @contador = 0 , 
  @contador2 = 0 ,
  @pagina  = 1
 
 WHILE @pagina <> NULL
 BEGIN
  SELECT @tipcart = '*'
  SET ROWCOUNT 1
  SELECT @tipcart = tipcart ,
   @contador = contador
  FROM #TEMPORAL
  WHERE contador>@contador
  ORDER BY contador
  SET ROWCOUNT 0
  IF @tipcart='*'
   BREAK
  SELECT @contador2 = @contador2 + 1
  UPDATE #TMP SET xpagina = @pagina WHERE contador=@Contador
  UPDATE #TMP SET xTotalPag = @pagina
  IF @contador2=@nTotPagina
   SELECT @pagina  = @pagina + 1 ,
    @contador2 = 0
 END
 
  SELECT 'nomemp' = nomemp ,  
  'rutemp' = rutemp ,  
  'fecpro' = fecpro ,
  'tipcart' = tipcart ,
  'fecemi' = Fecemi ,
  'numoper' = numoper ,
  'totalV' = Totalv ,     
  'forpai' = forpai ,
  'totalc' = Totalc ,
  'forpav' = forpav ,
  'tasapacto' = tasapacto ,
  'base'  = base  ,
  'dias'  = dias  ,
  'fecven' = fecven ,
  'correla' = correla ,
  'serie'  = serie  ,
  'nominal' = nominal ,
  'tasa'  = tasa  ,
  'total'  = total  ,
  'custodia' = Custodia ,
  'tipcli' = Tipcli ,
  'tipcon' = tipcon ,
  'rut'  = Rut  ,
  'codcli' = Codcli ,
  'nomcli' = Nomcli ,
  'dircli' = Dircli ,
  'fono'  = Fono  ,
  'faxcli' = Faxcli ,
  'observa' = Observa ,
  'nomope' = Nomope ,
  'Emisor' = emisor ,
  'Moneda' = moneda ,
  'MonPact' = Monpact ,
  'Fecha_Emi' = Fecha_Emi ,
  'Fecha_Ven' = Fecha_Ven ,
  'ValInip' = ValInip ,
  'ValVenp' = ValVenp ,
  'MtoVenta' = MtoVenta ,
  'MtoEscrito' = MtoEscrito ,
  'MtoRecompra' = MtoRecompra ,
  'Fec_Ven' = Fec_Ven ,      
  'diremp' = diremp ,
  'comemp' = comemp ,
  'comcli' = comcli ,
  'copia'  = copia  ,
  'xPagina' = xpagina ,
  'contador' = contador ,
  'numdocu' = numdocu ,
  'xTotalPag' = xtotalpag ,
  'linea1' = linea1 ,
  'fecharca' = fecharca ,
  'tasarca' = tasarca ,
  'montorca' = montorca ,
  'diferencia' = diferencia ,
  'fechainicial'  = fechainicial ,
  'plazoreal'     = plazoreal ,
  'valorumrca'    = valorumrca ,
  'numvista' = numvista ,
  'hora'  = hora         ,
  'Firma1'=@firma1 ,
  'Firma2'=@firma2	
 
 FROM #TEMPORAL
   
 SET NOCOUNT OFF
 RETURN
END
-- SP_PAPELETARCA 97018000, 46229,P
-- SP_PAPELETARCA 97024000, 31594,P
-- select * from mdCI where CINUMDOCU=13
-- select * from mdmo where monumoper=46229
                                                           
-- select * from gen_usuarios
-- SP_PAPELETARCA 78221830, ,P
-- SP_PAPELETARCA 78221830,78,P
-- SELECT * FROM MDCI
--- select * from VIEW_FORMA_DE_PAGO


GO
