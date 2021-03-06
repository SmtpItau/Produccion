USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_Anexo1_ContratoCompraVentaArbitrajeFuturoMonedaExtrenjera]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_Anexo1_ContratoCompraVentaArbitrajeFuturoMonedaExtrenjera

CREATE PROCEDURE [dbo].[SP_Anexo1_ContratoCompraVentaArbitrajeFuturoMonedaExtrenjera]
(						@NumContrato			NUMERIC(8)
					,	@ApoderadoClienteRut1   NUMERIC(9)	 
					,	@ApCodCli1				NUMERIC(5)	 
					,	@ApoderadoBancoRut1		NUMERIC(9)	 
					,	@ApCodBanco1			NUMERIC(5)	 
					,	@ApoderadoClienteRut2   NUMERIC(9)	 
					,	@ApCodCli2				NUMERIC(5)	 
					,	@ApoderadoBancoRut2		NUMERIC(9)	 
					,	@ApCodBanco2			NUMERIC(5)	 
					,	@Preliminar				INT			 
)							

AS 
BEGIN

	SET NOCOUNT ON
   
	DECLARE @FechaProceso	DATETIME  
	DECLARE @NomEntidad		VARCHAR(100)
	DECLARE	@DvEntidad		VARCHAR(1)
	DECLARE	@DirecEntidad	VARCHAR(100)
	DECLARE @FonoEntidad	VARCHAR(14)
	DECLARE @FaxEntidad		VARCHAR(14)
	DECLARE @LOGO_BANCO VARBINARY(MAX)
	DECLARE @LOGO VARBINARY(MAX)
	DECLARE @DIRECC_PIE_FIRMA VARCHAR(100)
	DECLARE @URL_BANCO	VARCHAR(100)
	DECLARE @LOGO_BANCO_PIE_FIRMA VARBINARY(MAX)
	DECLARE @LOGO_LARGO_CONTRATO VARBINARY(MAX)
	
	DECLARE @ApoderadoBancoNombre1 VARCHAR(100)
	DECLARE	@DvApodBanco1	VARCHAR(1)
	DECLARE @ApoderadoBancoNombre2 VARCHAR(100)
	DECLARE	@DvApodBanco2	VARCHAR(1)
		
	DECLARE @ApoderadoClienteNombre1 VARCHAR(100)
	DECLARE	@DvApodCliente1	VARCHAR(1)
	DECLARE @ApoderadoClienteNombre2 VARCHAR(100)
	DECLARE	@DvApodCliente2	VARCHAR(1)
	
	DECLARE @PrecioPactado   NUMERIC(19,4)
	DECLARE @MontoMonEstranjera NUMERIC(19,4)
	DECLARE @Monto_Escrito VARCHAR(2000)
	DECLARE @Monto_Escrito2 VARCHAR(2000)
		
	DECLARE @RutEntidad  NUMERIC(8)
	DECLARE @TipoCambioContrato VARCHAR(30)
	DECLARE @Posicion NUMERIC(8)
	DECLARE @ParidadContrato VARCHAR(30)
	
	
	DECLARE	@Nemotecnico		varchar(10)
	DECLARE @intipo				varchar(10)
	DECLARE	@inmonemi			varchar(10)                            
	DECLARE	@TipoInstrumento	varchar(20)          
	DECLARE	@MonReajustabiliad  varchar(20)                 
	DECLARE	@FecVencimientoInst DATETIME
	DECLARE	@CodigoInstrumento	varchar(10)
	DECLARE @existeMfca INT
	SET @existeMfca = 0
	
	SELECT @existeMfca = 1 FROM BacfwdSuda.dbo.mfca WHERE canumoper = @NumContrato



				
	SELECT	DISTINCT	
			@FechaProceso	=	acfecproc 
	--,		@NomEntidad		=	acnomprop	
	--,		@RutEntidad		=	acrutprop	
	--,		@DvEntidad		=	acdigprop
	--,		@DirecEntidad	=	acdirprop
	--,		@FonoEntidad	=	actelefono
	,		@FaxEntidad		=	acfax
	FROM	BacFwdSuda.dbo.mfac 


	SELECT 
			@NomEntidad				=	RazonSocial	
	,		@RutEntidad				=	RutEntidad	
	,		@DvEntidad				=	DigitoVerificador
	,		@DirecEntidad			=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad
	,		@FonoEntidad			=	TelefonoLegal
	,		@LOGO_BANCO				=	BannerLargoContrato
	,		@LOGO					=	Logo 
	,		@LOGO_LARGO_CONTRATO	=   BannerLargoContrato
	,		@DIRECC_PIE_FIRMA		=	DireccionLegalPieFirma
	,		@URL_BANCO				=	URLBanco
	,		@LOGO_BANCO_PIE_FIRMA	=	BannerCorto
	FROM bacparamsuda..Contratos_ParametrosGenerales
	

			
	SELECT	DISTINCT 
			@ApoderadoBancoNombre1	= apnombre 
	,		@DvApodBanco1			=  apdvapo
    FROM	BacParamSuda.dbo.Cliente_Apoderado
	WHERE	aprutapo = @ApoderadoBancoRut1 
	AND		apcodcli = @ApCodBanco1
	
	SELECT	DISTINCT 
			@ApoderadoBancoNombre2	= apnombre 
	,		@DvApodBanco2			=  apdvapo
    FROM	BacParamSuda.dbo.Cliente_Apoderado
	WHERE	aprutapo = @ApoderadoBancoRut2 
	AND		apcodcli = @ApCodBanco2
	
	SELECT	DISTINCT 
			@ApoderadoClienteNombre1 = apnombre  
	,		@DvApodCliente1 			= apdvapo
    FROM	BacParamSuda.dbo.Cliente_Apoderado
	WHERE	aprutapo = @ApoderadoClienteRut1
	AND		apcodcli = @ApCodCli1
	
	
	SELECT	DISTINCT 
			@ApoderadoClienteNombre2 = apnombre  
	,		@DvApodCliente2 			= apdvapo
    FROM	BacParamSuda.dbo.Cliente_Apoderado
	WHERE	aprutapo = @ApoderadoClienteRut2
	AND		apcodcli = @ApCodCli2

	DECLARE @RUTCLI AS VARCHAR(10)
	DECLARE @CODCLI AS VARCHAR(2)
	
	if @existeMfca = 1
	BEGIN	
				select 
						@RUTCLI = cacodigo
					,	@CODCLI = cacodcli 
				from BacFwdSuda.dbo.mfca 
				where canumoper = @NumContrato
	END ELSE
	BEGIN
			select 
						@RUTCLI = cacodigo
					,	@CODCLI = cacodcli 
				from BacFwdSuda.dbo.mfcaH 
				where canumoper = @NumContrato
	END

	DECLARE @ClienteEmpresa as varchar(2)
	SET  @ClienteEmpresa = 'SI'
	if exists (select * from bacparamsuda..cliente where clrut = @RUTCLI and clcodigo = @CODCLI and Cltipcli in (8, 9) )
		set @ClienteEmpresa = 'NO'
				
	--PRD 12712		
	DECLARE	@Termino_anticipado VARCHAR(1000)

    SELECT	@Termino_anticipado = CASE WHEN bearlytermination = 1 THEN 
   									'Las partes acuerdan que dentro del plazo  de diez (10) Días Hábiles contados desde el día ' 
   									+ right('00'+convert(varchar(2),DATEPART(day,fechainicio)) ,2) +   									
   									+ ' de ' 
   									+  case when datepart(month,fechainicio	) = 1  THEN 'Enero'
										    when datepart(month,fechainicio	) = 2  THEN 'Febrero'
										    when datepart(month,fechainicio	) = 3  THEN 'Marzo'
										    when datepart(month,fechainicio	) = 4  THEN 'Abril'
										    when datepart(month,fechainicio	) = 5  THEN 'Mayo'
										    when datepart(month,fechainicio	) = 6  THEN 'Junio'
										    when datepart(month,fechainicio	) = 7  THEN 'Julio'
										    when datepart(month,fechainicio	) = 8  THEN 'Agosto'
										    when datepart(month,fechainicio	) = 9  THEN 'Septiembre'
										    when datepart(month,fechainicio	) = 10 THEN 'Octubre'
										    when datepart(month,fechainicio	) = 11 THEN 'Noviembre'
										    when datepart(month,fechainicio	) = 12 THEN 'Diciembre' end
   									+ ' del ' + rtrim(DATEPART(year,fechainicio)) + ' , y con una periodicidad ' 
   									+ CASE WHEN Periodicidad = 0 THEN ''
   									       ELSE (SELECT ltrim(rtrim(gd.tbglosa))   
   												 FROM   BacParamSuda..TABLA_GENERAL_DETALLE GD 
   									             WHERE  GD.tbcateg			 = 9920
   												 AND    ca.Periodicidad      = gd.tbcodigo1 )
   									  END 
   									+ ', cualquiera de las partes tendrá la facultad de terminar en forma unilateral y anticipada el presente contrato.' 
   									+ ' La terminación deberá comunicarse a la otra parte antes de las 11:00 horas a.m. de cualquiera de los días comprendidos en el citado plazo ' 
   									+ '(en adelante,  la “Fecha de Terminación Anticipada”). Dentro de los 2 Días Hábiles siguientes a la Fecha de Terminación Anticipada deberá procederse al pago,'
   									+ ' por la parte que resulte deudora, del Valor de Mercado del contrato, calculado conforme a la Tasa de Valorización Referencial de Mercado y al Plazo residual a la Fecha de Terminación Anticipada.'

                                   ELSE 'No Aplica' END
   FROM BacFwdSuda.dbo.mfca ca
   --INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE GD ON ca.Periodicidad = gd.tbcodigo1
   WHERE ca.canumoper		= @NumContrato  
   --and GD.tbcateg			= 9920
			
				
				
	IF @existeMfca = 1
	BEGIN

		
			
		SELECT	'FechaContrato'		=	ISNULL(Ca.cafecha,0)
		,		'NumOperacion'		=	ISNULL(@NumContrato,0)
		,		'RutEntidad'		=	ISNULL(@RutEntidad,0)
		,		'DvEntidad'			=	ISNULL(@DvEntidad,'')
		,		'Entidad'			=	ISNULL(@NomEntidad,'')

		,		'ApodCliente1'		=	ISNULL(@ApoderadoClienteNombre1,'')
		,		'RutApodCliente1'	=	CASE WHEN @ApoderadoClienteRut1 > 0 THEN 
												--RTRIM(LTRIM(CONVERT(CHAR(11),ISNULL(@ApoderadoClienteRut1,0)))) + '-' + ISNULL(@DvApodCliente1,'') 
												(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoClienteRut1,0)))) ), 1), '.00', ''), ',','.'))+ '-' + ISNULL(@DvApodCliente1,'')
										ELSE
											''

										END
		,		'DvApodCliente1'	=	ISNULL(@DvApodCliente1,'')

		,		'ApodCliente2'		=	ISNULL(@ApoderadoClienteNombre2,'')
		,		'RutApodCliente2'	=	CASE WHEN @ApoderadoClienteRut2 > 0 THEN
											-- RTRIM(LTRIM(CONVERT(CHAR(11),ISNULL(@ApoderadoClienteRut2,0)))) + '-' + ISNULL(@DvApodCliente2,0)
											 (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoClienteRut2,0)))) ), 1), '.00', ''), ',','.'))+ '-' + ISNULL(@DvApodCliente2,'')
										ELSE
											''
										END
		--,		'RutApodCliente2'	=	ISNULL(@ApoderadoClienteRut2,0)
		,		'DvApodCliente2'	=	ISNULL(@DvApodCliente2,'')

		,		'ApodBanco1'		=	ISNULL(@ApoderadoBancoNombre1,'')
		
		,		'RutApodBanco1'		=	CASE WHEN @ApoderadoBancoRut1 > 0 THEN 
												--RTRIM(LTRIM(CONVERT(CHAR(11),ISNULL(@ApoderadoBancoRut1,0)))) + '-' + ISNULL(@DvApodBanco1,'')
												(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoBancoRut1,0)))) ), 1), '.00', ''), ',','.'))+ '-' + ISNULL(@DvApodBanco1,'')
										ELSE
												''
										END
		--,		'RutApodBanco1'		=	ISNULL(@ApoderadoBancoRut1,0)
		
		,		'DvApodBanco1'		=	ISNULL(@DvApodBanco1,'')

		,		'ApodBanco2'		=	ISNULL(@ApoderadoBancoNombre2,'')
		,		'RutApodBanco2'		=	CASE WHEN @ApoderadoBancoRut2 > 0 THEN 
												--RTRIM(LTRIM(CONVERT(CHAR(11),ISNULL(@ApoderadoBancoRut2,0)))) + '-' + ISNULL(@DvApodBanco2,'')
											(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoBancoRut2,0)))) ), 1), '.00', ''), ',','.'))+ '-' + ISNULL(@DvApodBanco2,'')
										ELSE
												''
										END

		--,		'RutApodBanco2'		=	ISNULL(@ApoderadoBancoRut2,0)
		,		'DvApodBanco2'		=	ISNULL(@DvApodBanco2,'')

		,		'FechaProceso'		=	ISNULL(@FechaProceso,0)

		--,		'RutCliente'		=	ISNULL(Ca.cacodigo,0)
		--,		'RutCliente'		=	(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(Ca.cacodigo,0)))) ), 1), '.00', ''), ',','.'))
		,       'RutCliente'        =   (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(Ca.cacodigo,0)))) ), 1), '.00', ''), ',','.'))
		,		'DvCliente'			=	ISNULL(Cliente.cldv,'')
		,		'NombreCliente'		=	ISNULL(Cliente.Clnombre,'')
		,		'DireccionCliente'	=	ISNULL(Cliente.Cldirecc,'')
		,		'Comuna'			=	ISNULL(Comuna.nombre,'') 
		,		'Ciudad'			=	ISNULL(Ciudad.nombre,'')
		,		'TipoTransaccion'	=	ISNULL((SELECT CASE WHEN Ca.catipoper = 'C' THEN 'COMPRA'ELSE 'VENTA' END),'')
		,		'FechaPago'			=	ISNULL(Ca.cafecvcto,0)
		,		'Vendedor'			=	ISNULL((SELECT CASE WHEN Ca.catipoper = 'V' THEN @NomEntidad ELSE Cliente.Clnombre END),'')
		,		'Comprador'			=	ISNULL((SELECT CASE WHEN Ca.catipoper = 'V' THEN Cliente.Clnombre  ELSE @NomEntidad END),'')
		,		'ModalidadCumplimiento' =	ISNULL((SELECT CASE WHEN Ca.catipmoda = 'E' THEN 'ENTREGA FISICA' ELSE 'COMPENSADO' END),'')
		,		'CodMonExtranjera'		=	ISNULL(( SELECT Mon.Mnnemo FROM BacParamSuda.DBO.Moneda  Mon WHERE Mon.mncodmon = Ca.CaCodMon1),'')
		,		'MontoMonEstranjera'	=	ISNULL(Ca.camtomon1,0)

		--,		'TipoCambioContrato'	=	CONVERT(NVARCHAR(100),'N')
		,		'TipoCambioContrato'	=	ISNULL(CASE WHEN ca.cacodpos1 = 2 AND ca.var_moneda2 > 0 THEN convert(nvarchar(max), ca.caprecal  )
														ELSE convert(nvarchar(max), ca.catipcam) --> a.capreciopunta 
													END,0) --CONVERT(NVARCHAR(100),'N')
		
		--,		'ParidadContrato'		=	ISNULL(Ca.catipcam,0) 
		,		'ParidadContrato'		=	ISNULL(CASE WHEN ca.cacodpos1 = 2 AND ca.var_moneda2 > 0 THEN convert(nvarchar(max), 'NA' )
														--WHEN ca.cacodpos1 = 1 AND ca.var_moneda2 =  0 THEN convert(nvarchar(max), 'NA' )
														ELSE convert(nvarchar(max), ca.catipcam)--> a.capreciopunta 
													END,0)


		,		'PrecioPactado'			=	ISNULL((CASE WHEN Ca.cacodpos1   = 2 AND Ca.var_moneda2 > 0 THEN Ca.camtomon1 * Ca.caprecal ELSE Ca.camtomon2 END),0)
		,		'NocionalEscrito'		=	CONVERT(VARCHAR(2000), '')
		,		'MonedaExtranjetaEscrito'	=	CONVERT(VARCHAR(2000), '')
		,		'TipoCambioReferencia'		=	ISNULL((SELECT Mon.MnGlosa FROM BacParamSuda.DBO.Moneda  Mon WHERE Mon.mncodmon = Ca.camdausd),0)
		,		'ParidadReferencia'			=	ISNULL(CASE	WHEN Ca.cacolmon1 = 1 THEN 'Reuters 11:00 Hras'     + ' -- ' + CONVERT(CHAR(10),Ca.cafijaPRRef,103)
													WHEN Ca.cacolmon1 = 2 THEN 'Pactada'                + ' -- ' + CONVERT(CHAR(10),Ca.cafijaPRRef,103)
													WHEN Ca.cacolmon1 = 3 THEN 'Banco Central Europeo'  + ' -- ' + CONVERT(CHAR(10),Ca.cafijaPRRef,103)
												ELSE '--'
												END,'')
		,		'BancosReferencia'	=''
		,		'Garantias'			= ''
		,		'FormaPago'			= ISNULL(CASE WHEN Ca.cacodpos1 = 10 THEN pg.glosa
										ELSE ( 'a) MN: ' + CASE WHEN Ca.cacodpos1 = 12 OR ( Ca.var_moneda2 > 0 AND Ca.cacodpos1 IN ( 1, 2 ) ) THEN RTRIM(ISNULL(pg.glosa, ''))
															WHEN Ca.catipmoda = 'C' AND Ca.moneda_compensacion = 13                        THEN 'N/A'
															WHEN RTRIM(isnull(pg.glosa,''))='NO APLICA'                              THEN 'N/A' 
															ELSE                                                                          RTRIM(ISNULL(pg.glosa,''))
													   END 
										 + ' b) MX: ' + CASE WHEN Ca.cacodpos1 = 12                                                      THEN RTRIM(ISNULL(pg2.glosa, ''))
															WHEN Ca.catipmoda = 'C' AND Ca.moneda_compensacion <> 13                       THEN 'N/A'
															WHEN RTRIM(isnull(pg2.glosa,''))='NO APLICA'                             THEN 'N/A' 
															ELSE                                                                          RTRIM(isnull(pg2.glosa,''))
													   END)
										END,0)
		,		'LugarCumplimiento' = 'Santiago' --Ciudad.nombre
		,		'CodConversion'		=   ISNULL(CASE WHEN Ca.var_moneda2 > 0 THEN 'CLP' ELSE f.mnnemo END,0)
		,		'fecha_condiciones_generales' = ISNULL(CASE WHEN Cliente.nuevo_ccg_firmado = 'S' THEN Cliente.fecha_firma_nuevo_ccg ELSE Cliente.clfechafirma_cond END,0)
		,		'DireccionEntidad'	= ISNULL(@DirecEntidad,'')
		,		'FonoEntidad'		= ISNULL(@FonoEntidad,'')
		,		'FaxEntidad'		= ISNULL(@FaxEntidad,'')
		,		'FonoCliente'		= ISNULL(Cliente.Clfono,'')
		,		'FaxCliente'		= ISNULL(Cliente.Clfax,'')
		--,		'Posicion'			= ISNULL(Ca.cacodpos1,0) 
		,		'Posicion'			= ISNULL(CASE	WHEN ca.cacodpos1 = 13 THEN 3
													WHEN ca.cacodpos1 = 2 AND ca.var_moneda2 > 0 THEN 12
													ELSE
														 ca.cacodpos1
													END,0) 

		,		'Preliminar'		= ISNULL(@Preliminar,0)
		,		'MontoContrato'		= ISNULL(Ca.camtomon1,0)
		,		'Nemotecnico'		=Convert(varchar(10),'')
		,		'intipo'			=Convert(varchar(10),'')
		,		'inmonemi'			=Convert(varchar(10),'')                        
		,		'TipoInstrumento'	=Convert(varchar(20),'')     
		,		'MonReajustabiliad' =Convert(varchar(20),'')                  
		,		'FecVencimientoInst'=CONVERT(DATETIME,0)
		,		'CodigoInstrumento'	=Convert(varchar(10),'') 
		,		'catasaEfectMon2'	=ISNULL(Ca.catasaEfectMon2,0)   
		,		'FechaStarting'		=ISNULL(Ca.CafechaStarting,0)
		,		'PuntosFwdCierre'	=ISNULL(Ca.CaPuntosFwdCierre,0)

		--,		'Glosa_Representante'	= CASE WHEN @ClienteEmpresa = 'SI' AND @ApoderadoClienteRut1 > 0 AND @ApoderadoClienteRut2 > 0 THEN 
		,		'Glosa_Representante'	= CASE WHEN @ClienteEmpresa = 'SI'  THEN  --> FUSION

															--'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre1 )) + ', cédula de identidad N°' 
               --                                          +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoClienteRut1,0)))) ),1), '.00',''), ',','.')) + '-' + ISNULL(@DvApodCliente1,'')








														 -- + ' y por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre2 )) + ', cédula de identidad N°' 
               --                                                                                                         +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),@ApoderadoClienteRut2))) ), 1), '.00', ''), ',','.')) +'-' + ISNULL(@DvApodCliente2,'')
															
															'representado por los apoderados individualizados al final de este contrato' --> FUSION
															+ ', ambos domiciliados en ' + ltrim(rtrim(Cliente.Cldirecc)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA --and clcodigo = Cliente.cldv
																							WHERE	CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD --and clcodigo = Cliente.cldv
																	WHERE CLRUT = @RUTCLI and CLCODIGO = @CODCLI),'')
															+ ','

												/*
											    -- *** BLOQUEADO POR FUSION *** 
												WHEN @ClienteEmpresa = 'SI' AND @ApoderadoClienteRut1 > 0 AND @ApoderadoClienteRut2 = 0 THEN 
															--'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre1 )) + ', cédula de identidad ' +  LTRIM(RTRIM( @ApoderadoClienteRut1 )) + '-' + ISNULL(@DvApodCliente1,0)
															'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre1 )) + ', cédula de identidad N°' 
                                                                                                               +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),@ApoderadoClienteRut1))) ), 1), '.00', ''), ',
','.')) + '-' + ISNULL(@DvApodCliente1,'')
															
															+ ', domiciliado en ' + ltrim(rtrim(Cliente.Cldirecc)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA --and clcodigo = Cliente.cldv
																							WHERE	CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD --and clcodigo = Cliente.cldv
																	WHERE CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')
															+ ','

												WHEN @ClienteEmpresa = 'SI' AND @ApoderadoClienteRut1 = 0 AND @ApoderadoClienteRut2 > 0 THEN  
															--'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre2 )) + ', cédula de identidad ' +  LTRIM(RTRIM( @ApoderadoClienteRut2 )) + '-' + ISNULL(@DvApodCliente2,0)
															'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre2 )) + ', cédula de identidad N°' 
                                                                                                                        +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),@ApoderadoClienteRut2))) ), 1), '.00'
, ''), ',','.')) + '-' + ISNULL(@DvApodCliente2,'')
															
															+ ', domiciliado en ' + ltrim(rtrim(Cliente.Cldirecc)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA --and clcodigo = Cliente.cldv
																							WHERE	CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD --and clcodigo = Cliente.cldv
																	WHERE CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')
															+ ','

											*/
											ELSE
														''
											END

		,   'Termino_anticipado' = @Termino_anticipado
		, 'BannerLargoContrato' = @LOGO_LARGO_CONTRATO --> (SELECT BannerLargoContrato FROM BacParamSuda..Contratos_ParametrosGenerales)
		, 'logo'				= @LOGO --> (SELECT logo FROM BacParamSuda..Contratos_ParametrosGenerales)
							
		, 'LOGO_BANCO_CORTO'	= @LOGO_BANCO_PIE_FIRMA
  ,		'DIRECC_PIE_FIRMA'	= @DIRECC_PIE_FIRMA
  ,		'URL_BANCO'			= @URL_BANCO
	
		INTO #ContratoTemporal
		FROM	BacFwdSuda.dbo.mfca Ca
		LEFT  JOIN	BacParamSuda.dbo.cliente Cliente ON Cliente.ClRut    = Ca.cacodigo     
					AND Cliente.ClCodigo = Ca.cacodcli  
		LEFT  JOIN	BacParamSuda.dbo.COMUNA Comuna  ON Cliente.Clcomuna  = Comuna.codigo_comuna         
					AND Cliente.ClCodigo = Ca.cacodcli 
		LEFT  JOIN  BacParamSuda.dbo.Ciudad Ciudad  ON Cliente.Clciudad  = Ciudad.codigo_ciudad 
		INNER JOIN  BacParamSuda.dbo.view_moneda        f   with (nolock) ON f.mncodmon    = Ca.cacodmon2 
		LEFT  JOIN	BacfwdSuda.dbo.VIEW_FORMA_DE_PAGO PG  with (nolock) ON pg.codigo     = Ca.cafpagomn
		LEFT  JOIN	BacfwdSuda.dbo.VIEW_FORMA_DE_PAGO PG2 with (nolock) ON pg2.codigo    = Ca.cafpagomx
		WHERE canumoper = @NumContrato		
		

		--select @ParidadContrato = 	(Case WHEN cacodpos1 = 1 AND var_moneda2 =  0 THEN convert(nvarchar(max), 'NA') end)
		--from BacFwdSuda.dbo.mfca 
		--WHERE canumoper = @NumContrato	

		SELECT	@PrecioPactado		=	PrecioPactado 
		,		@MontoMonEstranjera	=	MontoMonEstranjera
		,		@TipoCambioContrato =  (SELECT CASE WHEN  Posicion = 12 THEN Convert(VARCHAR(20),TipoCambioContrato)
													WHEN  Posicion = 2  THEN 'N/A'
													WHEN  Posicion = 1  THEN rtrim (CodConversion) + ' ' + Convert(VARCHAR(20),ParidadContrato)+' por '+ rtrim(CodMonExtranjera) + ' 1,00'
													ELSE  Convert(VARCHAR(20),ParidadContrato) END)
		,		@Posicion = Posicion
		,		@ParidadContrato			= (SELECT CASE WHEN Posicion = 1 OR Posicion = 12 THEN 
												Convert(VARCHAR(20),'N/A')
										ELSE 
												rtrim(CodMonExtranjera)  + ' ' + ParidadContrato +' por '+ rtrim (CodConversion) + ' 1,00'
										END)
		FROM #ContratoTemporal	
		
		
		EXECUTE BacfwdSuda.dbo.SP_MONTOESCRITO @PrecioPactado ,@Monto_Escrito OUTPUT
		EXECUTE BacfwdSuda.dbo.SP_MONTOESCRITO @MontoMonEstranjera ,@Monto_Escrito2 OUTPUT
		 	 	 
		UPDATE #ContratoTemporal 
		SET NocionalEscrito			=@Monto_Escrito
		,	MonedaExtranjetaEscrito =@Monto_Escrito2
		,	TipoCambioContrato		=@TipoCambioContrato
		,   ParidadReferencia		=(SELECT CASE WHEN ParidadReferencia = '--' THEN 'N/A' ELSE ParidadReferencia END)	
		,   ParidadContrato			=@ParidadContrato
	 
	 
		IF @Posicion = 10
		BEGIN
						
			CREATE TABLE [dbo].[#TBL_FBT](
							 Nemotecnico		[varchar] (10)
							,intipo				[varchar] (10)
							,inmonemi			[varchar] (10)                            
							,TipoInstrumento	[varchar] (20)          
							,MonReajustabiliad  [varchar] (20)                 
							,FecVencimientoInst DATETIME
							,CodigoInstrumento	[varchar] (10))
		
			INSERT INTO dbo.#TBL_FBT EXEC BacfwdSuda.dbo.SP_CON_INSTRUMENTO_FBT @NumContrato  
			
							
			SELECT	@Nemotecnico		=Nemotecnico
			,		@intipo				=intipo
			,		@inmonemi			=inmonemi                            
			,		@TipoInstrumento	=TipoInstrumento          
			,		@MonReajustabiliad  =MonReajustabiliad             
			,		@FecVencimientoInst =CONVERT(CHAR,FecVencimientoInst,103)
			,		@CodigoInstrumento	=CodigoInstrumento
			FROM #TBL_FBT
			
			UPDATE  #ContratoTemporal
			SET		Nemotecnico			= @Nemotecnico
			,		intipo				= @intipo
			,		inmonemi			= @inmonemi                        
			,		TipoInstrumento		= @TipoInstrumento    
			,		MonReajustabiliad	= @MonReajustabiliad                 
			,		FecVencimientoInst	= @FecVencimientoInst
			,		CodigoInstrumento	= @CodigoInstrumento
		 		
		END 
		
		SELECT * FROM #ContratoTemporal
		
	END
	ELSE
	BEGIN
				
		SELECT  'FechaContrato'		=	ISNULL(Cah.cafecha,0)
		,		'NumOperacion'		=	ISNULL(@NumContrato,0)
		,		'RutEntidad'		=	ISNULL(@RutEntidad,0)
		,		'DvEntidad'			=	ISNULL(@DvEntidad,'')
		,		'Entidad'			=	ISNULL(@NomEntidad,'')
		,		'ApodCliente1'		=	ISNULL(@ApoderadoClienteNombre1,'')

		,		'RutApodCliente1'	=	CASE WHEN @ApoderadoClienteRut1 > 0 THEN 
												--RTRIM(LTRIM(CONVERT(CHAR(11),ISNULL(@ApoderadoClienteRut1,0)))) + '-' + ISNULL(@DvApodCliente1,'')
												(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoClienteRut1,0)))) ), 1), '.00', ''), ',','.'))+ '-' + ISNULL(@DvApodCliente1,'')
										ELSE
												''
										END
		--,		'RutApodCliente1'	=	ISNULL(@ApoderadoClienteRut1,0)
		,		'DvApodCliente1'	=	ISNULL(@DvApodCliente1,'')

		,		'ApodCliente2'		=	ISNULL(@ApoderadoClienteNombre2,'')
		,		'RutApodCliente2'	=	CASE WHEN @ApoderadoClienteRut2 > 0 THEN 
												--RTRIM(LTRIM(CONVERT(CHAR(11),ISNULL(@ApoderadoClienteRut2,0)))) + '-' + ISNULL(@DvApodCliente2,0)
												(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoClienteRut2,0)))) ), 1), '.00', ''), ',','.'))+ '-' + ISNULL(@DvApodCliente2,'')
										ELSE
												''
										END
		--,		'RutApodCliente2'	=	ISNULL(@ApoderadoClienteRut2,0)
		,		'DvApodCliente2'	=	ISNULL(@DvApodCliente2,0)
		
		,		'ApodBanco1'		=	ISNULL(@ApoderadoBancoNombre1,'')
		,		'RutApodBanco1'		=	CASE WHEN @ApoderadoBancoRut1 > 0 THEN 
												--RTRIM(LTRIM(CONVERT(CHAR(11),ISNULL(@ApoderadoBancoRut1,0)))) + '-' +  ISNULL(@DvApodBanco1,'')
												(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoBancoRut1,0)))) ), 1), '.00', ''), ',','.'))+ '-' + ISNULL(@DvApodBanco1,'')
										ELSE
												''
										END
		--,		'RutApodBanco1'		=	ISNULL(@ApoderadoBancoRut1,0)
		,		'DvApodBanco1'		=	ISNULL(@DvApodBanco1,'')

		,		'ApodBanco2'		=	ISNULL(@ApoderadoBancoNombre2,'')
		,		'RutApodBanco2'		=	CASE WHEN @ApoderadoBancoRut2 > 0 THEN 
												--RTRIM(LTRIM(CONVERT(CHAR(11),ISNULL(@ApoderadoBancoRut2,0)))) + '-' + ISNULL(@DvApodBanco2,'')
												(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoBancoRut2,0)))) ), 1), '.00', ''), ',','.'))+ '-' + ISNULL(@DvApodBanco2,'')
										ELSE
												''
										END
		
		--,		'RutApodBanco2'		=	ISNULL(@ApoderadoBancoRut2,0)
		,		'DvApodBanco2'		=	ISNULL(@DvApodBanco2,'')

		,		'FechaProceso'		=	ISNULL(@FechaProceso,0)
		
		--,		'RutCliente'		=	ISNULL(Cah.cacodigo,0)
		--,		'RutCliente'		=	(select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(Ca.cacodigo,0)))) ), 1), '.00', ''), ',','.'))
		,       'RutCliente'        =   (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(Cah.cacodigo,0)))) ), 1), '.00', ''), ',','.'))
		
		,		'DvCliente'			=	ISNULL(Cliente.cldv,'')
		,		'NombreCliente'		=	ISNULL(Cliente.Clnombre,'')
		,		'DireccionCliente'	=	ISNULL(Cliente.Cldirecc,'')
		,		'Comuna'			=	ISNULL(Comuna.nombre,'') 
		,		'Ciudad'			=	ISNULL(Ciudad.nombre,'')
		,		'TipoTransaccion'	=	ISNULL((SELECT CASE WHEN Cah.catipoper = 'C' THEN 'COMPRA'ELSE 'VENTA' END),'')
		,		'FechaPago'			=	ISNULL(Cah.cafecvcto,0)
		,		'Vendedor'			=	ISNULL((SELECT CASE WHEN Cah.catipoper = 'V' THEN @NomEntidad ELSE Cliente.Clnombre END),'')
		,		'Comprador'			=	ISNULL((SELECT CASE WHEN Cah.catipoper = 'V' THEN Cliente.Clnombre  ELSE @NomEntidad END),'')
		,		'ModalidadCumplimiento' =	ISNULL((SELECT CASE WHEN Cah.catipmoda = 'E' THEN 'ENTREGA FISICA' ELSE 'COMPENSADO' END),'')
		,		'CodMonExtranjera'		=	ISNULL(( SELECT Mon.Mnnemo FROM BacParamSuda.DBO.Moneda  Mon WHERE Mon.mncodmon = Cah.CaCodMon1),'')
		,		'MontoMonEstranjera'	=	ISNULL(Cah.camtomon1,0)
		

		--,		'TipoCambioContrato'	=	CONVERT(NVARCHAR(100),'N')
		,		'TipoCambioContrato'	=	ISNULL(CASE WHEN cah.cacodpos1 = 2 AND cah.var_moneda2 > 0 THEN convert(nvarchar(max), cah.caprecal  )
														ELSE convert(nvarchar(max), cah.catipcam) --> a.capreciopunta 
													END,0) --CONVERT(NVARCHAR(100),'N')
		
		--,		'ParidadContrato'		=	ISNULL(Cah.catipcam,0) 
		,		'ParidadContrato'		=	ISNULL(CASE WHEN cah.cacodpos1 = 2  AND cah.var_moneda2 > 0 THEN convert(nvarchar(max), 'NA' )
														--WHEN cah.cacodpos1 = 1 AND cah.var_moneda2 =  0 THEN convert(nvarchar(max), 'NA' )
														ELSE convert(nvarchar(max), cah.catipcam)--> a.capreciopunta 
													END,0)



		,		'PrecioPactado'			=	ISNULL((CASE WHEN Cah.cacodpos1   = 2 AND Cah.var_moneda2 > 0 THEN Cah.camtomon1 * Cah.caprecal ELSE Cah.camtomon2 END),0)
		,		'NocionalEscrito'		=	CONVERT(VARCHAR(2000), '')
		,		'MonedaExtranjetaEscrito'	=	CONVERT(VARCHAR(2000), '')
		,		'TipoCambioReferencia'		=	ISNULL((SELECT Mon.MnGlosa FROM BacParamSuda.DBO.Moneda  Mon WHERE Mon.mncodmon = Cah.camdausd),0)
		,		'ParidadReferencia'			=	ISNULL(CASE	WHEN Cah.cacolmon1 = 1 THEN 'Reuters 11:00 Hras'     + ' -- ' + CONVERT(CHAR(10),Cah.cafijaPRRef,103)
													WHEN Cah.cacolmon1 = 2 THEN 'Pactada'                + ' -- ' + CONVERT(CHAR(10),Cah.cafijaPRRef,103)
													WHEN Cah.cacolmon1 = 3 THEN 'Banco Central Europeo'  + ' -- ' + CONVERT(CHAR(10),Cah.cafijaPRRef,103)
												ELSE '--'
												END,'')
		,		'BancosReferencia'	=''
		,		'Garantias'			= ''
		,		'FormaPago'			= ISNULL(CASE WHEN Cah.cacodpos1 = 10 THEN pg.glosa
										ELSE ( 'a) MN: ' + CASE WHEN Cah.cacodpos1 = 12 OR ( Cah.var_moneda2 > 0 AND Cah.cacodpos1 IN ( 1, 2 ) ) THEN RTRIM(ISNULL(pg.glosa, ''))
															WHEN Cah.catipmoda = 'C' AND Cah.moneda_compensacion = 13                        THEN 'N/A'
															WHEN RTRIM(isnull(pg.glosa,''))='NO APLICA'                              THEN 'N/A' 
															ELSE                                                                          RTRIM(ISNULL(pg.glosa,''))
													   END 
										 + ' b) MX: ' + CASE WHEN Cah.cacodpos1 = 12                                                      THEN RTRIM(ISNULL(pg2.glosa, ''))
															WHEN Cah.catipmoda = 'C' AND Cah.moneda_compensacion <> 13   THEN 'N/A'
															WHEN RTRIM(isnull(pg2.glosa,''))='NO APLICA'                             THEN 'N/A' 
															ELSE                                                                  RTRIM(isnull(pg2.glosa,''))
													   END)
										END,0)
		,		'LugarCumplimiento' = 'Santiago' --Ciudad.nombre
		,		'CodConversion'		=   ISNULL(CASE WHEN Cah.var_moneda2 > 0 THEN 'CLP' ELSE f.mnnemo END,0)
		,		'fecha_condiciones_generales' = ISNULL(CASE WHEN Cliente.nuevo_ccg_firmado = 'S' THEN Cliente.fecha_firma_nuevo_ccg ELSE Cliente.clfechafirma_cond END,0)
		,		'DireccionEntidad'	= ISNULL(@DirecEntidad,'')
		,		'FonoEntidad'		= ISNULL(@FonoEntidad,'')
		,		'FaxEntidad'		= ISNULL(@FaxEntidad,'')
		,		'FonoCliente'		= ISNULL(Cliente.Clfono,'')
		,		'FaxCliente'		= ISNULL(Cliente.Clfax,'')
		--,		'Posicion'			= ISNULL(Cah.cacodpos1,0) 
		,		'Posicion'			= ISNULL(CASE	WHEN caH.cacodpos1 = 13 THEN 3
													WHEN caH.cacodpos1 = 2 AND caH.var_moneda2 > 0 THEN 12
													ELSE
														 caH.cacodpos1
													END,0) 
		,		'Preliminar'		= ISNULL(@Preliminar,0)
		,		'MontoContrato'		= ISNULL(Cah.camtomon1,0)
		,		'Nemotecnico'		=Convert(varchar(10),'')
		,		'intipo'			=Convert(varchar(10),'')
		,		'inmonemi'			=Convert(varchar(10),'')                        
		,		'TipoInstrumento'	=Convert(varchar(20),'')     
		,		'MonReajustabiliad' =Convert(varchar(20),'')                  
		,		'FecVencimientoInst'=CONVERT(DATETIME,0)
		,		'CodigoInstrumento'	=Convert(varchar(10),'') 
		,		'catasaEfectMon2'	=ISNULL(Cah.catasaEfectMon2,0)   
		,		'FechaStarting'		=ISNULL(Cah.CafechaStarting,0)
		,		'PuntosFwdCierre'	=ISNULL(Cah.CaPuntosFwdCierre,0)

		--,		'Glosa_Representante'	=  CASE WHEN @ClienteEmpresa = 'SI' AND @ApoderadoClienteRut1 > 0 AND @ApoderadoClienteRut2 > 0 THEN 
		,		'Glosa_Representante'	=  CASE WHEN @ClienteEmpresa = 'SI' THEN  --> FUSION
															--  'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre1 )) + ', cédula de identidad N°' 
               --                                                                                                         +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),ISNULL(@ApoderadoClienteRut1,0))))), 1), '.00',''), ',','.')) + '-' + ISNULL(@DvApodCliente1,'')
															----+ ' y por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @ApoderadoClienteRut2 ))  + '-' + ISNULL(@DvApodCliente2,0)															--+ ' y por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre2 )) + ', cédula de identidad N°' 
               --                                                                                                         +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),@ApoderadoClienteRut2))) ), 1), '.00', ''), ',','.')) +'-' + ISNULL(@DvApodCliente2,'')
															
															
																'representado por los apoderados individualizados al final de este contrato' --> FUSION
															+ ', ambos domiciliados en ' + ltrim(rtrim(Cliente.Cldirecc)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA --and clcodigo = Cliente.cldv
																							WHERE	CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD --and clcodigo = Cliente.cldv
																	WHERE CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')
															+ ','

											/**
											/** bloqueado por Fusion **/
												WHEN @ClienteEmpresa = 'SI' AND @ApoderadoClienteRut1 > 0 AND @ApoderadoClienteRut2 = 0 THEN 
															--'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre1 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @ApoderadoClienteRut1 )) + '-' + ISNULL(@DvApodCliente1,0)
															'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre1 )) + ', cédula de identidad N°' 
                                                                                         +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),@ApoderadoClienteRut1))) ), 1), '.00', ''), ',','.')) + '-' + ISNULL
(@DvApodCliente1,'')
															+ ', domiciliado en ' + ltrim(rtrim(Cliente.Cldirecc)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA --and clcodigo = Cliente.cldv
																							WHERE	CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD --and clcodigo = Cliente.cldv
																	WHERE CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')
															+ ','

												WHEN @ClienteEmpresa = 'SI' AND @ApoderadoClienteRut1 = 0 AND @ApoderadoClienteRut2 > 0 THEN  
															--'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @ApoderadoClienteRut2 )) + '-' + ISNULL(@DvApodCliente2,0)
															'representado por don ' + LTRIM(RTRIM( @ApoderadoClienteNombre2 )) + ', cédula de identidad N°' 
                                                                                                                        +  (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),@ApoderadoClienteRut2))) ), 1), '.00'
, ''), ',','.')) + '-' + ISNULL(@DvApodCliente2,'')
															+ ', domiciliado en ' + ltrim(rtrim(Cliente.Cldirecc)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA --and clcodigo = Cliente.cldv
																							WHERE	CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD --and clcodigo = Cliente.cldv
																	WHERE CLRUT = @RUTCLI AND CLCODIGO = @CODCLI),'')
															+ ','

											**/
											ELSE
														''
											END

	--	,   'Termino_anticipado' = @Termino_anticipado			
		
		 ,   'Termino_anticipado' = CASE WHEN Cah.bearlytermination = 1 THEN 
   									'Las partes acuerdan que dentro del plazo  de diez (10) Días Hábiles contados desde el día ' 
   									+ right('00'+convert(varchar(2),DATEPART(day,fechainicio)) ,2) +   									
   									+ ' de ' 
   									+  case when datepart(month,fechainicio	) = 1  THEN 'Enero'
										    when datepart(month,fechainicio	) = 2  THEN 'Febrero'
										    when datepart(month,fechainicio	) = 3  THEN 'Marzo'
										    when datepart(month,fechainicio	) = 4  THEN 'Abril'
										    when datepart(month,fechainicio	) = 5  THEN 'Mayo'
										    when datepart(month,fechainicio	) = 6  THEN 'Junio'
										    when datepart(month,fechainicio	) = 7  THEN 'Julio'
										    when datepart(month,fechainicio	) = 8  THEN 'Agosto'
										    when datepart(month,fechainicio	) = 9  THEN 'Septiembre'
										    when datepart(month,fechainicio	) = 10 THEN 'Octubre'
										    when datepart(month,fechainicio	) = 11 THEN 'Noviembre'
										    when datepart(month,fechainicio	) = 12 THEN 'Diciembre' end
   									+ ' del ' + rtrim(DATEPART(year,fechainicio)) + ' , y con una periodicidad ' 
   									+ CASE WHEN Periodicidad = 0 THEN ''
   									       ELSE (SELECT ltrim(rtrim(gd.tbglosa))   
   												 FROM   BacParamSuda..TABLA_GENERAL_DETALLE GD 
   									           WHERE  GD.tbcateg			 = 9920
   												 AND    cah.Periodicidad      = gd.tbcodigo1 )
   									  END 
   									+ ', cualquiera de las partes tendrá la facultad de terminar en forma unilateral y anticipada el presente contrato.' 
   									+ ' La terminación deberá comunicarse a la otra parte antes de las 11:00 horas a.m. de cualquiera de los días comprendidos en el citado plazo ' 
   									+ '(en adelante,  la “Fecha de Terminación Anticipada”). Dentro de los 2 Días Hábiles siguientes a la Fecha de Terminación Anticipada deberá procederse al pago,'
   									+ ' por la parte que resulte deudora, del Valor de Mercado del contrato, calculado conforme a la Tasa de Valorización Referencial de Mercado y al Plazo residual a la Fecha de Terminación Anticipada.'

                                   ELSE 'No Aplica' END
		
		, 'BannerLargoContrato' = @LOGO_LARGO_CONTRATO --> (SELECT BannerLargoContrato FROM BacParamSuda..Contratos_ParametrosGenerales)
		, 'logo'				= @LOGO --> (SELECT logo FROM BacParamSuda..Contratos_ParametrosGenerales)
							
		, 'LOGO_BANCO_CORTO'	= @LOGO_BANCO_PIE_FIRMA
  ,		'DIRECC_PIE_FIRMA'	= @DIRECC_PIE_FIRMA
  ,		'URL_BANCO'			= @URL_BANCO


		INTO #ContratoTemporalMfach
		FROM	BacFwdSuda.dbo.mfcah Cah
		LEFT  JOIN	BacParamSuda.dbo.cliente Cliente ON Cliente.ClRut    = Cah.cacodigo        
					AND Cliente.ClCodigo = Cah.cacodcli  
		LEFT  JOIN	BacParamSuda.dbo.COMUNA Comuna  ON Cliente.Clcomuna  = Comuna.codigo_comuna         
					AND Cliente.ClCodigo = Cah.cacodcli 
		LEFT  JOIN  BacParamSuda.dbo.Ciudad Ciudad  ON Cliente.Clciudad  = Ciudad.codigo_ciudad 
		INNER JOIN  BacParamSuda.dbo.view_moneda        f   with (nolock) ON f.mncodmon    = Cah.cacodmon2 
		LEFT  JOIN	BacfwdSuda.dbo.VIEW_FORMA_DE_PAGO PG  with (nolock) ON pg.codigo     = Cah.cafpagomn
		LEFT  JOIN	BacfwdSuda.dbo.VIEW_FORMA_DE_PAGO PG2 with (nolock) ON pg2.codigo    = Cah.cafpagomx
		WHERE canumoper = @NumContrato
		
		--		select @ParidadContrato = 	(Case WHEN cacodpos1 = 1 AND var_moneda2 =  0 THEN convert(nvarchar(max), 'NA') end)
		--from BacFwdSuda.dbo.mfcah 
		--WHERE canumoper = @NumContrato	
		
		
		SELECT	@PrecioPactado		=	PrecioPactado 
		,		@MontoMonEstranjera	=	MontoMonEstranjera
		,		@TipoCambioContrato =  (SELECT CASE WHEN  Posicion = 12 THEN Convert(VARCHAR(20),TipoCambioContrato)		
														WHEN  Posicion = 2  THEN 'N/A'
														WHEN  Posicion = 1  THEN rtrim (CodConversion) + ' ' + Convert(VARCHAR(20),ParidadContrato)+' por '+ rtrim(CodMonExtranjera) + ' 1,00'
														ELSE  Convert(VARCHAR(20),ParidadContrato) END)
		,@Posicion = Posicion
		,@ParidadContrato			= (SELECT CASE WHEN Posicion = 1 OR Posicion = 12 THEN 
												Convert(VARCHAR(20),'N/A')
										ELSE 
												rtrim(CodMonExtranjera)  + ' ' + ParidadContrato +' por '+ rtrim (CodConversion) + ' 1,00'
										END)
		FROM #ContratoTemporalMfach
	
		EXECUTE BacfwdSuda.dbo.SP_MONTOESCRITO @PrecioPactado ,@Monto_Escrito OUTPUT
		EXECUTE BacfwdSuda.dbo.SP_MONTOESCRITO @MontoMonEstranjera ,@Monto_Escrito2 OUTPUT
	 	 	 
		UPDATE #ContratoTemporalMfach 
		SET NocionalEscrito			=@Monto_Escrito
		,	MonedaExtranjetaEscrito =@Monto_Escrito2
		,	TipoCambioContrato		=@TipoCambioContrato
		,   ParidadReferencia		=(SELECT CASE WHEN ParidadReferencia = '--' THEN 'N/A' ELSE ParidadReferencia END)
		,   ParidadContrato			=@ParidadContrato
	 
		IF @Posicion = 10
		BEGIN
				
			
			CREATE TABLE [dbo].[#TBL_FBTMfcah](
							 Nemotecnico		[varchar] (10)
							,intipo				[varchar] (10)
							,inmonemi			[varchar] (10)                            
							,TipoInstrumento	[varchar] (20)          
							,MonReajustabiliad  [varchar] (20)                 
							,FecVencimientoInst DATETIME
							,CodigoInstrumento	[varchar] (10))
		
			INSERT INTO dbo.#TBL_FBTMfcah EXEC BacfwdSuda.dbo.SP_CON_INSTRUMENTO_FBT @NumContrato  
			
							
			SELECT	@Nemotecnico		=Nemotecnico
			,		@intipo				=intipo
			,		@inmonemi			=inmonemi                            
			,		@TipoInstrumento	=TipoInstrumento          
			,		@MonReajustabiliad  =MonReajustabiliad             
			,		@FecVencimientoInst =CONVERT(CHAR,FecVencimientoInst,103)
			,		@CodigoInstrumento	=CodigoInstrumento
			FROM #TBL_FBTMfcah
			
			UPDATE  #ContratoTemporalMfach
			SET		Nemotecnico			= @Nemotecnico
			,		intipo				= @intipo
			,		inmonemi			= @inmonemi                        
			,		TipoInstrumento		= @TipoInstrumento    
			,		MonReajustabiliad	= @MonReajustabiliad                 
			,		FecVencimientoInst	= @FecVencimientoInst
			,		CodigoInstrumento	= @CodigoInstrumento
		 		
		END 
		
		SELECT * FROM #ContratoTemporalMfach
	
	END	

END


GO
