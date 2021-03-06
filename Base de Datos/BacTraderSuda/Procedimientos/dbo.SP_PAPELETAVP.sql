USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETAVP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PAPELETAVP]	(	@nRutcart	FLOAT  
					,	@nNumoper	FLOAT
					,	@cTipoImp	CHAR(01)
					,	@cTipoper	CHAR(02)	= ''
					,	@Cat_CartFin	CHAR(10)
					,	@Cat_CartNorm	CHAR(10)
					,	@Cat_Libro	CHAR(10)
					)
AS
BEGIN

/*=======================================================================*/
 DECLARE @firma1 char(15)
 DECLARE @firma2 char(15)

	  Select @firma1=res.Firma1,
		 @firma2=res.Firma2
	   From BacLineas.dbo.detalle_aprobaciones res
	   Where res.Numero_Operacion=@nNumoper
/*=======================================================================*/


 SET NOCOUNT ON
 DECLARE   @cFecEmi    VARCHAR (40) ,
           @nDiaSem    INTEGER  ,  
           @nDia       INTEGER  ,
           @nMes       INTEGER  ,
           @nAnn       INTEGER  ,
           @tipcart    CHAR (25) ,
           @Forpa      CHAR (25) ,
           @Tipocli    CHAR (25) ,
           @Tipcli     NUMERIC (05) ,
           @Tipret     CHAR (15) ,
           @Rutcli     NUMERIC (9,0) ,
           @Codcli     NUMERIC (9,0) ,
           @Nomcli     CHAR (40) ,
           @Dircli     CHAR (40) ,
           @Foncli     CHAR (15) ,
           @Faxcli     CHAR (15) ,
           @Obser      CHAR (70) ,
           @Nomoper    CHAR (40) ,
           @DigVeri    CHAR (01) ,
           @Nompro     CHAR (40) ,
           @Dirpro     CHAR (40) ,
           @Rutpro     CHAR (12) ,
           @Fecpro     CHAR (10) ,
           @Total      NUMERIC (19,2) ,
           @Cust       CHAR (20) ,
           @NumSol     NUMERIC (9,0) ,
           @linea1     CHAR (255) ,
           @linea2     CHAR (255) ,
           @linea3     CHAR (255) ,
           @linea4     CHAR (255) ,
           @linea5     CHAR (255) ,
           @glocopia   CHAR (25) ,
           @nCopia     INTEGER  ,
           @Pagina     INTEGER  ,
           @nTotPagina INTEGER  ,
           @contador   NUMERIC (19,0) ,
           @contador2  NUMERIC (19,0) ,
           @nMtoComi   NUMERIC (19,0) ,
           @fComision  FLOAT  ,
           @nIva       NUMERIC (19,0) ,
           @hora       CHAR (08) ,
           @cSettlement CHAR (50) ,
           @cPFE       CHAR (50) ,
           @cCCE       CHAR (50) ,
           @cEmisorInstPlazo CHAR (255) ,
           @MtoEsc     VARCHAR (170) ,
           @EstadoPeracion VARCHAR (100),
           @CodMon        Numeric(3) ,
	   @Fecprox	  DATETIME 

 SELECT 'ACfecproc' = acfecproc,
        'ACfecprox' = acfecprox,
        'uf_hoy'    = CONVERT(FLOAT, 0),
        'uf_man'    = CONVERT(FLOAT, 0),
        'ivp_hoy'   = CONVERT(FLOAT, 0),
        'ivp_man'   = CONVERT(FLOAT, 0),
        'do_hoy'    = CONVERT(FLOAT, 0),
        'do_man'    = CONVERT(FLOAT, 0),
        'da_hoy'    = CONVERT(FLOAT, 0),
        'da_man'    = CONVERT(FLOAT, 0),
        'pmnomprop' = acnomprop,
        'pmnomprop2' = acnomprop,
        'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop))+'-'+acdigprop,
	'Firma1'=@firma1,
	'Firma2'=@firma2
 INTO #PARAMETROS
 FROM MDAC

 SELECT @Fecprox = acfecprox FROM MDAC

 UPDATE #PARAMETROS
    SET uf_hoy = ISNULL(vmvalor,0.0)
    FROM VIEW_VALOR_MONEDA
    WHERE vmfecha = acfecproc AND vmcodigo = 998
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
 SET da_man = ISNULL(vmvalor, 0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecprox AND vmcodigo=995
 IF @cTipoImp='P'
  SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=@nNumoper
 ELSE
  SELECT @nCopia = paconimp FROM MDPA WHERE panumoper=@nNumoper
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
 IF @cTipoImp='P'
     SELECT @nTotPagina = 16
 ELSE
     SELECT @nTotPagina = 23
 SELECT @Total = (SELECT SUM(ROUND(movalven,2))
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper=@cTipoper)

 SELECT Distinct @tipcart =  IsNull(rcnombre,'')
 FROM BacParamSuda.dbo.TIPO_CARTERA, MDMO
 WHERE rcsistema = 'BTR' And rcrut = motipcart AND monumoper=@nNumoper AND 
	morutcart=@nRutcart AND motipoper=@cTipoper

 SELECT @Forpa = glosa
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagi AND monumoper=@nNumoper AND morutcart=@nRutcart AND
  motipoper=@cTipoper
 SELECT @Obser     = ISNULL(moobserv,'')     ,
        @linea1    = ISNULL(moobserv2,'')     ,
        @nDiaSem   = DATEPART(WEEKDAY,mofecpro)    ,
        @nDia      = DATEPART(DAY,mofecpro)    ,
        @nMes      = DATEPART(MONTH,mofecpro)    ,
        @nAnn      = DATEPART(YEAR,mofecpro)    ,
        @NumSol    = monsollin      ,
        @Rutcli    = morutcli      ,
        @codcli    = mocodcli      ,
        @Tipret    = CASE motipret
                          WHEN 'I' THEN 'VIENEN'
                      ELSE 'VAMOS'
                     END       ,
        @Nompro    = ISNULL(acnomprop,'')     ,
        @Dirpro    = ISNULL(acDirprop,'')     ,
        @Rutpro    = STR(acrutprop)+'-'+acdigprop    ,
        @Fecpro    = CONVERT(CHAR(10),acfecproc,103)   ,
        @Nomoper   = nombre      ,
        @nMtoComi  = ISNULL(momtocomi,0)     ,
        @fComision = accomision/CONVERT(FLOAT,100)    ,
        @nIva      = ISNULL(momtocomi,0)     ,
        @hora      = mohora      ,
        @EstadoPeracion = CASE mostatreg
                             WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION'
                            ELSE ''
                          END ,
        @CodMon         = momonemi
 FROM MDMO, VIEW_USUARIO, MDAC
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper=@cTipoper AND
  mousuario=SUBSTRING(usuario,1,12)
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
  
 SELECT @Nomcli  = clnombre  ,
        @Dircli  = cldirecc  ,
        @Foncli  = clfono  ,
        @Faxcli  = clfax   ,
        @Tipcli  = cltipcli  ,
        @Digveri = ISNULL(cldv,' ')
 FROM VIEW_CLIENTE
 WHERE clrut=@rutcli AND clcodigo=@codcli
 IF @nMtoComi=0
     SELECT @nIva        = 0 ,
            @nMtoComi    = 0 ,
            @fComision   = 0
 SELECT @Tipocli    = tbglosa   ,
        @nMtoComi = ROUND(@Total*@fComision,0)
 FROM VIEW_TABLA_GENERAL_DETALLE
 WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)

	DECLARE @iUmOpe	NUMERIC	(03)
	SELECT	@iUmOpe	= CASE
				WHEN @CodMon=13 THEN @CodMon
				ELSE 999
			  END

 EXECUTE SP_MONTOESCRITO_MONEDA @Total, @MtoEsc OUTPUT, @iUmOpe
 CREATE TABLE #paso_error ( Mensaje_Error VARCHAR(255),
                             Monto  NUMERIC(19,4),
                             sw  CHAR(1),
                             NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1))

 DECLARE @NumeroCorre_Detalle INTEGER
 DECLARE @nMontoError         NUMERIC(19,4)
 DECLARE @cMontoFMT           CHAR(20)
 WHILE 1=1
 BEGIN
  SET ROWCOUNT 1
  SELECT @NumeroCorre_Detalle = 0
  SELECT @NumeroCorre_Detalle = NumeroCorre_Detalle,
         @nMontoError         = Monto
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

 IF EXISTS(SELECT Operador_Ap_LINEAS FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)
 BEGIN
  SELECT @EstadoPeracion = CASE Estado
      WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
      Else ''
      END
  FROM view_aprobacion_operaciones,
       mdac
  WHERE id_sistema = 'BTR'
  AND NumeroOperacion = @nNumoper
  AND FechaOperacion = acfecproc
 END
 SELECT 'cNompro'    = ISNULL(@Nompro,'')        ,
        'nRutpro'    = ISNULL(@Rutpro,'')        ,
        'dFecpro'    = ISNULL(@Fecpro,'')        ,
        'TipoCart'   = ISNULL(( SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_CartFin AND TBCODIGO1 = MOTIPCART),'') , --ISNULL(@Tipcart,'')       ,
        'fecemi'     = ISNULL(@cFecemi,'')       ,
        'n„oper'     = ISNULL(monumoper,0)    ,
        'TotalG'     = ISNULL(@Total,0)          ,  
        'fpago'      = ISNULL(@Forpa,'')         ,
        'Correla'    = ISNULL(mocorrela,0)       ,
        'I_Seri'     = ISNULL(moinstser,'')      ,
        'Nominal'    = ISNULL(monominal,0)       ,
        'TIR'     = ISNULL(motir,0)           ,
        'MtPs'       = ISNULL(movalven,0)        ,
        'Custodia'   = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END ,
        'Tipcli'     = ISNULL(@TipoCli,'')       ,
        'Tipret'     = ISNULL(@Tipret,'')        ,
        'Rutcli'     = STR(@Rutcli)+'-'+@Digveri ,
        'Codcli'     = ISNULL(CONVERT(CHAR(9),@Codcli),'')   ,
        'Nomcli'     = ISNULL(@Nomcli,'')        ,
        'Dircli'     = ISNULL(@Dircli,'')        ,
        'Foncli'     = ISNULL(@FonCli,'')        ,
        'Faxcli'     = ISNULL(@Faxcli,'') ,
        'Obser'      = ISNULL(@Obser,'')         ,
        'Operador'   = ISNULL(@Nomoper,'')       ,
        'Emisor'    = CASE WHEN mocodigo = 98 THEN ( SELECT clgeneric FROM view_cliente WHERE clrut=morutcli AND clcodigo=mocodcli )
                          ELSE ( SELECT emgeneric FROM view_emisor WHERE emrut=morutemi )
                       END       ,
        'Moneda'     = ISNULL(mnnemo,'')         ,  
        'Linea1'     = ISNULL(@linea1,'')        ,
        'Linea2'     = ISNULL(@linea2,'')        ,
        'Linea3'     = ISNULL(@linea3,'')        ,
        'Linea4'     = ISNULL(@linea4,'')        ,
        'Linea5'     = ISNULL(@linea5,'')        ,
        'vpb'        = ISNULL(mopvp,0)           ,
        'vpc'        = ISNULL(movpar,0)          ,
        'cDirpro'    = ISNULL(@Dirpro,'')        ,
        'Copia'      = ISNULL(@glocopia,'')      ,
        'Pagina'     = 0                         ,
        'contador'   = ISNULL(mocorvent,0)       ,
        'numdocu'    = ISNULL(monumdocu,0)       ,
        'Totalpag'   = 0                         ,
        'comision'   = @nMtoComi                 ,
        'iva'        = @nIva-@nMtoComi           ,
        'vvcomi'     = ISNULL(movviscom,0)       ,
        'hora'       = @hora                     ,
        'clavedcv'   = moclave_dcv               ,
        'Lim_Settle' = @cSettlement              ,
        'Fecha_inicio' = CONVERT(CHAR(10),mofecemi,103)    ,
        'Fecha_vencim' = CONVERT(CHAR(10),mofecven,103)   ,
        'MtoEscrito'   = @MtoEsc                ,
        'EstadoPeracion'= @EstadoPeracion       ,
        'Tipo_cartera'    = codigo_carterasuper,
	'Firma1'=@firma1,
	'Firma2'=@firma2,
--        'PagoMañana'     = case when Fecha_PagoMañana >= @Fecprox then 'Operación Pago Mañana' else ' ' end 
        'PagoMañana'     = case when Fecha_PagoMañana = @Fecprox then 'Operación Pago Mañana' 
								when Fecha_PagoMañana > @Fecprox then 'Operación T+2' 
							else ' ' end 
,	'Nombre_CartSuper'	= ISNULL(( SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_CartNorm AND TBCODIGO1 = codigo_carterasuper),'')
,	'Codigo_Libro'		= id_libro  
,	'Nombre_Libro'		= ISNULL(( SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_Libro AND TBCODIGO1 = id_libro),'')
       	INTO #TEMP
	FROM MDMO LEFT OUTER JOIN VIEW_MONEDA ON
	momonemi = mncodmon
       	WHERE monumoper = @nNumoper
        AND    morutcart = @nRutcart
        AND    motipoper = @cTipoper
	ORDER BY mocorrela
/*
       FROM MDMO, VIEW_MONEDA
       WHERE monumoper = @nNumoper
             AND    morutcart = @nRutcart
             AND    motipoper = @cTipoper
             AND    momonemi*=mncodmon
       ORDER BY mocorrela
*/
 SELECT @contador = 0 ,
        @contador2 = 0 ,
        @pagina  = 1
 WHILE @pagina<>0
 BEGIN
  SET ROWCOUNT 1
  SELECT @nompro   = '*'
  SELECT @nompro   = cNompro ,
         @contador = contador
  FROM #TEMP
  WHERE contador>@contador
  ORDER BY contador 
  SET ROWCOUNT 0
  IF @nompro='*'
   BREAK
  SELECT @contador2 = @contador2 + 1
  UPDATE #TEMP SET pagina   = @pagina WHERE contador=@Contador
  UPDATE #TEMP SET TotalPag = @pagina 
  IF @contador2=@nTotPagina
   SELECT  @pagina    = @pagina + 1   ,
           @contador2 = 0
  END
 
 SET NOCOUNT OFF
 SELECT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #TEMP, #PARAMETROS
 RETURN
END
GO
