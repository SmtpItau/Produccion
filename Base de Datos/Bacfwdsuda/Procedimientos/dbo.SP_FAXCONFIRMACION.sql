USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FAXCONFIRMACION]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FAXCONFIRMACION]
	(	@nNumOper   FLOAT
	,	@Usuario	CHAR(20) = ''
	)
AS  

BEGIN  
  

   SET NOCOUNT ON    

   DECLARE @cTraCon     CHAR(40)  
   DECLARE @cVendedor   CHAR(70)  
   DECLARE @cFaxVen     CHAR(20)  
   DECLARE @cOpeVen     CHAR(40)  
   DECLARE @cComprador  CHAR(70)  
   DECLARE @cFaxCom     CHAR(20)  
   DECLARE @cOpeCom     CHAR(40)  
   DECLARE @cTipOpe     CHAR(10) 
   DECLARE @nPreSpt     NUMERIC(16,10)
   DECLARE @nObsIni     NUMERIC(08,02)
   DECLARE @nUFIni      NUMERIC(08,02) 
   DECLARE @dFecIni     DATETIME  
   DECLARE @nCodMon     NUMERIC(03,00) 
   DECLARE @nCodCnv     NUMERIC(03,00)  
   DECLARE @cCodMon     CHAR(03)  
   DECLARE @cCodCnv     CHAR(03)  
   DECLARE @nPagoMx     NUMERIC(05,00)
   DECLARE @cPagoMx     CHAR(10)  
   DECLARE @cModalidad  CHAR(14)  
   DECLARE @cFirCom     CHAR(40)  
   DECLARE @cFirVen     CHAR(40)  
   DECLARE @nPreFut     NUMERIC(16,10)
   DECLARE @cNomprop    CHAR(50)  
   DECLARE @diasvalor   INT  
   DECLARE @feriado     INT  
   DECLARE @cfecvaluta  DATETIME
   DECLARE @pais        INT  
   DECLARE @pie_compra  CHAR(70)
   DECLARE @pie_venta   CHAR(70)  
   DECLARE @tcSpot      NUMERIC(21,4)
   DECLARE @iProducto   INT  
   DECLARE @iTCPactado  FLOAT  
   DECLARE @iFechaStarting datetime -- 5522 Forward a Observado  
   DECLARE @iPuntosCierre FLOAT     -- 5522 Forward a Observado  
   DECLARE @iProdDsc    VARCHAR(59)  
   DECLARE @MonedaRRDA  VARCHAR  
   DECLARE @MARCA       varchar (10)--Arm Marca Spot a OBS.
   
	DECLARE @Conta NUMERIC(10)
		SET @Conta = (SELECT charindex('-', (SELECT nombre FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @usuario)))

	-->		PRD-18185

	DECLARE @cGlosaConfirmaciones	varchar(1000)
		SET @cGlosaConfirmaciones	=	(	SELECT	Glosa
											FROM	BacParamSuda.dbo.TBL_GLOSA_CONFIRMACIONES with(nolock)
											WHERE	IdSistema = 'BFW'
										)

	-->		PRD-18185

	--> FUSION
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




   SELECT @pais    = acpais
   FROM   MFAC  

  

   SELECT @MonedaRRDA = mnrrda   FROM bacparamsuda..moneda where mncodmon = ( SELECT cacodmon1 FROM MFCA WHERE canumoper = @nNumOper )
   SELECT @cNomprop   = rcnombre FROM VIEW_ENTIDAD  
   SELECT @dFecIni    = CaFecha  FROM MFCA WHERE canumoper = @nNumOper
  
   SET @cNomprop = @NomEntidad

   SELECT @nObsIni    = ISNULL( vmvalor, 0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND VmFecha = @dFecIni
   SELECT @nUFIni     = ISNULL( vmvalor, 0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 998 AND VmFecha = @dFecIni  
  
   SELECT	@cTraCon		= ISNULL( a.OpNombre, '' ), 
			@cVendedor		= ISNULL((CASE CaTipOper WHEN 'C' THEN ClNombre         ELSE @cNomprop          END ), '' ) , 
			@cFaxVen		= ISNULL((CASE CaTipOper WHEN 'C' THEN ClFax            ELSE AcFax              END ), '' ) ,  
			@cOpeVen		= ISNULL((CASE CaTipOper WHEN 'C' THEN @cTraCon         ELSE b.nombre           END ), '' ) ,  
			@cComprador		= ISNULL((CASE CaTipOper WHEN 'C' THEN @cNomprop        ELSE ClNombre           END ), '' ) ,  
			@cFaxCom		= ISNULL((CASE CaTipOper WHEN 'C' THEN AcFax            ELSE ClFax              END ), '' ) ,  
			@cOpeCom		= ISNULL((CASE CaTipOper WHEN 'C' THEN b.nombre         ELSE @cTraCon           END ), '' ) ,  
			@cTipOpe		= ISNULL((CASE CaTipOper WHEN 'C' THEN 'COMPRA    '     ELSE 'VENTA     '       END ), '' ) ,  
			@nPreSpt		= ISNULL((CASE CaCodMon2 WHEN 999 THEN @nObsIni         ELSE @nObsIni / @nUFIni END ), 0  ) ,  
			@nCodMon		= ISNULL( CaCodMon1, 0 )          ,  
			@nCodCnv		= ISNULL( CASE WHEN var_moneda2 > 0 Then 999 ELSE CaCodMon2 END, 0 ) ,
			@nPagoMx		= ISNULL( CaFPagoMx, 0 )          ,  
			@cModalidad		= ISNULL((CASE CaTipModa WHEN 'C' THEN 'COMPENSACION  ' ELSE 'ENTREGA FISICA'   END ), '' ) ,
			@cFirCom		= ISNULL((CASE CaTipOper WHEN 'C' THEN @cNomprop        ELSE ''                 END ), '' ) ,
			@cFirVen		= ISNULL((CASE CaTipOper WHEN 'C' THEN ''               ELSE @cNomprop          END ), '' ) ,
			--@nPreFut		= ISNULL((CASE CaCodPos1 WHEN 3   THEN CaPreMon2        ELSE (CASE WHEN @nCodCnv = 999 THEN capremon1 * (CASE WHEN @MonedaRRDA = 'M' THEN catipcam ELSE 1/catipcam END ) ELSE catipcam END)         END), 0 ) ,  
			@nPreFut		= ISNULL((CASE CaCodPos1 WHEN 3   THEN CaPreMon2        ELSE (CASE WHEN @nCodCnv = 999 THEN caprecal ELSE catipcam END)         END), 0 ) ,
			@cfecvaluta		= cafecvcto,  
			@pie_compra		= CASE CaTipOper WHEN 'C' THEN @cNomprop ELSE '' END,
			@pie_venta		= CASE CaTipOper WHEN 'V' THEN @cNomprop ELSE '' END,
			@tcSpot			= 0,  --> ISNULL(catipcamSpot,0.0) --07.02.2008 CBB  
			@iProducto		= cacodpos1,  
			@iTCPactado		= capremon2,  
			@iFechaStarting	= CaFechaStarting,  -- 5522 Forward a Observado  
			@iPuntosCierre	= CaPuntosFwdCierre, -- 5522 Forward a Observado 
			@MARCA			= cacalvtadol	
	--Rq 7619  
    FROM	MFCA
			LEFT OUTER JOIN   VIEW_CLIENTE_OPERADOR a ON (CaCodigo = a.OpRutCli  AND CaContraparte = a.OpRutOpe)
            LEFT OUTER JOIN   VIEW_USUARIO b ON CaOperador = b.usuario,  
			VIEW_CLIENTE,  
			MFAC  
    WHERE	CaNumOper      = @nNumOper  
	AND	(	CaCodigo       = ClRut	AND	cacodcli	= clcodigo	)

   /*
	FROM   MFCA,  
          VIEW_CLIENTE,
          MFAC,
          VIEW_CLIENTE_OPERADOR a,
          VIEW_USUARIO b  
   WHERE  CaNumOper      = @nNumOper   AND
         (CaCodigo       = ClRut       AND  
          cacodcli       = clcodigo)   AND    
          CaCodigo      *= a.OpRutCli  AND  
          CaContraparte *= a.OpRutOpe  AND  
          CaOperador    *= b.usuario 
	*/
	

  

   select @iProdDsc = Descripcion from BacParamSuda.dbo.PRODUCTO   
   where codigo_Producto = @iProducto and id_sistema = 'BFW'  

   
   SELECT @cCodMon    = ISNULL( MnNemo, '') FROM  VIEW_MONEDA WHERE @nCodMon = MnCodMon
   SELECT @cCodCnv    = ISNULL( MnNemo, '') FROM  VIEW_MONEDA WHERE @nCodCnv = MnCodMon
  

   SELECT @cPagoMx    = Glosa2  
        , @diasvalor  = diasvalor 
   FROM   VIEW_FORMA_DE_PAGO  
   WHERE  Codigo      = @nPagoMx
  

   WHILE (@diasvalor > 0)  ------------------ Valuta Entregamos  
   BEGIN  
      SELECT @cfecvaluta = DATEADD(DAY, 1, @cfecvaluta )
      EXECUTE sp_feriado @cfecvaluta, @pais, @feriado OUTPUT  
      IF @feriado = 0  
         SELECT @diasvalor = @diasvalor -1 
   END  
   
   /*****   COMDER *************/
   DECLARE @idNovada     INT
   DECLARE @idEstado     INT
   DECLARE @NomComDer    CHAR(10)
   DECLARE @CliOriComDer CHAR(35)
   DECLARE @CliRutComDer NUMERIC(9,0)
   DECLARE @CliDvComder  CHAR(1)

   SET @idNovada     = 0
   SET @NomComDer    = ''
   SET @CliOriComDer = ''
   SET @CliRutComDer = 0
   SET @CliDvComder  = ''
   
   if exists (select 1 from BDBOMESA.dbo.COMDER_RelacionMarcaComder WITH(NOLOCK) WHERE nReNumOper = @nNumOper AND cReSistema = 'BFW')
   BEGIN
			set @idEstado = (select id_estado
					         from   BDBOMESA.dbo.COMDER_SolicitudEstado t WITH(NOLOCK)
						     inner join (
									select max(id) as maxid
									from   BDBOMESA.dbo.COMDER_SolicitudEstado WITH(NOLOCK)
									where  numero_operacion = @nNumOper
									) as max
					         on t.id = maxid) 
			
			if  @idEstado IN (1,2,3,8,7,9,10,17) 
				BEGIN
					SET @idNovada  = 0
					SET @NomComDer = '  (ComDer)'
				END 
			ELSE
			BEGIN
				if  @idEstado = 6	-- NOVADA
				BEGIN	
					SET    @idNovada     = 1
					SELECT @CliOriComDer = SUBSTRING(c.clnombre,0,35)
					,      @CliRutComDer = c.Clrut
					,      @CliDvComder  = c.Cldv
					FROM   BacFwdSuda..MFCA                                   mfca with(nolock)
						   INNER JOIN BDBOMESA.dbo.COMDER_RelacionMarcaComDer mc             ON  mc.nReNumOper    = mfca.canumoper   
						   INNER JOIN BacParamSuda..CLIENTE                   C with(nolock) ON  mc.nReRutCliente = c.clrut        
						                                                                    AND  mc.nReCodCliente = c.clcodigo
					WHERE  mfca.canumoper  = @nNumOper
					AND    mfca.caantici  <> 'A'
					AND    mc.cReSistema   = 'BFW'
					AND    mc.iReNovacion  = 1
					AND    mc.vReEstado    = 'V'
				END					
			END
   END

/*****   COMDER *************/

   /*=======================================================================*/  
    --> PRD 12712			
			
    DECLARE @ET_Periodicidad CHAR(50)
	DECLARE @Tipo_Cambio     VARCHAR(50)
	DECLARE @Paridad         VARCHAR(50)
	DECLARE @FPagoMN		 VARCHAR(50)
	DECLARE @FPagoMX		 VARCHAR(50)
	DECLARE @NumOpeSpot		 VARCHAR(20)
		SET @NumOpeSpot = ''

	-- Periodicidad, se debe utilizar en el case
	--SELECT @ET_Periodicidad = CASE WHEN Periodicidad = 0          THEN 'NA' ELSE gd.tbglosa  END
	
	SELECT @ET_Periodicidad = CASE WHEN bearlytermination	= 0  THEN ''   
									ELSE (	SELECT	gd.tbglosa 
								      		FROM	MFCA ca
											inner JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE gd 
											ON	gd.tbcodigo1	= Convert(char(6),Periodicidad) 
											AND gd.tbcateg		= 9920		
											AND ca.canumoper    = m.canumoper				
										  )  
	                     	  END  
	,      @Tipo_Cambio     = CASE WHEN ISNULL(rm.glosa,'') = '' THEN ''   ELSE rm.glosa    END
	,      @Paridad         = CASE WHEN cacodpos1 = 2            THEN par.Glosa   ELSE ''   END 
	,      @FPagoMN = fpMn.glosa
	,      @FPagoMX = fpMx.glosa 
	  FROM MFCA m
		   --INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE gd ON Periodicidad = gd.tbcodigo1
	       LEFT JOIN (    SELECT DISTINCT Codigo, Glosa 
			                FROM BacParamSuda.dbo.REFERENCIA_MERCADO_PRODUCTO  
				                 INNER JOIN BacParamSuda.dbo.REFERENCIA_MERCADO     ON Codigo = Referencia
                           WHERE Estado    = 0
                             AND Producto  = 1 
	                 )        rm ON cacodpos2 = rm.Codigo
	       LEFT JOIN (    SELECT DISTINCT Codigo, Glosa 
			                FROM BacParamSuda.dbo.REFERENCIA_MERCADO_PRODUCTO  
				                 INNER JOIN BacParamSuda.dbo.REFERENCIA_MERCADO     ON Codigo = Referencia
                           WHERE Estado    = 0
                             AND Producto  = 12 
	                 )       par ON cacolmon1 = par.Codigo 
	       LEFT JOIN	(	SELECT clrut, clcodigo, clnombre 
		         	 		FROM	BacparamSuda.dbo.cliente WITH(NOLOCK)
						)	Cli		ON Cli.clrut = cacodigo AND clcodigo = cacodcli
		   LEFT JOIN	(	SELECT	codigo, glosa 
		         	 		FROM	BacparamSuda.dbo.Forma_de_pago WITH(NOLOCK)
						)	fpMn	ON fpMn.codigo = cafpagomn 

   		   LEFT JOIN	(	SELECT	codigo, glosa 
		         	 		FROM	BacparamSuda.dbo.Forma_de_pago WITH(NOLOCK)
						)	fpMx	ON fpMx.codigo = cafpagomx 
	 WHERE CaNumOper          = @nNumOper   
	 --AND   gd.tbcateg         = 9920
--	 AND   cafecha            = (SELECT acfecproc FROM BacFwdSuda.dbo.Mfac)  
	 
	
	SELECT @NumOpeSpot = '(' + convert(varchar(18),MONUMOPE) + ')' from baccamsuda..MEMO WHERE MONUMFUT = @nNumOper
	 --> Fin PRD 12712




	DECLARE @COUNT INT
	SET @COUNT = (SELECT COUNT(*) FROM MFAC, MFCA LEFT OUTER JOIN VIEW_MONEDA ON (CaMdaUSD = MnCodMon) WHERE CaNumOper = @nNumOper)


	IF @COUNT > 0

	BEGIN

   SELECT 'Proprietario'     = @cNomprop,  
          'Numoper'          = @nNumOper,  
          'Fecha Inicio'     = CONVERT(CHAR(10), CaFecha  , 103),  
          'Fecha Vto'        = CONVERT(CHAR(10), CaFecVcto, 103),  
          'Plazo'            = CaPlazo,  
          'Valor UF INI '    = @nUFIni,  
          'Valor Obs Ini'    = CASE WHEN @iProducto = 12 THEN @iTCPactado ELSE @nObsIni END,  
          'Vendedor'         = rtrim(@cVendedor) + @NomComDer,	-- COMDER
          'FaxVta'           = @cFaxVen,  
          'Operador Ven'     = @cOpeVen,  
          'Comprador'        = @cComprador,  
          'FaxCMP'           = @cFaxCom,  
          'Operador com'     = @cOpeCom,  
          'TipoOPer'         = @cTipOpe,  
          'Mto Mex'          = CaMtoMon1, 
          'CodMoneda'        = @cCodMon,  
          'CodCnversion'     = @cCodCnv,  
          'Precio'           = CaPreCal,  
          'Precio Spt'       = @nPreSpt,  
          'Precio futuro'    = @nPreFut,  
          'Monto Final'      = CASE WHEN var_moneda2 > 0 THEN ROUND( CaMtoMon1 * @nPreFut, 0) ELSE CaMtoMon2 END, --> CaMtoMon1 * @nPreFut, -- CaMtoMon2,  
          'Modalidad'        = @cModalidad,  
          'PagoMX'           = ISNULL(@cPagoMx,''),  
          'Glosa'            = CASE WHEN @iProducto = 12 AND cacolmon1 = 1 THEN 'Reuters 11:00 Hras'    + ' - ' + CONVERT(CHAR(10),cafijaPRRef, 103)  
                                    WHEN @iProducto = 12 AND cacolmon1 = 2 THEN 'Pactada'               + ' - ' + CONVERT(CHAR(10),cafijaPRRef, 103)  
                                    WHEN @iProducto = 12 AND cacolmon1 = 3 THEN 'Banco Central Europeo' + ' - ' + CONVERT(CHAR(10),cafijaPRRef, 103)  
                               ELSE                                        MnGlosa  
                               END,  
          'No. Fax Enitidad' = AcFax,
          'Firma Compra'     = @cFirCom,  
          'Firma Venta'      = @cFirVen,  
          'Valuta'           = (CASE WHEN @cModalidad = 'COMPENSACION  ' THEN '' ELSE CONVERT(CHAR(10), @cfecvaluta,103) END),  
          'Nombre Entidad'   = (SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar = cacodsuc1),  
          'Pie_compra'       = @pie_compra,  
          'Pie_Venta'        = @pie_venta,  
          'TC_Spot'          = @tcSpot,  
          'Producto'         = @iProducto,  
          'FechaStarting'    = @iFechaStarting,  
          'PuntosFwdCierre'  = @iPuntosCierre,  
          'ProductoDsc'      = CASE WHEN @MARCA = 14 THEN	'FORWARD STARTING'
								    WHEN @MARCA = 15 THEN	'FORWARD ASIATICO'
								    WHEN @MARCA = 16 THEN	'SPOT OBSERVADO'
									ELSE					'SEGURO DE CAMBIO' 
								END,	-->prd 12568
								
		  'GlosaFinal'	     = @cGlosaConfirmaciones,	-->	PRD-18185
		  'firmabanco'       = CASE WHEN @cTipOpe = 'COMPRA' THEN (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario) 
			                   ELSE '' END,
		  'firmabancov'      = CASE WHEN @cTipOpe = 'VENTA' THEN (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario)  
			                   ELSE '' END
		  ,'Usuario_Banco'   = CASE WHEN @cTipOpe = 'COMPRA' THEN (SELECT rtrim(ltrim(nombre)) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)
			                   ELSE '' END 			
		  ,'Usuario_Bancov'  = CASE WHEN @cTipOpe = 'VENTA' THEN (SELECT rtrim(ltrim(nombre)) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)
			                   ELSE '' END 
		  ,'novada'				  = @idNovada  	                       -- COMDER  
          ,'contraparte_original' = @CliOriComDer	                   -- COMDER
          ,'RutCli'				  = convert(varchar(10),@CliRutComDer) -- COMDER
		  ,'RutDv'                = @CliDvComder                       -- COMDER
		  --> PRD 12712
		  , 'ET_Marca'            = MFCA.bEarlyTermination
		  , 'ET_IdPeriodicidad'   = MFCA.Periodicidad
		  , 'ET_Periodicidad'     = @ET_Periodicidad
		  , 'ET_FechaInicio'      = MFCA.FechaInicio		  
		  , 'Tipo_Cambio'         = @Tipo_Cambio
		  , 'Paridad'             = @Paridad
		  , 'Swap_FX_Spot'	      = caoperrelaspot 
		  , 'FPagoMN'             = ISNULL(@FPagoMN,'0')
		  , 'FPagoMX'             = ISNULL(@FPagoMX,'0')
		  , 'NumOpeSpot'		  = @NumOpeSpot
		  --> Fin PRD 12712
	FROM	MFAC, 
			MFCA LEFT OUTER JOIN VIEW_MONEDA ON CaMdaUSD = MnCodMon  
    WHERE	CaNumOper          = @nNumOper 

	
	
	END
	
	ELSE
	
	BEGIN

   SELECT 'Proprietario'     = ' ',  
          'Numoper'          = 0,  
          'Fecha Inicio'     = ' ',  
          'Fecha Vto'        = ' ',  
          'Plazo'            = 0,  
          'Valor UF INI '    = 0,  
          'Valor Obs Ini'    = 0,  
          'Vendedor'         = ' ',
          'FaxVta'           = 0,  
          'Operador Ven'     = ' ',  
          'Comprador'        = ' ',  
          'FaxCMP'           = ' ',  
          'Operador com'     = ' ',  
          'TipoOPer'         = ' ',  
          'Mto Mex'          = 0, 
          'CodMoneda'        = ' ',  
          'CodCnversion'     = ' ',  
          'Precio'           = 0,  
          'Precio Spt'       = 0,  
          'Precio futuro'    = 0,  
          'Monto Final'      = 0,
          'Modalidad'        = ' ',  
          'PagoMX'           = ' ',  
          'Glosa'            = ' ',  
          'No. Fax Enitidad' = 0,
          'Firma Compra'     = ' ',  
          'Firma Venta'      = ' ',  
          'Valuta'           = ' ',    
		  'Nombre Entidad'   = (SELECT top 1 razonsocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales ),  
          'Pie_compra'       = ' ',  
          'Pie_Venta'        = ' ',  
          'TC_Spot'          = 0,  
          'Producto'         = 0,  
          'FechaStarting'    = '1900-01-01',  
          'PuntosFwdCierre'  = 0,  
          'ProductoDsc'      = ' ',							
		  'GlosaFinal'	     = ' ',
		  'firmabanco'       = ' ',
		  'firmabancov'      = ' ',
		  'Usuario_Banco'   = ' ', 			
		  'Usuario_Bancov'  = ' ', 
		  'novada'				  = 0,  	                       -- COMDER  
          'contraparte_original' = ' ',	                   -- COMDER
          'RutCli'				  = 0, -- COMDER
		  'RutDv'                = ' ',                       -- COMDER
		  'ET_Marca'            = ' ',
		  'ET_IdPeriodicidad'   = ' ',
		  'ET_Periodicidad'     = ' ',
		  'ET_FechaInicio'      = ' ' ,		  
		  'Tipo_Cambio'         = ' ',
		  'Paridad'             = ' ',
		  'Swap_FX_Spot'	      = '0' ,
		  'FPagoMN'             = '0',
		  'FPagoMX'             = '0',
		  'NumOpeSpot'		  = ' '

	
	END	
	
	
	
	
	
	SET NOCOUNT OFF 



END








--   SELECT 'Proprietario'     = @cNomprop,  
--          'Numoper'          = @nNumOper,  
--          'Fecha Inicio'     = CONVERT(CHAR(10), CaFecha  , 103),  
--          'Fecha Vto'        = CONVERT(CHAR(10), CaFecVcto, 103),  
--          'Plazo'            = CaPlazo,  
--          'Valor UF INI '    = @nUFIni,  
--          'Valor Obs Ini'    = CASE WHEN @iProducto = 12 THEN @iTCPactado ELSE @nObsIni END,  
--          'Vendedor'         = rtrim(@cVendedor) + @NomComDer,	-- COMDER
--          'FaxVta'           = @cFaxVen,  
--          'Operador Ven'     = @cOpeVen,  
--          'Comprador'        = @cComprador,  
--          'FaxCMP'           = @cFaxCom,  
--          'Operador com'     = @cOpeCom,  
--          'TipoOPer'         = @cTipOpe,  
--          'Mto Mex'          = CaMtoMon1, 
--          'CodMoneda'        = @cCodMon,  
--          'CodCnversion'     = @cCodCnv,  
--          'Precio'           = CaPreCal,  
--          'Precio Spt'       = @nPreSpt,  
--          'Precio futuro'    = @nPreFut,  
--          'Monto Final'      = CASE WHEN var_moneda2 > 0 THEN ROUND( CaMtoMon1 * @nPreFut, 0) ELSE CaMtoMon2 END, --> CaMtoMon1 * @nPreFut, -- CaMtoMon2,  
--          'Modalidad'        = @cModalidad,  
--          'PagoMX'           = ISNULL(@cPagoMx,''),  
--          'Glosa'            = CASE WHEN @iProducto = 12 AND cacolmon1 = 1 THEN 'Reuters 11:00 Hras'    + ' - ' + CONVERT(CHAR(10),cafijaPRRef, 103)  
--                                    WHEN @iProducto = 12 AND cacolmon1 = 2 THEN 'Pactada'               + ' - ' + CONVERT(CHAR(10),cafijaPRRef, 103)  
--                                    WHEN @iProducto = 12 AND cacolmon1 = 3 THEN 'Banco Central Europeo' + ' - ' + CONVERT(CHAR(10),cafijaPRRef, 103)  
--                               ELSE                                        MnGlosa  
--                               END,  
--          'No. Fax Enitidad' = AcFax,
--          'Firma Compra'     = @cFirCom,  
--          'Firma Venta'      = @cFirVen,  
--          'Valuta'           = (CASE WHEN @cModalidad = 'COMPENSACION  ' THEN '' ELSE CONVERT(CHAR(10), @cfecvaluta,103) END),  
--          'Nombre Entidad'   = (SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar = cacodsuc1),  
--          'Pie_compra'       = @pie_compra,  
--          'Pie_Venta'        = @pie_venta,  
--          'TC_Spot'          = @tcSpot,  
--          'Producto'         = @iProducto,  
--          'FechaStarting'    = @iFechaStarting,  
--          'PuntosFwdCierre'  = @iPuntosCierre,  
--          'ProductoDsc'      = CASE WHEN @MARCA = 14 THEN	'FORWARD STARTING'
--								    WHEN @MARCA = 15 THEN	'FORWARD ASIATICO'
--								    WHEN @MARCA = 16 THEN	'SPOT OBSERVADO'
--									ELSE					'SEGURO DE CAMBIO' 
--								END,	-->prd 12568
								
--		  'GlosaFinal'	     = @cGlosaConfirmaciones,	-->	PRD-18185
--		  'firmabanco'       = CASE WHEN @cTipOpe = 'COMPRA' THEN (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario) 
--			                   ELSE '' END,
--		  'firmabancov'      = CASE WHEN @cTipOpe = 'VENTA' THEN (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario)  
--			                   ELSE '' END
--		  ,'Usuario_Banco'   = CASE WHEN @cTipOpe = 'COMPRA' THEN (SELECT rtrim(ltrim(nombre)) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)
--			                   ELSE '' END 			
--		  ,'Usuario_Bancov'  = CASE WHEN @cTipOpe = 'VENTA' THEN (SELECT rtrim(ltrim(nombre)) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)
--			                   ELSE '' END 
--		  ,'novada'				  = @idNovada  	                       -- COMDER  
--          ,'contraparte_original' = @CliOriComDer	                   -- COMDER
--          ,'RutCli'				  = convert(varchar(10),@CliRutComDer) -- COMDER
--		  ,'RutDv'                = @CliDvComder                       -- COMDER
--		  --> PRD 12712
--		  , 'ET_Marca'            = MFCA.bEarlyTermination
--		  , 'ET_IdPeriodicidad'   = MFCA.Periodicidad
--		  , 'ET_Periodicidad'     = @ET_Periodicidad
--		  , 'ET_FechaInicio'      = MFCA.FechaInicio		  
--		  , 'Tipo_Cambio'         = @Tipo_Cambio
--		  , 'Paridad'             = @Paridad
--		  , 'Swap_FX_Spot'	      = caoperrelaspot 
--		  , 'FPagoMN'             = ISNULL(@FPagoMN,'0')
--		  , 'FPagoMX'             = ISNULL(@FPagoMX,'0')
--		  , 'NumOpeSpot'		  = @NumOpeSpot
--		  --> Fin PRD 12712
--	FROM	MFAC, 
--			MFCA LEFT OUTER JOIN VIEW_MONEDA ON CaMdaUSD = MnCodMon  
--    WHERE	CaNumOper          = @nNumOper   
--	SET NOCOUNT OFF 

--END

GO
