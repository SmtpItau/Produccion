USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_ESPECIFICO_PPRODUCTO_SWAP]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[CONTRATO_ESPECIFICO_PPRODUCTO_SWAP]  
   (   
	     @numoper			NUMERIC (09)  
	    ,@fecha				AS CHAR(8)
 		,@RUT_CLIENTE		AS NUMERIC(11)  
	    ,@COD_CLIENTE		AS NUMERIC(10)  
	    ,@RUT_APODERADO1	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADO2	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADOB1	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADOB2	AS NUMERIC(11) = 0   
	    ,@Preliminar		INT
   )  
AS  
BEGIN  
   SET NOCOUNT ON  

  
   DECLARE @SwDevengo  NUMERIC(01)  
   DECLARE @fechaproc  DATETIME  , @fecha1 datetime
   DECLARE @Nombre_Banco VARCHAR(50)
   DECLARE @Rut_Banco VARCHAR(12)

   SELECT  @SwDevengo = devengo   
         , @fechaproc = fechaproc
   FROM    Bacswapsuda..SWAPGENERAL  

   --SELECT @Nombre_Banco = RazonSocial 
   --FROM bacparamsuda..Contratos_ParametrosGenerales

   	DECLARE @NomEntidad		VARCHAR(100)
	DECLARE @RutEntidad		NUMERIC(12)
	DECLARE	@DvEntidad		VARCHAR(1)
	DECLARE @CodEntidad		VARCHAR(2)
	DECLARE	@DirecEntidad	VARCHAR(100)
	DECLARE @FonoEntidad	VARCHAR(14)
	DECLARE @ComunaEntidad	VARCHAR(30)
	DECLARE @CiudadEntidad	VARCHAR(30)
	DECLARE @LOGO_BANCO VARBINARY(MAX)
	DECLARE @LOGO VARBINARY(MAX)
	DECLARE @DIRECC_PIE_FIRMA VARCHAR(100)
	DECLARE @URL_BANCO	VARCHAR(100)
	DECLARE @LOGO_BANCO_PIE_FIRMA VARBINARY(MAX)
	DECLARE @LOGO_LARGO_CONTRATO VARBINARY(MAX)

   	SELECT 
			@NomEntidad		=	RazonSocial	
	,		@RutEntidad		=	RutEntidad	
	,		@DvEntidad		=	DigitoVerificador
	,		@CodEntidad		=   CodigoEntidad
	,		@DirecEntidad	=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad
	,		@FonoEntidad	=	TelefonoLegal
	,		@ComunaEntidad  =	Comuna
	,		@CiudadEntidad  =	Ciudad
	,		@LOGO_BANCO		=	BannerLargoContrato
	,		@LOGO			=	Logo 
	,		@LOGO_LARGO_CONTRATO	=   BannerLargoContrato
	,		@DIRECC_PIE_FIRMA		=	DireccionLegalPieFirma
	,		@URL_BANCO				=	URLBanco
	,		@LOGO_BANCO_PIE_FIRMA	= BannerCorto
	FROM bacparamsuda..Contratos_ParametrosGenerales



   	DECLARE @cNom_Apoderado_Banco_1		VARCHAR(40);	SET @cNom_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB1, 1)
	DECLARE @cRut_Apoderado_Banco_1		VARCHAR(40);	SET	@cRut_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB1, 2)
	DECLARE @cNom_Apoderado_Banco_2		VARCHAR(40);	SET @cNom_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB2, 1)
	DECLARE @cRut_Apoderado_Banco_2		VARCHAR(40);	SET	@cRut_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB2, 2)
	DECLARE @cNom_Apoderado_Cliente_1	VARCHAR(40);	SET @cNom_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO1, 1)
	DECLARE @cRut_Apoderado_Cliente_1	VARCHAR(40);	SET @cRut_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO1, 2)
	DECLARE @cNom_Apoderado_Cliente_2	VARCHAR(40);	SET @cNom_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO2, 1)
	DECLARE @cRut_Apoderado_Cliente_2	VARCHAR(40);	SET @cRut_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO2, 2)

	DECLARE @ClienteEmpresa as varchar(2)
	SET  @ClienteEmpresa = 'SI'
	if exists (select * from bacparamsuda..cliente where clrut = @RUT_CLIENTE and clcodigo = @COD_CLIENTE and Cltipcli in (8, 9) )
		set @ClienteEmpresa = 'NO'


  select @fecha1 = convert(datetime, @fecha)

   select 'FECHA_CONTRATO'			= (SELECT CONVERT(CHAR(2), @fecha1	, 103) + ' de '
										+ case when datepart(month,@fecha1	) = 1 THEN 'Enero'
										       when datepart(month,@fecha1	) = 2 THEN 'Febrero'
										       when datepart(month,@fecha1	) = 3 THEN 'Marzo'
										       when datepart(month,@fecha1	) = 4 THEN 'Abril'
										       when datepart(month,@fecha1	) = 5 THEN 'Mayo'
										       when datepart(month,@fecha1	) = 6 THEN 'Junio'
										       when datepart(month,@fecha1	) = 7 THEN 'Julio'
										       when datepart(month,@fecha1	) = 8 THEN 'Agosto'
										       when datepart(month,@fecha1	) = 9 THEN 'Septiembre'
										       when datepart(month,@fecha1	) = 10 THEN 'Octubre'
										       when datepart(month,@fecha1	) = 11 THEN 'Noviembre'
										       when datepart(month,@fecha1	) = 12 THEN 'Diciembre'
										  end + ' de '
										           + ltrim(rtrim(datepart(year,@fecha1	))))
	--,	'BANCO'                 = A.Nombre	
	,	'BANCO'                 = @NomEntidad --(select RazonSocial from bacparamsuda..Contratos_ParametrosGenerales)	
	--,	'RUT'                   = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(Cldv)) From Bacparamsuda..cliente where A.rut = clrut)
	--,	'RUT'                   = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, RutEntidad), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(DigitoVerificador)) From bacparamsuda..Contratos_ParametrosGenerales where A.rut = RutEntidad)
	,	'RUT'                   = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, @RutEntidad), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(@DvEntidad)))
	
	,   'RUT_CLI'               = (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.')))+'-'+ltrim(rtrim(Cldv)) From Bacparamsuda..cliente where clrut=@rut_cliente)
	,	'CLIENTE'				= CLNOMBRE 
	,	'DIRECCION_CLI'			= CLI.CLDIRECC 
	,	'FONO_CLI'				= CLI.CLFONO 
	,	'FAX_CLI'				= CLI.CLFAX  	
	,	'COMUNA'				= 
	                              isnull((SELECT distinct  NOMBRE 
	                                      FROM   BACPARAMSUDA..CIUDAD CIU  
			                              INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
			                              WHERE  CLRUT = @RUT_CLIENTE),'')
	,	'CIUDAD'				= 
	                              isnull((SELECT distinct  NOMBRE 
	                                      FROM   BACPARAMSUDA..CIUDAD CIU  
			                              INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
			                              WHERE  CLRUT = @RUT_CLIENTE),'')
	,	'APODERADO_CLIENTE_1'		= isnull((SELECT distinct APNOMBRE	FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE),'')
	,   'RUT_APODERADO_CLIENTE_1'	= isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
			                                   FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                             	           WHERE  APRUTAPO = @RUT_APODERADO1 
	                             	           and    aprutcli = @RUT_CLIENTE 
	                             	           and    apcodcli = @COD_CLIENTE),'')  
	,	'APODERADO_CLIENTE_2'  = isnull((SELECT distinct APNOMBRE 
	 	                                 FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	 	                                 WHERE  APRUTAPO = @RUT_APODERADO2 
	 	                                 and    aprutcli = @RUT_CLIENTE 
	 	                                 and    apcodcli = @COD_CLIENTE)  ,'')
	,   'RUT_APODERADO_CLIENTE_2' = isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
			                                 FROM BACPARAMSUDA..CLIENTE_APODERADO 
	                                         WHERE APRUTAPO = @RUT_APODERADO2 
	                                         and   aprutcli = @RUT_CLIENTE 
	                                         and   apcodcli = @COD_CLIENTE),'')
	
	,   'APODERADO_BANCO_1'   =   isnull((SELECT distinct APNOMBRE	
	                                      FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                      WHERE  APRUTAPO = @RUT_APODERADOB1 
	                                      and    aprutcli = 97023000),'')  
		
	,   'RUT_APODERADO_BANCO_1'  = isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
			                                FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                        WHERE  APRUTAPO = @RUT_APODERADOB1 
	                                        and    aprutcli = 97023000),'') 
	
	,   'APODERADO_BANCO_2'   = isnull((SELECT distinct APNOMBRE 
	                                    FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                     WHERE  APRUTAPO = @RUT_APODERADOB2 
	                                    and    aprutcli = 97023000),'')  

	,   'RUT_APODERADO_BANCO_2'  = isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
			                                FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                        WHERE  APRUTAPO = @RUT_APODERADOB2 
											and    aprutcli = 97023000),'')
	
	,   'DIRECCION_BANCO'    = @DirecEntidad -- A.DIRECCION  
	
	,	'TELEFONO_BANCO'	 = @FonoEntidad --A.TELEFONO
	,	'FAX_BANCO'			 =	A.FAX 
	,	'Fecha_inicio'		 = fecha_inicio
	,	'Fecha_termino'		 = fecha_termino
	,   'Tipo_operacion'     = Tipo_operacion  
   ,    'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END  
   ,    'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END  
   ,    'Modalidad'          = ISNULL(CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END,' ')  
   ,    'fechainicioflujo'   = CONVERT(CHAR(10),Fecha_inicio_flujo,103)  
   ,    'fechavenceflujo'    = CONVERT(CHAR(10),Fecha_vence_flujo,103)  
   ,    'dias'               = PlazoFlujo  
   ,    'MontoCompra'        = compra_valor_tasa + compra_spread  
   ,    'MontoVenta'         = venta_valor_tasa  + venta_spread  
   ,    'nombretasacompra'   = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = compra_codigo_tasa AND tbcateg = 1042),' ')  
   ,    'nombretasaventa'    = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = venta_codigo_tasa  AND tbcateg = 1042),' ')  
   ,    'pagamosdoc'         = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = pagamos_documento),' ')  
   ,    'recibimosdoc'       = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = recibimos_documento),' ')  
   ,    'numero_flujo'       = numero_flujo  
   ,    'compra_capital'     = ISNULL(Compra_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  compra_flujo_adicional ELSE 0 END),0)  
   ,    'compra_amortiza'    = compra_amortiza  
   ,    'compra_saldo'       = compra_saldo  
   ,    'compra_interes'     = compra_interes  
   ,    'compra_spread'      = compra_spread  
   ,    'venta_capital'      = ISNULL(Venta_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  Venta_flujo_adicional ELSE 0 END),0)  
   ,    'venta_amortiza'     = venta_amortiza  
   ,    'venta_saldo'        = venta_saldo  
   ,    'venta_interes'      = venta_interes  
   ,    'venta_spread'       = venta_spread  
   ,    'pagamos_moneda'     = pagamos_moneda  
   ,    'recibimos_moneda'   = recibimos_moneda  
   ,    'tipo_flujo'         = tipo_flujo  
   ,    'compra_moneda'      = compra_moneda  
   ,    'venta_moneda'       = venta_moneda  
   ,    'compra_capital1'    = compra_capital  
   ,    'venta_capital1'     = venta_capital  
   ,    'nemo_compra_moneda' = isnull((select MNNEMO from BACSWAPSUDA..view_moneda where compra_moneda=MNCODMON),'')  
   ,    'nemo_venta_moneda'  = isnull((select MNNEMO from BACSWAPSUDA..view_moneda where venta_moneda =MNCODMON) ,'')  
   ,    'VALUTA'             = isnull((select Diasvalor from BACSWAPSUDA..VIEW_FORMA_DE_PAGO where pagamos_documento=Codigo),0)  
   ,    'EstadoFlujo'        = estado_flujo     
   ,    'Amortiza'           = Case when (select TOP 1 IntercPrinc from BACSWAPSUDA..cartera A where A.numero_operacion = @numoper  and Tipo_Swap=2 and Tipo_flujo=1 and (fecha_inicio_flujo=fecha_vence_flujo)  )<>0    --numero_flujo=1  
                                    then 'Intercambio Nocionales al Inicio. '  else ' '   
                                    end  
   ,    'FechaFijacionTasa'     = CONVERT(CHAR(10),fecha_fijacion_tasa,103)   
   ,    'FechaLiquidacion'      = CONVERT(CHAR(10),FechaLiquidacion,103)   
   ,    'nemo_pagamos_moneda'   = isnull((select mnnemo from BACSWAPSUDA..view_moneda where MNCODMON=(CASE WHEN pagamos_moneda=998 THEN 999 ELSE pagamos_moneda END)),'')  
   ,    'nemo_recibimos_moneda' = isnull((select mnnemo from BACSWAPSUDA..view_moneda where MNCODMON=(CASE WHEN recibimos_moneda=998 THEN 999 ELSE recibimos_moneda END)) ,'')  
   ,    'TituloModComp'         = 'El Diferencial de Amortización y el Diferencial de Intereses se pagarán en: '   
   ,    'TituloModEF_1'         = 'Las Amortizaciones e Interés se pagarán en Pago Pasivo: '   
   ,    'TituloModEF_2'         = ' y se recibiran en Pago Activo: '   
   ,    'Tipo_Swap'             = CASE tipo_swap WHEN 1 THEN 'TASA'  
												 WHEN 2 THEN 'MONEDA'  
												 WHEN 3 THEN 'FRA'  
												 WHEN 4 THEN 'TASA' --> 'CAMARA'  
								  END  
   ,    'INTER_NOCIONAL'    = IntercPrinc  
   ,    'CompraGlosaBase'   = ISNULL((SELECT Glosa FROM BACSWAPSUDA..Base Base WHERE Base.codigo  = compra_base),'N/A')   
   ,    'VentaGlosaBase'    = ISNULL((SELECT Glosa FROM BACSWAPSUDA..Base Base WHERE Base.codigo  = Venta_base),'N/A') 
   ,    'numero_operacion'  = @numoper
   ,    'compra_codigo'     = case when CARTERA.compra_codigo_tasa =0 then convert(varchar(14),convert(numeric(10,4),CARTERA.compra_valor_tasa)) 
                                   else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                        FROM   BacParamSuda..TABLA_GENERAL_DETALLE 
									   				        WHERE  tbcodigo1 = CARTERA.compra_codigo_tasa AND tbcateg = 1042),' '))) end+ 
	                          case when CARTERA.compra_spread>0.0 then (case when CARTERA.compra_codigo_tasa =0 
					                                              then '' else ' + ' end )+convert(varchar(10),convert(numeric(10,4),CARTERA.compra_spread))+'%' else '' end --as compra_codigo
	,	'fecparam'          = @fecha	--as 'fecparam'	--		AS CHAR(8)
	,	'rutparam'          = @RUT_CLIENTE --as 'rutparam'	--	AS NUMERIC(11)  
	,	'codparam'          = @COD_CLIENTE	--as 'codparam'	--AS NUMERIC(10)  
	,	'rutapo1param'      = @RUT_APODERADO1	--as 'rutapo1param' --AS NUMERIC(11) = 0  
	,	'rutapo2param'      = @RUT_APODERADO2	--as 'rutapo2param'--AS NUMERIC(11) = 0  
	,	'rutapo1bparam'     = @RUT_APODERADOB1 --as 'rutapo1bparam'	--AS NUMERIC(11) = 0  
	,	'rutap2bparam'      = @RUT_APODERADOB2 --as 'rutap2bparam'	--AS NUMERIC(11) = 0    
	 
	,	'Preliminar'		= ISNULL(@Preliminar,0)

	--///************RÉPRESENTANTE************///

	,   'GLOSA_REPRESENTANTE'		= --CASE WHEN Contrato <> 'CCG' THEN
														CASE WHEN @ClienteEmpresa = 'SI' AND @cNom_Apoderado_Cliente_1 <> '' AND @cNom_Apoderado_Cliente_2 <> '' THEN 
														 	'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_1 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_1 ))
															--'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_1 )) + ', cédula de identidad N°' +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@cRut_Apoderado_cliente_1,0)))) ), 1), '.00',''), ',','.')) 
															+ ' y por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_2 ))
															--+ ' y por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_2 ))
															+ ', ambos domiciliados en ' + ltrim(rtrim(CLI.CLDIRECC)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
																							WHERE	CLRUT = @RUT_CLIENTE),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
																	WHERE CLRUT = @RUT_CLIENTE),'')
															+ ','

															 WHEN @ClienteEmpresa = 'SI' AND @cNom_Apoderado_Cliente_1 <> '' AND @cNom_Apoderado_Cliente_2 = '' THEN 
																		'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_1 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_1 ))
																	+ ', domiciliado en ' + ltrim(rtrim(CLI.CLDIRECC)) 
																	+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																									FROM	BACPARAMSUDA..COMUNA COMU   
																											INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
																									WHERE	CLRUT = @RUT_CLIENTE),'')))
																	+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																			FROM	BACPARAMSUDA..CIUDAD CIU  
																					INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
																			WHERE CLRUT = @RUT_CLIENTE),'')
																	+ ','
															WHEN @ClienteEmpresa = 'SI' AND @cNom_Apoderado_Cliente_1 = '' AND @cNom_Apoderado_Cliente_2 <> '' THEN 
																		'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_2 ))
																	+ ', domiciliado en ' + ltrim(rtrim(CLI.CLDIRECC)) 
																	+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																									FROM	BACPARAMSUDA..COMUNA COMU   
																											INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
																									WHERE	CLRUT = @RUT_CLIENTE),'')))
																	+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																			FROM	BACPARAMSUDA..CIUDAD CIU  
																					INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
																			WHERE CLRUT = @RUT_CLIENTE),'')
																	+ ','

														ELSE 
																'' 
														END

	--//************************************//



   
    INTO   #TMP_CARTERA_SWAP  
    FROM   bacswapsuda..CARTERA  , Bacswapsuda..SwapGeneral A		 
		,  (SELECT distinct CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX  
			FROM   BACPARAMSUDA..CLIENTE 
		    WHERE  CLRUT    = @RUT_CLIENTE 
		    and    clcodigo = @COD_CLIENTE)  CLI
    WHERE  CARTERA.numero_operacion    = @numoper  
    --AND    CARTERA.numero_flujo > 1 
    ORDER BY tipo_flujo, CARTERA.numero_flujo  
  
 
  
  
    DECLARE @dFecha   DATETIME  
        SET @dFecha   = (SELECT MIN(Fecha_Proceso) FROM BACSWAPSUDA..CARTERARES WHERE CARTERARES.numero_operacion = @numoper)  
  
    INSERT INTO #TMP_CARTERA_SWAP  
	select 'FECHA_CONTRATO'			= (SELECT CONVERT(CHAR(2), @fecha1	, 103) + ' de '
										+ case when datepart(month,@fecha1	) = 1 THEN 'Enero'
										       when datepart(month,@fecha1	) = 2 THEN 'Febrero'
										       when datepart(month,@fecha1	) = 3 THEN 'Marzo'
										       when datepart(month,@fecha1	) = 4 THEN 'Abril'
										       when datepart(month,@fecha1	) = 5 THEN 'Mayo'
										       when datepart(month,@fecha1	) = 6 THEN 'Junio'
										       when datepart(month,@fecha1	) = 7 THEN 'Julio'
										       when datepart(month,@fecha1	) = 8 THEN 'Agosto'
										       when datepart(month,@fecha1	) = 9 THEN 'Septiembre'
										       when datepart(month,@fecha1	) = 10 THEN 'Octubre'
										       when datepart(month,@fecha1	) = 11 THEN 'Noviembre'
										       when datepart(month,@fecha1	) = 12 THEN 'Diciembre'
										  end + ' de '
										           + ltrim(rtrim(datepart(year,@fecha1	))))
	--,	'BANCO'   = A.Nombre	
	,	'BANCO'   = @NomEntidad --(select RazonSocial from bacparamsuda..Contratos_ParametrosGenerales)	
	--,	'RUT'     = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(Cldv)) From Bacparamsuda..cliente where A.rut = clrut)
	--,	'RUT'     = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, RutEntidad), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(DigitoVerificador)) From bacparamsuda..Contratos_ParametrosGenerales where A.rut = RutEntidad)
	,	'RUT'     = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, @RutEntidad), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(@DvEntidad)))
	
	,   'RUT_CLI' = (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.')))+'-'+ltrim(rtrim(Cldv)) From Bacparamsuda..cliente where clrut=@rut_cliente)
	,	'CLIENTE'				= CLNOMBRE 
	,	'DIRECCION_CLI'			= CLI.CLDIRECC
	,	'FONO_CLI'				= CLI.CLFONO
	,	'FAX_CLI'				= CLI.CLFAX 
	,	'COMUNA'					= 
									  isnull((SELECT distinct  NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
									  INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
									  WHERE CLRUT = @RUT_CLIENTE),'')
	,	'CIUDAD'					= 
									  isnull((SELECT distinct  NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
									  INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
									  WHERE CLRUT = @RUT_CLIENTE),'')
	,	'APODERADO_CLIENTE_1'		= isnull((SELECT distinct APNOMBRE	FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE),'')
	,  'RUT_APODERADO_CLIENTE_1'	= isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
												FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE),'')  
	,	'APODERADO_CLIENTE_2'		= isnull((SELECT distinct APNOMBRE FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO2 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE)  ,'')
	,   'RUT_APODERADO_CLIENTE_2'   = isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
												FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO2 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE),'')
	
	,   'APODERADO_BANCO_1'			= isnull((SELECT distinct APNOMBRE	FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB1 and aprutcli = 97023000)  ,'')
	,   'RUT_APODERADO_BANCO_1'		= isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
												FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB1 and aprutcli = 97023000),'') 
	,   'APODERADO_BANCO_2'			= isnull((SELECT distinct APNOMBRE FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB2 and aprutcli = 97023000),'')  
	,   'RUT_APODERADO_BANCO_2'		= isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
												FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB2 and aprutcli = 97023000),'')
	,   'DIRECCION_BANCO'    = @DirecEntidad --A.DIRECCION  
	,	'TELEFONO_BANCO'	 =  @FonoEntidad --A.TELEFONO
	,	'FAX_BANCO'			 =	A.FAX 
	,	'Fecha_inicio'		 = fecha_inicio
	,	'Fecha_termino'		 = fecha_termino
	,	'Tipo_operacion'     = Tipo_operacion  
    ,   'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END  
    ,   'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END  
    ,   'Modalidad'          = ISNULL(CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END,' ')  
    ,	'fechainicioflujo'   = CONVERT(CHAR(10),Fecha_inicio_flujo,103)  
    ,	'fechavenceflujo'    = CONVERT(CHAR(10),Fecha_vence_flujo,103)  
    ,	'dias'               = PlazoFlujo  
    ,   'MontoCompra'        = compra_valor_tasa + compra_spread  
    ,   'MontoVenta'         = venta_valor_tasa  + venta_spread  
    ,   'nombretasacompra'   = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = compra_codigo_tasa AND tbcateg = 1042),' ')  
    ,   'nombretasaventa'    = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = venta_codigo_tasa  AND tbcateg = 1042),' ')  
    ,   'pagamosdoc'         = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = pagamos_documento),' ')  
    ,   'recibimosdoc'       = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = recibimos_documento),' ')  
    ,   'numero_flujo'       = numero_flujo  
    ,   'compra_capital'     = ISNULL(Compra_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  compra_flujo_adicional ELSE 0 END),0)  
    ,   'compra_amortiza'    = compra_amortiza  
    ,   'compra_saldo'       = compra_saldo  
    ,   'compra_interes'     = compra_interes  
    ,   'compra_spread'		 = compra_spread  
    ,   'venta_capital'      = ISNULL(Venta_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  Venta_flujo_adicional ELSE 0 END),0)  
    ,   'venta_amortiza'     = venta_amortiza  
    ,   'venta_saldo'        = venta_saldo  
    ,   'venta_interes'      = venta_interes  
    ,   'venta_spread'       = venta_spread  
    ,   'pagamos_moneda'     = pagamos_moneda  
    ,   'recibimos_moneda'   = recibimos_moneda  
    ,   'tipo_flujo'         = tipo_flujo  
    ,   'compra_moneda'      = compra_moneda  
    ,   'venta_moneda'       = venta_moneda  
    ,   'compra_capital1'    = compra_capital  
    ,   'venta_capital1'     = venta_capital  
    ,   'nemo_compra_moneda' = isnull((select mnnemo from BACSWAPSUDA..view_moneda where compra_moneda = mncodmon),'')  
    ,   'nemo_venta_moneda'  = isnull((select mnnemo from BACSWAPSUDA..view_moneda where venta_moneda  = mncodmon) ,'')  
    ,   'VALUTA'             = isnull((select Diasvalor from BACSWAPSUDA..VIEW_FORMA_DE_PAGO where pagamos_documento=Codigo),0)  
    ,   'EstadoFlujo'        = estado_flujo     
    ,   'Amortiza'           = Case when (select TOP 1 IntercPrinc 
										  from   BACSWAPSUDA..CARTERARES 
										  where  Fecha_Proceso = @dFecha and CARTERARES.numero_operacion = @numoper  and Tipo_Swap=2 and Tipo_flujo=1 and 
												 (fecha_inicio_flujo=fecha_vence_flujo)  )<>0    --numero_flujo=1  
									then 'Intercambio Nocionales al Inicio. '  else ' '   
                               end  
    ,	'FechaFijacionTasa'     = CONVERT(CHAR(10),fecha_fijacion_tasa,103)   
    ,	'FechaLiquidacion'      = CONVERT(CHAR(10),FechaLiquidacion,103)   
    ,   'nemo_pagamos_moneda'   = isnull((select MNNEMO from BACSWAPSUDA..view_moneda where MNCODMON = (CASE WHEN pagamos_moneda=998 THEN 999 ELSE pagamos_moneda END)),'')  
    ,   'nemo_recibimos_moneda' = isnull((select MNNEMO from BACSWAPSUDA..view_moneda where MNCODMON = (CASE WHEN recibimos_moneda=998 THEN 999 ELSE recibimos_moneda END)) ,'')  
    ,   'TituloModComp'         = 'El Diferencial de Amortización y el Diferencial de Intereses se pagarán en: '   
    ,   'TituloModEF_1'         = 'Las Amortizaciones e Interés se pagarán en Pago Pasivo: '   
    ,   'TituloModEF_2'         = ' y se recibiran en Pago Activo: '   
    ,   'Tipo_Swap'             = CASE tipo_swap WHEN 1 THEN 'TASA'  
											     WHEN 2 THEN 'MONEDA'  
											     WHEN 3 THEN 'FRA'  
											     WHEN 4 THEN 'TASA' -- 'CAMARA'  
								  END  
    ,	'INTER_NOCIONAL'		= IntercPrinc  
	,   'CompraGlosaBase'		= ISNULL((SELECT Glosa FROM BACSWAPSUDA..Base Base WHERE Base.codigo  = compra_base),'N/A')   
    ,   'VentaGlosaBase'		= ISNULL((SELECT Glosa FROM BACSWAPSUDA..Base Base WHERE Base.codigo  = Venta_base),'N/A')   
    ,   'numero_operacion'		= @numoper 
    ,   'compra_codigo'			= case when CARTERAHIS.compra_codigo_tasa =0 then convert(varchar(14),convert(numeric(10,4),CARTERAHIS.compra_valor_tasa)) else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = CARTERAHIS.compra_codigo_tasa AND tbcateg = 1042),' '))) end+ 
									case when CARTERAHIS.compra_spread>0.0 then (case when CARTERAHIS.compra_codigo_tasa =0 
					                                             then '' else ' + ' end )+convert(varchar(10),convert(numeric(10,4),CARTERAHIS.compra_spread))+'%' else '' end --as compra_codigo   
	,	'fecparam'				= @fecha	--as 'fecparam'	--		AS CHAR(8)
	,	'rutparam'				= @RUT_CLIENTE --as 'rutparam'	--	AS NUMERIC(11)  
	,	'codparam'				= @COD_CLIENTE	--as 'codparam'	--AS NUMERIC(10)  
	,	'rutapo1param'			= @RUT_APODERADO1	--as 'rutapo1param' --AS NUMERIC(11) = 0  
	,	'rutapo2param'			= @RUT_APODERADO2	--as 'rutapo2param'--AS NUMERIC(11) = 0  
	,	'rutapo1bparam'			= @RUT_APODERADOB1  --as 'rutapo1bparam'	--AS NUMERIC(11) = 0  
	,	'rutap2bparam'			= @RUT_APODERADOB2  --as 'rutap2bparam'	--AS NUMERIC(11) = 0  
	
	,	'Preliminar'			= ISNULL(@Preliminar,0)


	--///************RÉPRESENTANTE************///

	,   'GLOSA_REPRESENTANTE'			= --CASE WHEN Contrato <> 'CCG' THEN
														CASE WHEN @ClienteEmpresa = 'SI' AND @cNom_Apoderado_Cliente_1 <> '' AND @cNom_Apoderado_Cliente_2 <> '' THEN 
														 	'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_1 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_1 ))
															+ ' y por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_2 ))
															+ ', ambos domiciliados en ' + ltrim(rtrim(CLI.CLDIRECC)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
																							WHERE	CLRUT = @RUT_CLIENTE),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
																	WHERE CLRUT = @RUT_CLIENTE),'')
															+ ','

															 WHEN @ClienteEmpresa = 'SI' AND @cNom_Apoderado_Cliente_1 <> '' AND @cNom_Apoderado_Cliente_2 = '' THEN 
																		'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_1 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_1 ))
																	+ ', domiciliado en ' + ltrim(rtrim(CLI.CLDIRECC)) 
																	+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																									FROM	BACPARAMSUDA..COMUNA COMU   
																											INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
																									WHERE	CLRUT = @RUT_CLIENTE),'')))
																	+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																			FROM	BACPARAMSUDA..CIUDAD CIU  
																					INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
																			WHERE CLRUT = @RUT_CLIENTE),'')
																	+ ','
															WHEN @ClienteEmpresa = 'SI' AND @cNom_Apoderado_Cliente_1 = '' AND @cNom_Apoderado_Cliente_2 <> '' THEN 
																		'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_2 ))
																	+ ', domiciliado en ' + ltrim(rtrim(CLI.CLDIRECC)) 
																	+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																									FROM	BACPARAMSUDA..COMUNA COMU   
																											INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
																									WHERE	CLRUT = @RUT_CLIENTE),'')))
																	+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																			FROM	BACPARAMSUDA..CIUDAD CIU  
																					INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
																			WHERE CLRUT = @RUT_CLIENTE),'')
																	+ ','

														ELSE 
																'' 
														END

	--//************************************//



	   
  FROM   bacswapsuda..CARTERAHIS , Bacswapsuda..SwapGeneral A		
		 , (SELECT distinct CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX  
			FROM   BACPARAMSUDA..CLIENTE 
		    WHERE  CLRUT	= @RUT_CLIENTE 
		    and    clcodigo = @COD_CLIENTE)  CLI    
  WHERE  CARTERAHIS.numero_operacion    = @numoper
  --AND    CARTERAHIS.numero_flujo >1 
  ORDER BY tipo_flujo, numero_flujo  
  
   
  
  SELECT *
  ,		'CA_BANCO'			= (SELECT TOP 1 COMPRA_AMORTIZA	FROM #TMP_CARTERA_SWAP						ORDER BY tipo_flujo, numero_flujo)
  ,		'VA_BANCO'			= (SELECT TOP 1 VENTA_AMORTIZA		FROM #TMP_CARTERA_SWAP						ORDER BY tipo_flujo   DESC, numero_flujo)
  ,		'CA_CLIENTE'		= (SELECT TOP 1 COMPRA_AMORTIZA	FROM #TMP_CARTERA_SWAP WHERE tipo_flujo = 1 ORDER BY numero_flujo DESC)
  ,		'VA_CLIENTE'		= (SELECT TOP 1 VENTA_AMORTIZA		FROM #TMP_CARTERA_SWAP WHERE tipo_flujo = 2 ORDER BY numero_flujo DESC)  
  --,	'LOGO_BANCO'		= (select BannerLargoContrato from Bacparamsuda..Contratos_ParametrosGenerales)	
  --,	'LOGO_BANCO_CORTO'	= (select BannerCorto from Bacparamsuda..Contratos_ParametrosGenerales)
  ,		'LOGO_BANCO'		= @LOGO
  ,		'LOGO_BANCO_CORTO'	= @LOGO_BANCO_PIE_FIRMA
  ,		'LOGO_BANCO_LARGO'	= @LOGO_LARGO_CONTRATO
  ,		'DIRECC_PIE_FIRMA'	= @DIRECC_PIE_FIRMA
  ,		'URL_BANCO'			= @URL_BANCO
  FROM  #TMP_CARTERA_SWAP
  --WHERE numero_flujo > 1  
  ORDER BY tipo_flujo, numero_flujo   
  
--- DROP TABLE #TMP_CARTERA_SWAP  

END

GO
