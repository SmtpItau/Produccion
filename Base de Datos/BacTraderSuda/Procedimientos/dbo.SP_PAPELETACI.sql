USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETACI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_PAPELETACI 97023000, 186127, 'P', 1111, 1552

CREATE PROCEDURE [dbo].[SP_PAPELETACI]	(	
      @nRutcart FLOAT   
     , @nNumoper FLOAT   
     , @cTipoImp CHAR(01)   
     , @Cat_CartNorm CHAR(10)  
     , @Cat_Libro CHAR(10)   
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



/*=======================================================================*/  

	DECLARE @NomEntidad		VARCHAR(100)

	DECLARE @RutEntidad		NUMERIC(12)

	DECLARE	@DvEntidad		VARCHAR(1)

	DECLARE @CodEntidad		VARCHAR(2)

	DECLARE	@DirecEntidad	VARCHAR(100)

	DECLARE @FonoEntidad	VARCHAR(14)

	DECLARE @ComunaEntidad	VARCHAR(30)

	DECLARE @CiudadEntidad	VARCHAR(30)
	
	DECLARE @ImagenContrato	VARBINARY(MAX)


   	SELECT 

			@NomEntidad		=	RazonSocial	

	,		@RutEntidad		=	RutEntidad	

	,		@DvEntidad		=	DigitoVerificador

	,		@CodEntidad		=   CodigoEntidad

	,		@DirecEntidad	=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad

	,		@FonoEntidad	=	TelefonoLegal

	,		@ComunaEntidad  =	Comuna

	,		@CiudadEntidad  =	Ciudad
	
	,		@ImagenContrato =	bannerlargoContrato

	FROM bacparamsuda..Contratos_ParametrosGenerales
	/*=======================================================================*/  



  
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
  @rutpro  CHAR (13) ,  
  @comemp  CHAR (25) ,  
  @Diremp  CHAR (40) ,  
  @fecpro  CHAR (10) ,  
  @Totalc  NUMERIC (19,2) ,  
  @Totalv  NUMERIC (19,4) ,  
  @monpac  CHAR (05) ,  
  @monpacto NUMERIC (03,0) ,  
  @monglo  CHAR (20) ,  
  @mtoesc  CHAR (170) ,  
  @Obser  CHAR (60) ,  
  @valmon  NUMERIC (19,4) ,  
  @NumSol  NUMERIC (9,0) ,  
  @linea1  CHAR (255) ,  
  @linea2  CHAR (255) ,  
  @linea3  CHAR (255) ,  
  @linea4  CHAR (255) ,  
  @linea5  CHAR (255) ,  
  @glocopia CHAR (25) ,  
  @nCopia  INTEGER  ,   
  @Pagina  INTEGER  ,  
  @nTotPagina INTEGER  ,  
  @contador NUMERIC (19,0) ,  
  @contador2 NUMERIC (19,0) ,  
  @hora  CHAR (8) ,  
  @cSettlement CHAR (50) ,  
  @cPFE  CHAR (50) ,  
  @cCCE  CHAR (50) ,  
  @cEmisorInstPlazo CHAR (255) ,  
  @EstadoPeracion VARCHAR (100) ,  
  @TotalP  NUMERIC (19,4) ,  
  @ValmonEmi NUMERIC (19,4),  
  @nTipCam FLOAT,  
  @nRodon  INTEGER,  
  @cMonMx  CHAR(01),  
  @Codigo_Cliente INTEGER  
  
  DECLARE @xMensajeBloqueos			VARCHAR(100)
	SET @xMensajeBloqueos				= ISNULL(( SELECT Mensaje_Error FROM BacLineas.dbo.LINEA_TRANSACCION_DETALLE
												WHERE Id_Sistema = 'BTR' AND NumeroOperacion = @nNumoper
												AND Error = 'S'
												AND Linea_Transsaccion = 'BLQCLI' ), '')

  
 SELECT 'acfecproc' = acfecproc,  
        'acfecprox' = acfecprox,  
        'uf_hoy'    = CONVERT(FLOAT, 0),  
        'uf_man'    = CONVERT(FLOAT, 0),  
        'ivp_hoy'   = CONVERT(FLOAT, 0),  
        'ivp_man'   = CONVERT(FLOAT, 0),  
        'do_hoy'    = CONVERT(FLOAT, 0),  
        'do_man'    = CONVERT(FLOAT, 0),  
        'da_hoy'    = CONVERT(FLOAT, 0),  
        'da_man'    = CONVERT(FLOAT, 0),  
        'acnomprop' = acnomprop,  
        'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop,  
        'Firma1'= @firma1 ,  
        'Firma2'= @firma2  
  
 INTO #PARAMETROS  
 FROM MDAC  
/* RESCATA VALOR DE UF -------------------------------------------------------------- */  
    
        UPDATE #PARAMETROS SET uf_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
                  FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
                 WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc  
                   AND VIEW_VALOR_MONEDA.vmcodigo = 998  
 UPDATE #PARAMETROS SET uf_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox  
                 AND VIEW_VALOR_MONEDA.vmcodigo = 998  
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */  
 UPDATE #PARAMETROS SET ivp_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc  
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997  
 UPDATE #PARAMETROS SET ivp_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox  
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997  
/* RESCATA VALOR DE DO -------------------------------------------------------------- */  
 UPDATE #PARAMETROS SET do_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc  
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994  
 UPDATE #PARAMETROS SET do_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox  
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994  
/* RESCATA VALOR DE DA -------------------------------------------------------------- */  
 UPDATE #PARAMETROS SET da_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc  
           AND VIEW_VALOR_MONEDA.vmcodigo = 995  
 UPDATE #PARAMETROS SET da_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
            WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox  
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995  
 IF @cTipoImp='P'  
 BEGIN  
  SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=@nNumoper  
  SELECT @glocopia = CASE WHEN @nCopia=1 THEN  'COPIA MESA'  
      WHEN @nCopia=2 THEN 'COPIA INVERSIONES'  
      WHEN @nCopia=3 THEN 'COPIA CUSTODIA'  
      ELSE ' '  
       END  
 END  
 ELSE  
 BEGIN  
  SELECT @nCopia = paconimp FROM MDPA WHERE panumoper=@nNumoper  
  SELECT @glocopia = CASE WHEN @nCopia = 1 THEN 'ORIGINAL CLIENTE'  
      WHEN @nCopia = 2 THEN 'COPIA CLIENTE'  
      ELSE ' '  
       END  
 END  
 IF @cTipoImp='P'  
  SELECT @nTotPagina = 12  
 ELSE  
  SELECT @nTotPagina = 10  
-- VGS  
 SET ROWCOUNT 1  
 SELECT @nTipCam = CASE WHEN momonpact = 999 THEN 1   
   ELSE momtoPFE END, -- En este campo guardo el tipo de cambio que se ingresa en las pantallas de pactos  
--   WHEN momonpact = 13 THEN (SELECT do_hoy FROM #PARAMETROS)  
--   ELSE vmvalor END,  
 @nRodon = CASE  WHEN momonpact = 999 THEN 0  
   WHEN momonpact = 13 THEN 2  
   ELSE 4  
   END  
  FROM MDMO LEFT OUTER JOIN VIEW_VALOR_MONEDA ON momonpact = vmcodigo AND mofecinip = vmfecha  
  WHERE monumoper=@nNumoper   
  AND morutcart=@nRutcart AND  
  motipoper='CI'   
  
-- REQ.7616 CASS 25-01-2011  
-- FROM MDMO,VIEW_VALOR_MONEDA  
-- WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND  
--  motipoper='CI' AND  
--  momonpact *= vmcodigo AND  
--  mofecinip *= vmfecha  
  
 SET ROWCOUNT 0  
  
 SELECT @cMonMx = mnmx   
 FROM MDMO,View_Moneda   
 Where monumoper=@nNumoper AND morutcart=@nRutcart AND  
  motipoper='CI' AND  
  momonpact = mncodmon  
  
 SELECT @Totalc  = CASE WHEN @cMonMx = 'C' And MIN(momonpact) = 13 THEN sum(movalinip) --sum(movalcomp)   
     WHEN @cMonMx = 'C' And MIN(momonpact) <> 13 THEN ROUND(sum(movalinip)/@nTipCam,@nRodon)  
   ELSE sum(movalinip)  
         END,  
  @Totalv  = SUM(movalvenp) ,  
  @TotalP  = CASE WHEN @cMonMx = 'C' And MIN(momonpact) = 13 THEN sum(movalinip) --sum(movalcomp)   
    WHEN @cMonMx = 'C' And MIN(momonpact) <> 13 THEN ROUND(sum(movalinip)/@nTipCam,@nRodon)  
  ELSE sum(movalinip)  -- Round(sum(movalinip)/@nTipCam,@nRodon)  
      END  
 FROM MDMO  
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND  
  motipoper='CI'  
  
  
 SELECT @tipcart = tbglosa   
 FROM VIEW_TABLA_GENERAL_DETALLE, MDMO  
 WHERE tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)=motipcart AND monumoper=@nNumoper AND  
  morutcart=@nRutcart AND motipoper='CI'  
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecinip) ,  
  @nDia  = DATEPART(DAY,mofecinip) ,  
  @nMes  = DATEPART(MONTH,mofecinip) ,  
  @nAnn  = DATEPART(YEAR,mofecinip)  
 FROM MDMO  
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CI'  
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
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecvenp)  ,  
  @nDia  = DATEPART(DAY,mofecvenp)  ,  
  @nMes  = DATEPART(MONTH,mofecvenp),  
  @nAnn  = DATEPART(YEAR,mofecvenp),  
  @EstadoPeracion = CASE mostatreg  
              WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION'  
     ELSE ''  
      END   
 FROM MDMO  
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CI'  
 IF @nMes= 1 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)  
 IF @nMes= 2 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)  
 IF @nMes= 3 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Marzo de ' +CONVERT(CHAR(4),@nAnn)  
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
 SELECT @Forpai = glosa   
 FROM VIEW_FORMA_DE_PAGO, MDMO  
 WHERE codigo=moforpagi AND monumoper=@nNumoper AND morutcart=@nRutcart AND  
  motipoper='CI'  
 SELECT @Forpav = glosa   
 FROM VIEW_FORMA_DE_PAGO, MDMO  
 WHERE codigo=moforpagv AND monumoper=@nNumoper AND morutcart=@nRutcart AND  
  motipoper='CI'  
 SELECT @Cust = mocondpacto ,  
  @Obser  = moobserv ,  
  @NumSol = monsollin ,  
  @Rutcli = morutcli ,  
  @Ret = motipret ,  
  @hora = mohora,  
  @Codigo_Cliente = mocodcli  
 FROM MDMO  
        WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CI'  
 IF @Cust='S'  
  SELECT @Custodia = 'Con Custodia'  
 ELSE  
  SELECT @Custodia = 'Sin Custodia'  
            
 SELECT @Nomcli = clnombre ,  
  @Dircli = cldirecc ,  
  @Foncli = clfono ,  
  @Faxcli = clfax  ,  
  @Codcli = clcodigo ,  
  @Tipcli = cltipcli ,  
         @Dig    = cldv   
 FROM VIEW_CLIENTE, VIEW_TABLA_GENERAL_DETALLE  
 WHERE clrut=@Rutcli  
   AND Clcodigo=@Codigo_Cliente  
 SELECT @Comcli = ISNULL(view_ciudad_comuna.nom_ciu,'')  
 FROM VIEW_CLIENTE, VIEW_CIUDAD_COMUNA  
 WHERE clrut=@Rutcli AND cod_ciu=clciudad AND cod_com=clcomuna  
 SELECT @Tipocli = tbglosa   
 FROM VIEW_TABLA_GENERAL_DETALLE  
 WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)  
 SELECT @Nomoper = nombre  
 FROM VIEW_USUARIO, MDMO  
 WHERE mousuario=SUBSTRING(usuario,1,12) AND morutcart=@nRutcart AND monumoper=@nNumoper AND  
  motipoper='CI'  
 IF @Ret='V'  
  SELECT @Retiro = 'Vamos'  
 ELSE  
  SELECT @Retiro = 'Vienen'  

 SELECT @comemp = ISNULL(accomprop,'')      ,  
  @fecpro = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')  
 FROM MDAC  
        SELECT  @Nomemp   = rcnombre,  
                @Rutpro   = RTRIM(CONVERT(CHAR(9),rcrut)) +'-'+rcdv ,  
         @Diremp   = rcdirecc  
 FROM  VIEW_ENTIDAD  
 WHERE rcrut=@nRutcart  

 --//* fusion *//
  SET  @Nomemp  = ISNULL(@NomEntidad,'')     
  SET	@Rutpro		=	(SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, @RutEntidad), 1), '.00', ''), ',','.'))) + '-' + ltrim(rtrim(@DvEntidad)) ) 
  SET   @Diremp  = ISNULL(@DirecEntidad,'')     
 
 SELECT @Monpac  = mnnemo ,  
  @Monpacto  = momonpact  
 FROM VIEW_MONEDA, MDMO  
 WHERE morutcart=@nRutcart AND monumoper=@nNumoper AND motipoper='CI' AND momonpact=mncodmon  
 IF @monpacto=999 SELECT @monglo = 'PESOS'  
 IF @monpacto=998 SELECT @monglo = 'UNIDADES DE FOMENTO'  
 IF @monpacto=994 SELECT @monglo = 'DOLARES'  
 IF @monpacto=995 SELECT @monglo = 'DOLARES'  
 SELECT @valmon = vmvalor  
 FROM VIEW_VALOR_MONEDA, MDMO  
 WHERE vmcodigo=momonpact AND vmfecha=mofecinip AND monumoper=@nNumoper AND  
  morutcart=@nRutcart AND motipoper='CI'  
 IF @valmon=NULL  
         SELECT @valmon = 1  
  
 EXECUTE Sp_Montoescrito_moneda @TotalC, @Mtoesc OUTPUT, @monpacto  
-- EXECUTE Sp_Papeleta_Limites 'CI'    ,  
--     @nNumoper   ,  
--     @cSettlement  OUTPUt ,  
--     @cPFE   OUTPUT ,  
--     @cEmisorInstPlazo OUTPUT ,  
--     @cCCE   OUTPUT  
 CREATE TABLE #paso_error ( Mensaje_Error VARCHAR(255),  
     Monto  NUMERIC(19,4),  
     sw  CHAR(1),  
     NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1))  
 INSERT INTO #paso_error  
 SELECT Mensaje_Error, MontoExceso, 'N'  
 FROM view_linea_transaccion_detalle  
 WHERE NumeroOperacion = @nnumoper  
 AND id_sistema = 'BTR'  
 AND Mensaje_Error <> ''  
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
 SELECT @linea1 = Mensaje_Error FROM #PASO_ERROR WHERE NumeroCorre_Detalle = 1  
 SELECT @linea2 = Mensaje_Error FROM #PASO_ERROR WHERE NumeroCorre_Detalle = 2  
 SELECT @linea3 = Mensaje_Error FROM #PASO_ERROR WHERE NumeroCorre_Detalle = 3  
 IF EXISTS(SELECT operador_ap_LINEAS FROM VIEW_APROBACION_OPERACIONES, MDAC WHERE id_sistema='BTR' AND NumeroOperacion=@nNumoper AND FechaOperacion=acfecproc)  
 BEGIN  
  SELECT @EstadoPeracion = CASE Estado  
--      WHEN 'A' THEN 'OPERACION APROBADA POR :   '  + Operador_Ap_LINEAS  
      WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS  
      ELSE ''  
       END  
  FROM VIEW_APROBACION_OPERACIONES, MDAC  
  WHERE id_sistema='BTR' AND NumeroOperacion=@nNumoper AND FechaOperacion=acfecproc  
 END  
 SELECT 'nomemp'       = ISNULL(@nomemp,'')      ,  
        'rutemp'       = ISNULL(@rutpro,'')      ,  
        'fecpro'       = ISNULL(@fecpro,'')      ,  
        'tipcart'      = ISNULL(@tipcart,'')      ,  
        'fecemision'   = ISNULL(@cFecEmi,'')      ,  
        'numoper'      = ISNULL(monumoper,0)      ,  
        'totalc'       = ISNULL(@Totalc,0)      ,  
        'forpai'       = ISNULL(@forpai,'')       ,  
        'totalv'       = ROUND(ISNULL(movalvenp,0),@nRodon)      ,  
        'forpav'       = ISNULL(@forpav,'')       ,  
        'tasapacto'    = ISNULL(motaspact,0)       ,  
        'base'         = ISNULL(mobaspact,0)      ,  
        'plazo'        = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)   ,  
        'fecvto'       = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')   , -- mofecven  
        'correla'      = ISNULL(mocorrela,0)      ,  
        'serie'        = ISNULL(moinstser,'')      ,  
        'emisor'       = ISNULL(emgeneric,'')      ,  
        'Moneda'       = ISNULL(a.mnnemo,'')      ,  
        'nominal'      = ISNULL(monominal,0)      ,  
        'tasa'         = ISNULL(motir,0)      ,  
        'total'        = CASE WHEN @cTipoImp = 'P' THEN (CASE WHEN @cMonMx = 'C' And momonpact = 13 THEN ROUND(movalinip*@nTipCam,0)  
             ELSE ISNULL(movalinip,0) END)  
  
         ELSE (CASE WHEN @cMonMx = 'C' And momonpact = 13 THEN movalinip --sum(movalcomp)   
         WHEN @cMonMx = 'C' And momonpact <> 13 THEN ROUND(movalinip/@nTipCam,@nRodon)  
       ELSE movalinip END)  
--(CASE WHEN momonemi = 13 THEN ISNULL(ROUND(movpresen*do_hoy,0),0) ELSE ISNULL(movpresen,0) END)   
    END,  
        'Custodia'     = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END ,  
        'tipcli'       = ISNULL(@Tipocli,'')      ,  
        'tipret'       = ISNULL(@Retiro,'')      ,  
        'rutcli'       = ISNULL(RTRIM (CONVERT(CHAR(09),@Rutcli))+'-'+@Dig,'')  ,  
        'codcli'       = ISNULL(@Codcli,0)      ,  
        'nomcli'       = ISNULL(@Nomcli,'')      ,  
        'dircli'       = ISNULL(@Dircli,'')      ,  
        'foncli'       = ISNULL(@Foncli,'')      ,  
        'faxcli'       = ISNULL(@Faxcli,'')      ,  
        'observa'      = ISNULL(@Obser,'')      ,  
        'nomope'       = ISNULL(@Nomoper,'')      ,  
        'Monpacto'     = ISNULL(@monpac,'')      ,  
        'Fec_emi'      = ISNULL(CONVERT(CHAR(10),mofecemi,103),'')   ,  
        'Fec_ven'      = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')   ,  
        'Mtoesc'       = ISNULL(SUBSTRING(@mtoesc,1,120),'')    ,  
        'Fec_Compra'   = ISNULL(CONVERT(CHAR(10),mofecinip,103),'')   ,  
        'sFecven'      = ISNULL(@cFecven,'')      ,  
        'comcli'       = ISNULL(@monglo,'')      ,  
        'comemp'       = ISNULL(@comemp,'')      ,  
        'Diremp'       = ISNULL(@diremp,'')      ,  
        'Linea1'       = ISNULL(@linea1,'')      ,  
        'Linea2'       = ISNULL(@linea2,'')      ,  
        'Linea3'       = ISNULL(@linea3,'')      ,  
        'Linea4'       = ISNULL(@xMensajeBloqueos,'')      ,
        'Linea5'       = ISNULL(@linea5,'')      ,  
        'copia'        = ISNULL(@glocopia,'')    ,  
        'Pagina'       = 0                       ,  
        'contador'     = ISNULL(mocorrela,0)     ,  
        'vvista'       = ISNULL(movvista,0)      ,  
        'TotalPag'     = 0                       ,  
        'Hora'         = @Hora                   ,  
        'clave_dcv'    = moclave_dcv             ,  
        'Lim_Settle'   = @cSettlement            ,  
        'Lim_PFE'      = @cPFE                   ,  
        'Lim_CCE'      = @cCCE                   ,  
        'Valor Par'    = mopvp                   ,  
        'EstadoPeracion'= @EstadoPeracion        ,  
        'TotalCompraClp'= @TotalP                ,  
        'Valor Compra UM'= CASE WHEN momonpact = 13 AND momonemi = 13 THEN  movalcomp  
    ELSE movalcomp/( CASE WHEN momonemi = 999 Or momonemi = 13 THEN 1   
--               WHEN momonemi = 13 THEN (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=mofecpro)   
                                             ELSE (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonemi AND vmfecha=mofecpro)   
                                                 END)  
       END,  
        'CtaCteInicio' = Cuenta_Corriente_Inicio ,  
        'CtaCteFinal' = Cuenta_Corriente_Final   ,  
        'Tipo_cartera'    = codigo_carterasuper  ,  
        'MonedaMx' = ISNULL(b.mnmx,' ')  ,  
        'totalini' = CASE WHEN @cMonMx = 'C' And momonpact = 13 THEN movalinip --sum(movalcomp)   
    WHEN @cMonMx = 'C' And momonpact <> 13 THEN ROUND(movalinip/@nTipCam,@nRodon)  
  ELSE movalinip END,  
        'Tipo_Cambio' = momtoPFE,  
        'Firma1'= @firma1 ,  
        'Firma2'= @firma2   
, 'Nombre_CartSuper' = ISNULL(( SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_CartNorm AND TBCODIGO1 = codigo_carterasuper),'')  
, 'Codigo_Libro'  = mdmo.id_libro    
, 'Nombre_Libro'  = ISNULL(( SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_Libro AND TBCODIGO1 = mdmo.id_libro),'')  
 INTO #TEMP  
 FROM MDAC, MDMO, VIEW_EMISOR , VIEW_MONEDA a,#PARAMETROS , VIEW_MONEDA b  
 WHERE morutcart  =   @nRutcart AND monumoper  = @nNumoper AND motipoper='CI'  
  AND  morutemi   =   emrut     AND momonemi   = a.mncodmon  
  AND  momonpact = b.mncodmon  
 ORDER BY mocorrela  
  
 SELECT @contador    = 0 ,  
        @contador2   = 0 ,  
        @pagina      = 1  
 WHILE @pagina<>0  
 BEGIN  
    
  SET  @tipcart = '*'  
  SET ROWCOUNT 1  
  SELECT  @tipcart = tipcart ,  
          @contador = contador  
  FROM #TEMP  
  WHERE contador > @contador  
  ORDER BY contador  
  
  SET ROWCOUNT 0  
  IF @tipcart='*'  
   BREAK  
  SELECT @contador2 = @contador2 + 1  
  UPDATE #TEMP SET pagina = @pagina WHERE contador=@Contador  
  UPDATE #TEMP SET TotalPag=@pagina  
  IF @contador2=@nTotPagina  
      SELECT @pagina   = @pagina + 1 ,  
            @contador2 = 0  
 END  
 SET NOCOUNT OFF  
 SELECT * FROM #Temp, #PARAMETROS  
END

GO
