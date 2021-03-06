USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_Condiciones_Generales_Swap]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- CONTRATO_MARCO_RENTA_FIJA 97004000, 1, 10042615, 11937406, 13671071, 8938886, 0, 0, 0, 1

CREATE PROCEDURE [dbo].[CONTRATO_Condiciones_Generales_Swap]
(  
	 		@RUT_CLIENTE		AS NUMERIC(11)  
	 ,		@COD_CLIENTE		AS NUMERIC(10)  
	 ,		@RUT_APODERADO1		AS NUMERIC(11) = 0  
	 ,		@RUT_APODERADO2		AS NUMERIC(11) = 0  
	 ,		@RUT_APODERADOB1	AS NUMERIC(11) = 0  
	 ,		@RUT_APODERADOB2	AS NUMERIC(11) = 0  
	 ,		@NUM_OPER			AS NUMERIC(10) = 0
	 ,		@TIPO_OPER			AS VARCHAR(80)
	 ,		@NUM_AVALES			AS NUMERIC(9)
	 ,		@Preliminar			AS NUMERIC(9)
	 ,		@ClausulaTipoPago	AS NUMERIC(1) = 0
	 ,		@ClausulaCustodia	AS NUMERIC(1) = 0
  
)  
AS  
BEGIN  
SET NOCOUNT ON  


DECLARE @TieneAval			as numeric(5)
DECLARE @FinTexto			as int
DECLARE @RegimenConyugal	as varchar(10)
DECLARE @ClausulaAval		as varchar(2)
DECLARE @FechaFinal			as datetime

DECLARE @GlosaConyu	AS VARCHAR(2000)

DECLARE @Inicio int

	SET @ClausulaAval = 'NO'
	SET @TieneAval			= 0

	if @NUM_AVALES = 0
	begin
		SET @TieneAval			= 1
	end else
	begin
		SET @TieneAval			= (select count(*) from BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  where rut_cliente = @RUT_CLIENTE)
	end
	
	
	
	SET @RegimenConyugal	= (select TOP 1 REGIMEN_CONYUGA_AVAL from bacparamsuda..TBL_AVAL_CLIENTE_DERIVADO where rut_cliente = @RUT_CLIENTE)

	if exists (SELECT * FROM CONTRATO_ContratosClausulasSeleccionadas   where clausula in  ('RAG7','RAG4', 'AS4'))
									SET @ClausulaAval = 'SI'


declare @Clau3 numeric(2)
declare @Clau4 numeric(2)
declare @NumeraClausula numeric(2)
set @Clau3 = 0
set @Clau4 = 0
set @NumeraClausula = 0
if exists (SELECT * FROM CONTRATO_ContratosClausulasSeleccionadas   where clausula in  ('RAG5'))
									SET @Clau3 = 1
if exists (SELECT * FROM CONTRATO_ContratosClausulasSeleccionadas   where clausula in  ('RAG7'))
									SET @Clau4 = 1
if @Clau3 = 0 AND @Clau4 = 1
		set @NumeraClausula = 1


	DECLARE @NomEntidad		VARCHAR(100)
	DECLARE @RutEntidad		NUMERIC(12)
	DECLARE	@DvEntidad		VARCHAR(1)
	DECLARE @CodEntidad		VARCHAR(2)
	DECLARE	@DirecEntidad	VARCHAR(100)
	DECLARE @FonoEntidad	VARCHAR(14)
	DECLARE @ComunaEntidad	VARCHAR(30)
	DECLARE @CiudadEntidad	VARCHAR(30)


   	SELECT DISTINCT
			@NomEntidad		=	RazonSocial	
	,		@RutEntidad		=	RutEntidad	
	,		@DvEntidad		=	DigitoVerificador
	,		@CodEntidad		=   CodigoEntidad
	,		@DirecEntidad	=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad
	,		@FonoEntidad	=	TelefonoLegal
	,		@ComunaEntidad  =	Comuna
	,		@CiudadEntidad  =	Ciudad
	FROM bacparamsuda..Contratos_ParametrosGenerales


	DECLARE @cNom_Apoderado_Banco_1		VARCHAR(40);	SET @cNom_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados(@RutEntidad, @CodEntidad, @RUT_APODERADOB1, 1)
	DECLARE @cRut_Apoderado_Banco_1		VARCHAR(40);	SET	@cRut_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB1, 2)
	DECLARE @cNom_Apoderado_Banco_2		VARCHAR(40);	SET @cNom_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB2, 1)
	DECLARE @cRut_Apoderado_Banco_2		VARCHAR(40);	SET	@cRut_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad,@RUT_APODERADOB2, 2)
	DECLARE @cNom_Apoderado_Cliente_1	VARCHAR(40);	SET @cNom_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO1, 1)
	DECLARE @cRut_Apoderado_Cliente_1	VARCHAR(40);	SET @cRut_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO1, 2)
	DECLARE @cNom_Apoderado_Cliente_2	VARCHAR(40);	SET @cNom_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO2, 1)
	DECLARE @cRut_Apoderado_Cliente_2	VARCHAR(40);	SET @cRut_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO2, 2)

	declare @dvb1 varchar(2)
	declare @dvb2 varchar(2)
	declare @dvc1 varchar(2)
	declare @dvc2 varchar(2)
	set @dvb1 = ''
	set @dvb2 = ''
	set @dvc1 = ''
	set @dvc2 = ''

	if @cRut_Apoderado_Banco_1 <> ''
	begin
		set @dvb1 = SUBSTRING(@cRut_Apoderado_Banco_1,len(@cRut_Apoderado_Banco_1),+1)
		set @cRut_Apoderado_Banco_1 = SUBSTRING(@cRut_Apoderado_Banco_1,1,CHARINDEX('-',@cRut_Apoderado_Banco_1)-1)  
		set	@cRut_Apoderado_Banco_1	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Banco_1))) ), 1), '.00', ''), ',','.'))+'-' +@dvb1
	end
	
	if @cRut_Apoderado_Banco_2 <> ''
	begin
		set @dvb2 = SUBSTRING(@cRut_Apoderado_Banco_2,len(@cRut_Apoderado_Banco_2),+1)
		set @cRut_Apoderado_Banco_2 = SUBSTRING(@cRut_Apoderado_Banco_2,1,CHARINDEX('-',@cRut_Apoderado_Banco_2)-1)  
		set	@cRut_Apoderado_Banco_2	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Banco_2))) ), 1), '.00', ''), ',','.'))+'-' +@dvb2
	end
	
	if @cRut_Apoderado_Cliente_1 <> ''
	begin
		set @dvc1 = SUBSTRING(@cRut_Apoderado_Cliente_1,len(@cRut_Apoderado_Cliente_1),+1)
		set @cRut_Apoderado_Cliente_1 = SUBSTRING(@cRut_Apoderado_Cliente_1,1,CHARINDEX('-',@cRut_Apoderado_Cliente_1)-1)  
		set	@cRut_Apoderado_Cliente_1	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Cliente_1))) ), 1), '.00', ''), ',','.'))+'-' +@dvc1
	end
	
	if @cRut_Apoderado_Cliente_2 <> ''
	begin
		set @dvc2 = SUBSTRING(@cRut_Apoderado_Cliente_2,len(@cRut_Apoderado_Cliente_2),+1)
		set @cRut_Apoderado_Cliente_2 = SUBSTRING(@cRut_Apoderado_Cliente_2,1,CHARINDEX('-',@cRut_Apoderado_Cliente_2)-1)  
		set	@cRut_Apoderado_Cliente_2	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Cliente_2))) ), 1), '.00', ''), ',','.'))+'-' +@dvc2
	end

	DECLARE @ClienteEmpresa as varchar(2)
	SET  @ClienteEmpresa = 'SI'
	if exists (select * from bacparamsuda..cliente where clrut = @RUT_CLIENTE and clcodigo = @COD_CLIENTE and Cltipcli in (8, 9) )
		set @ClienteEmpresa = 'NO'

	DECLARE @TieneApoderado as varchar(2)
	SET @TieneApoderado = 'SI'
   if @cNom_Apoderado_Cliente_1 = ''
		set @TieneApoderado = 'NO'



	--SET @FechaFinal	=  DBO.Fx_Retorna_FechaContrato (@RUT_CLIENTE, @COD_CLIENTE )

	SELECT    
				 --'FECHA_CONTRATO'				= FECHAPROC  
					--'FECHA_CONTRATO'			= dbo.Fx_Retorna_Mes( BANCO.FECHAPROC )		
						'FECHA_CONTRATO'		= dbo.Fx_Retorna_Mes( DBO.Fx_Retorna_FechaContrato (@RUT_CLIENTE, @COD_CLIENTE ))	
							       						
				,	'CLIENTE'					= CLNOMBRE  
				
				,	RUT_CLIENTE  
				--, 'RUT_CLIENTE' = (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),RUT_CLIENTE))) ), 1), '.00', ''), ',','.'))
				
				,	'NUMERO_OPERACION'			= @NUM_OPER
				,	'DIRECCION_CLI'				= CLI.CLDIRECC  
				,	'FONO_CLI'					= CLI.CLFONO
				,	'FAX_CLI'					= CLI.CLFAX

				,	'COMUNA'					= --COMUNA.NOMBRE  
				ISNULL ((SELECT	COMU.NOMBRE 
				FROM	BACPARAMSUDA..COMUNA COMU   
						INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
				WHERE	CLRUT = @RUT_CLIENTE),'')



				,	'CIUDAD'					= --CIUDAD.NOMBRE  
				ISNULL ((SELECT	NOMBRE 
				FROM	BACPARAMSUDA..CIUDAD CIU  
						INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
				WHERE CLRUT = @RUT_CLIENTE),'')

				----------------------------------------------------------------------------------------------------------
				,	'APODERADO_CLIENTE_1'		= @cNom_Apoderado_Cliente_1
				,	'RUT_APODERADO_CLIENTE_1'	= @cRut_Apoderado_Cliente_1
				--,	'RUT_APODERADO_CLIENTE_1'	= (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),@cRut_Apoderado_Cliente_1))) ), 1), '.00', ''), ',','.'))

				,	'APODERADO_CLIENTE_2'		= @cNom_Apoderado_Cliente_2
				,	'RUT_APODERADO_CLIENTE_2'	= @cRut_Apoderado_Cliente_2
				----------------------------------------------------------------------------------------------------------

				,	'FECHA_ESCRITURA_CLIENTE'	= dbo.Fx_Retorna_Mes( CLI.FECHA_ESCRITURA )			
	
				,	'NOMBRE_BANCO'				= Banco.nombre
				
				--,	'RUT_BANCO'					= RTRIM(LTRIM(CONVERT(CHAR(10),Banco.rut))) + '-' + '9'
				,	'RUT_BANCO'					= (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),Banco.rut))) ), 1), '.00', ''), ',','.')) + '-' + @DvEntidad
				

				-----------------------------------------------------------------------------------------------------------------------------
				,	'APODERADO_BANCO_1'			= LTRIM(RTRIM( @cNom_Apoderado_Banco_1 ))
				,	'RUT_APODERADO_BANCO_1'		= LTRIM(RTRIM( @cRut_Apoderado_Banco_1 ))
				--,	'RUT_APODERADO_BANCO_1'		= (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(@cRut_Apoderado_Banco_1 ))), 1), '.00', ''), ',','.'))

				,	'APODERADO_BANCO_2'			= LTRIM(RTRIM( @cNom_Apoderado_Banco_2 ))
				,	'RUT_APODERADO_BANCO_2'		= LTRIM(RTRIM( @cRut_Apoderado_Banco_2 ))
				-----------------------------------------------------------------------------------------------------------------------------

				--,	'FECHA_ESCRITURA_BANCO'		= dbo.Fx_Retorna_Mes( Banco.fecha_escritura )	
				,	'DIRECCION_BANCO'			= DIRECCION  
				
				,	'COMUNA_BANCO'				= Banco.comuna
				,	'CIUDAD_BANCO'				= Banco.Ciudad
				,	'TELEFONO_BANCO'			= TELEFONOLEGAL
				--,	'FAX_BANCO'					= FAX
				,	'SISTEMA'					= CLAU.SISTEMA  
				,	CLAU.CONTRATO  
				,	CLAU.CATEGORIA  
				,	CLAU.CLAUSULA  
	
				,	GLOSA1 
				--,	GLOSA2 
				,	GLOSA2						= 	(SELECT GLOSAFINAL = DBO.Fx_Retorna_GlosaFinal (GLOSA2, @RUT_CLIENTE, @NUM_AVALES, 'Glosa2', @RegimenConyugal, @NumeraClausula)) 
				--,	'GLOSA2'					= 	GLOSA2

												
				,	GLOSA3						
					
				,	'EMPRESA AVAL'				= NOMBRE_AVAL
				,	'RUT_EMPRESA_AVAL'			= RUT_EMPRESA_AVAL
				,	'DIRECCION_AVAL'			= DIRECCION_AVAL
				,	'FONO_AVAL'					= FONO_AVAL
				,	RUT_APOD_AVAL_1
				,	NOM_APOD_AVAL_1
				,	RUT_APOD_AVAL_2
				,	NOM_APOD_AVAL_2
				,	'TIPO_OPERACION'			= CASE WHEN CLAU.SISTEMA = 'PCS' THEN 
														CASE WHEN @TIPO_OPER = 2 THEN -- = 'SM' THEN--'MONEDA' THEN 
																'PERMUTA FINANCIERA(CROSS CURRENCY SWAP) SOBRE UNIDADES DE INTERES Y DIVISAS'
														WHEN @TIPO_OPER = 1 OR @TIPO_OPER = 4 THEN --= 'ST' OR @TIPO_OPER = 'SP' THEN--= 'TASA' OR @TIPO_OPER = 'CAMARA' THEN 
																'SWAP DE TASA DE INTERES' 
														ELSE 
																'' 
														END
											--END
												ELSE
														CASE WHEN @TIPO_OPER = 1 OR @TIPO_OPER = 2 OR @TIPO_OPER = 12  OR @TIPO_OPER = 14 THEN --= 'Moneda' OR @TIPO_OPER = 'Arbitraje a futuro' OR @TIPO_OPER = 'Arbitraje Moneda MX-$' OR @TIPO_OPER = 'Forward Observado' THEN
																	'COMPRAVENTA Y ARBITRAJE A FUTURO DE MONEDA EXTRANJERA'
															WHEN @TIPO_OPER = 3 THEN --= 'Seguro Inflación' THEN 
																	'FORWARD SOBRE UNIDADES DE REAJUSTABILIDAD E ÍNDICES DE TASAS PROMEDIOS'
															WHEN @TIPO_OPER = 10 THEN --= 'Forward Bon Trades' THEN 
																	'FORWARD SOBRE TASAS DE INTERÉS DE INSTRUMENTOS DE RENTA FIJA Y DE INTERMEDIACIÓN FINANCIERA'
														ELSE
																	''
														END
												END			
				,	'Preliminar'				= @Preliminar

				,	GLOSA_FIRMAS_1				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 1 then 
																		(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 1))

														--WHEN  @NUM_AVALES >= 2 then
															--(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 1, 2)) 
														ELSE
														  'Sin Firma'
														
													END
				,	GLOSA_FIRMAS_2				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 2 then 
																		(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 2)) 

														---WHEN @NUM_AVALES >= 4 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 3, 4))
													ELSE
														'Sin Firma'
													END

				,	GLOSA_FIRMAS_3				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 3 then 
																(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 3)) 
														--WHEN @NUM_AVALES >= 6 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 5, 6))
														ELSE
															'Sin Firma'
														END

				,	GLOSA_FIRMAS_4				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 4 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 4)) 
														--WHEN @NUM_AVALES >= 8 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 7, 8))
														ELSE
															'Sin Firma'
														END

				,	GLOSA_FIRMAS_5				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 5 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 5)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
															'Sin Firma'
														END
				,	GLOSA_FIRMAS_6				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 6 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 6)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
															'Sin Firma'
														END
				,	GLOSA_FIRMAS_7				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 7 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 7)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
															'Sin Firma'
														END
				,	GLOSA_FIRMAS_8				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 8 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 8)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
															'Sin Firma'
														END
				,	GLOSA_FIRMAS_9				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 9 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 9)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
															'Sin Firma'
														END
				,	GLOSA_FIRMAS_10				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 10 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 10)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
															'Sin Firma'
														END

				,   GLOSA_REPRESENTANTE			= 
														--CASE WHEN @ClienteEmpresa = 'SI' AND @cNom_Apoderado_Cliente_1 <> '' AND @cNom_Apoderado_Cliente_2 <> '' THEN 
														CASE WHEN @ClienteEmpresa = 'SI' THEN  --> FUSION
														 --	'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_1 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_1 ))
															--+ ' y por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_2 ))
															
															'representado por los apoderados individualizados al final de este contrato' --> FUSION
															+ ', domiciliados en ' + ltrim(rtrim(CLI.CLDIRECC)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
																							WHERE	CLRUT = @RUT_CLIENTE),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
																	WHERE CLRUT = @RUT_CLIENTE),'')
															+ ','

														/*
														-- *** BLOQUEADO POR FUSION ***	
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
											
														*/
													ELSE
													''
													END 
												
				,	INDICE_ORDEN 
	
				  ,   'LogoBanco'   = (select BannerLargoContrato from bacparamsuda..Contratos_ParametrosGenerales)  

				  ,	'Clausula_Tipo_Pago'	= @ClausulaTipoPago

				  , ' Clausula_Custodia'	= @ClausulaCustodia

				-- , 'Correo_Cliente_SIGA'	= (select top 1 email from bacparamsuda..cliente where clrut = @RUT_CLIENTE)
				
				, 'Correo_Cliente_SIGA'	= (select top 1 dir_nombre from BDC72.dbo.DIRECCION where par_tdi_id = 'TDIREECOME' and per_id = @RUT_CLIENTE) --> Para Fusion
			
	FROM 
		(	SELECT		CT.SISTEMA  
					,	CONTRATO  
					,	CATEGORIA  
					,	CLAUSULA  
					,	GLOSA1  
					,	GLOSA2	=	CASE WHEN CLAUSULA IN ('RAG7','RAG4', 'AS4') and @TieneAval > 0 THEN
										
									
											(select Avales = (
																SELECT REPLACE(
																				SUBSTRING(GLOSA2,1,DATALENGTH(GLOSA2))
																				, '@AVALES'
																				, dbo.Fx_Retorna_Avales(@RUT_CLIENTE, @NUM_AVALES, 'Glosa2', @RegimenConyugal)
																			   )
																FROM bacparamsuda..TBL_CLAUSULAS 
																WHERE sistema		= CT.SISTEMA 
																and tipo_contrato	= CT.CONTRATO
																and codigo_clausula = CT.CLAUSULA
															)
											)
										
		 							
									ELSE
											
											-- CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES = 0 then
											
											--	''
											--else
											
											--		GLOSA2
											--end

											CASE WHEN CLAUSULA IN ('RAG4') and @TieneAval = 0 and Contrato = 'ACCE' THEN
																''
													WHEN CLAUSULA IN ('RAG7', 'AS4') and @TieneAval = 0 and Contrato = 'ASCG' THEN	
																		''			
													ELSE
															GLOSA2
													END	


									END



					,	NOMBRE_AVAL				= 	CASE WHEN @NUM_AVALES > 0 THEN 
															ISNULL(( SELECT TOP 1 NOMBRE_AVAL
																FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
													ELSE
														'Sin Aval'
													END

					,	RUT_EMPRESA_AVAL		= 	ISNULL(( SELECT TOP 1 LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL
																FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
					,	DIRECCION_AVAL			= 	ISNULL(( SELECT TOP 1 DIRECCION_AVAL
																FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
					,	FONO_AVAL				=	ISNULL((SELECT CLFONO FROM BACPARAMSUDA..CLIENTE 
																WHERE CLRUT = (SELECT TOP 1 RUT_AVAL 
																				FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																				WHERE rut_cliente = @RUT_CLIENTE)),'Sin Info')
																	
					,	GLOSA3					=	CASE WHEN CLAUSULA IN ('RAG7','RAG4', 'AS4') and @TieneAval > 0  THEN
																(select Avales = dbo.Fx_Retorna_Avales(@RUT_CLIENTE, @NUM_AVALES,'Glosa3',@RegimenConyugal))
																								
													ELSE
															''
													END	
		
					,	RUT_APOD_AVAL_1			=	ISNULL((SELECT TOP 1 LTRIM(RTRIM(CONVERT(CHAR(10),RUT_APOD_AVAL_1))) + '-' + DV_RAA_1
																FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
					,	NOM_APOD_AVAL_1			=	ISNULL((SELECT TOP 1 NOM_APOD_AVAL_1 
																FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
					,	RUT_APOD_AVAL_2			=	ISNULL((SELECT TOP 1 LTRIM(RTRIM(CONVERT(CHAR(10),RUT_APOD_AVAL_2))) + '-' + DV_RAA_2
														 FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
					,	NOM_APOD_AVAL_2			=	ISNULL((SELECT TOP 1 NOM_APOD_AVAL_2 
																FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
				   	,	'INDICE_ORDEN' = (INDICE_ORDEN - @NumeraClausula)
				   ,	UTILIZA_AVAL  
				   ,	ACTIVA  
	   
			FROM   
					CONTRATO_ContratosClausulasSeleccionadas  CT  
				,   BACPARAMSUDA..TBL_CLAUSULAS CLA  
			WHERE	CATEGORIA		IN ('CLAUSULA') 
			AND		CT.Rut_Cliente	= @RUT_CLIENTE
			AND		CT.CONTRATO		= CLA.TIPO_CONTRATO  
			AND		CT.CLAUSULA		= CLA.CODIGO_CLAUSULA  
			AND		CLA.SISTEMA		= CT.SISTEMA   
		)	CLAU 

	--select * from CONTRATO_ContratosClausulasSeleccionadas

	 			
			
		 --,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX ,FECHA_ESCRITURA 
			--		FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  

		, (SELECT	CLNOMBRE
--		RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT)))		
		--, RUT_CLIENTE = (select replace (replace (convert (varchar(20), convert(money, CLRUT ), 1), '.00', ''), ',','.'))
		--, RUT_CLIENTE = (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),CLRUT))) ), 1), '.00', ''), ',','.'))
		, RUT_CLIENTE = (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.'))))
		+ '-' 
		+ ltrim(rtrim(CLDV))
		, CLDIRECC
		, CLFONO
		, CLFAX 
		, FECHA_ESCRITURA 
		FROM BACPARAMSUDA..CLIENTE
		WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE) CLI


		 --, (	SELECT	COMU.NOMBRE 
			--	FROM	BACPARAMSUDA..COMUNA COMU   
			--			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
			--	WHERE	CLRUT = @RUT_CLIENTE
			--)	COMUNA

		 --, (	SELECT	NOMBRE 
			--	FROM	BACPARAMSUDA..CIUDAD CIU  
			--			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
			--	WHERE CLRUT = @RUT_CLIENTE
			--)	CIUDAD  

		--SELECT FECHA_ESCRITURA FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = 97004000
		--/***************
		
		
	--	 ,(SELECT	entidad
	--	, codigo
	--	, nombre          = clnombre
 --     		, rut             = clrut
 --     		, direccion       = isnull( cldirecc, '')
	--	, comuna          = isnull( nom_ciu, '')
	--	, ciudad          = isnull( ciudad, '')
	--	, telefono        --= isnull( clfono, 0)
	--	, fax             --= isnull( clfax, 0)
	--	, fechaant        = CONVERT(CHAR(10), fechaAnt,  103)
	--	, fechaproc       --= CONVERT(CHAR(10), fechaProc, 103)
	--	, fechaprox       = CONVERT(CHAR(10), fechaProx, 103)
	--	, numero_operacion
	--	, rutbcch
	--	, iniciodia
	--	, libor
	--	, paridad
	--	, tasamtm
	--	, tasas
	--	, findia
	--	, cierreMesa
	--	, codigo_cliente = codigobanco
	--	, devengo
	--	, contabilidad		
	--	, 'Cantidad'     = 1
	--	, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
	--	, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
	--	,	'digrut'            = cldv
	--FROM	bacswapsuda..SwapGeneral
 --         INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco
 --         LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) Banco
		
		
			,	(SELECT	--entidad
				 --codigo
				 nombre          =  RazonSocial -- clnombre
      			, rut             = RutEntidad -- clrut
      			--, direccion       = isnull( DireccionLegal, '') -- isnull( cldirecc, '')
				, direccion       = isnull(DireccionLegal + ', ' + Comuna + ', ' + Ciudad, '')
				, comuna          = isnull( Comuna, '') -- isnull( nom_ciu, '')
				, ciudad          = isnull( ciudad, '')
				, TelefonoLegal        --= isnull( clfono, 0)
				--, fax             --= isnull( clfax, 0)
				--, fechaant        = CONVERT(CHAR(10), fechaAnt,  103)
				--, fechaproc       --= CONVERT(CHAR(10), fechaProc, 103)
				--, fechaprox       = CONVERT(CHAR(10), fechaProx, 103)
				--, numero_operacion
				--, rutbcch
				--, iniciodia
				--, libor
				--, paridad
				--, tasamtm
				--, tasas
				--, findia
				--, cierreMesa
				, codigo_cliente = codigoEntidad
				--, devengo
				--, contabilidad		
				, 'Cantidad'     = 1
				--, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
				--, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
				,	'digrut'            = cldv
			FROM	bacparamsuda..Contratos_ParametrosGenerales
					INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = RutEntidad AND clcodigo = codigoEntidad
					LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) Banco
			--ORDER 
			--BY		INDICE_ORDEN  


UNION all


SELECT    
	  --'FECHA_CONTRATO'			= FECHAPROC  
				  
		--'FECHA_CONTRATO'			= dbo.Fx_Retorna_Mes( BANCO.FECHAPROC )		
		'FECHA_CONTRATO'			= dbo.Fx_Retorna_Mes( DBO.Fx_Retorna_FechaContrato (@RUT_CLIENTE, @COD_CLIENTE ))							       									
	,	'CLIENTE'					= CLNOMBRE  
	
	,	RUT_CLIENTE  
		--, 'RUT_CLIENTE' = (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),RUT_CLIENTE))) ), 1), '.00', ''), ',','.'))
	
	,	'NUMERO_OPERACION'			= @NUM_OPER
	,	'DIRECCION_CLI'				= CLI.CLDIRECC  
	,	'FONO_CLI'					= CLI.CLFONO
	,	'FAX_CLI'					= CLI.CLFAX



					,	'COMUNA'					= --COMUNA.NOMBRE  
				ISNULL ((SELECT	COMU.NOMBRE 
				FROM	BACPARAMSUDA..COMUNA COMU   
						INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
				WHERE	CLRUT = @RUT_CLIENTE),'')



				,	'CIUDAD'					= --CIUDAD.NOMBRE  
				ISNULL ((SELECT	NOMBRE 
				FROM	BACPARAMSUDA..CIUDAD CIU  
						INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
				WHERE CLRUT = @RUT_CLIENTE),'')





	,	'APODERADO_CLIENTE_1'		= @cNom_Apoderado_Cliente_1  
	,	'RUT_APODERADO_CLIENTE_1'	= @cRut_Apoderado_Cliente_1
	--,	'RUT_APODERADO_CLIENTE_1'	= (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),@cRut_Apoderado_Cliente_1))) ), 1), '.00', ''), ',','.'))
	
	,	'APODERADO_CLIENTE_2'		= @cNom_Apoderado_Cliente_2  
	,	'RUT_APODERADO_CLIENTE_2'	= @cRut_Apoderado_Cliente_2

	,	'FECHA_ESCRITURA_CLIENTE'	= dbo.Fx_Retorna_Mes( CLI.FECHA_ESCRITURA )
	
	,	'NOMBRE_BANCO'				= Banco.nombre
	
	--,	'RUT_BANCO'					=	RTRIM(LTRIM(CONVERT(CHAR(10),Banco.rut))) + '-' + '9'
	,	'RUT_BANCO'					= (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),Banco.rut))) ), 1), '.00', ''), ',','.')) + '-' + @DvEntidad

	,	'APODERADO_BANCO_1'			= @cNom_Apoderado_Banco_1
	,	'RUT_APODERADO_BANCO_1'		= @cRut_Apoderado_Banco_1
	--,	'RUT_APODERADO_BANCO_1'		= (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(char(20),@cRut_Apoderado_Banco_1))) ), 1), '.00', ''), ',','.'))
	--,	'RUT_APODERADO_BANCO_1'		= (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(@cRut_Apoderado_Banco_1 ))), 1), '.00', ''), ',','.'))

	,	'APODERADO_BANCO_2'			= @cNom_Apoderado_Banco_2
	,	'RUT_APODERADO_BANCO_2'		= @cRut_Apoderado_Banco_2

	--,	'FECHA_ESCRITURA_BANCO'		= dbo.Fx_Retorna_Mes( Banco.fecha_escritura )
	
	,	'DIRECCION_BANCO'			= DIRECCION  
	
	,	'COMUNA_BANCO'				= Banco.comuna	
	,	'CIUDAD_BANCO'				= Banco.Ciudad
	
	,	'TELEFONO_BANCO'			= TELEFONOLEGAL
	--,	'FAX_BANCO'					=	FAX
	
	,	'SISTEMA'					= CLAU.SISTEMA  
	,	'CONTRATO'					= CLAU.CONTRATO
	,	'CATEGORIA'					= CLAU.CATEGORIA 
	,	'CLAUSULA'					= CLAU.CLAUSULA
	
	,	GLOSA1  
	--,	GLOSA2				
	,	GLOSA2						=  (SELECT GLOSAFINAL = DBO.Fx_Retorna_GlosaFinal (GLOSA2, @RUT_CLIENTE, @NUM_AVALES, 'Glosa2', @RegimenConyugal, @NumeraClausula)) 
	--,	'GLOSA2'						=  GLOSA2
										
	
	
	,	GLOSA3						= CASE WHEN  @ClausulaAval = 'SI' THEN 
															(select Avales = dbo.Fx_Retorna_Avales(@RUT_CLIENTE, @NUM_AVALES,'Glosa3',@RegimenConyugal))
										ELSE
												''
										END
	,	'EMPRESA AVAL'				= NOMBRE_AVAL
	,	'RUT_EMPRESA_AVAL'			= RUT_EMPRESA_AVAL
	,	'DIRECCION_AVAL'			= DIRECCION_AVAL
	,	'FONO_AVAL'					= FONO_AVAL
	,	RUT_APOD_AVAL_1
	,	NOM_APOD_AVAL_1
	,	RUT_APOD_AVAL_2
	,	NOM_APOD_AVAL_2
	,	'TIPO_OPERACION'			=	CASE WHEN CLAU.SISTEMA = 'PCS' THEN 
											CASE WHEN @TIPO_OPER = 2 THEN -- = 'SM' THEN--'MONEDA' THEN 
														'PERMUTA FINANCIERA(CROSS CURRENCY SWAP) SOBRE UNIDADES DE INTERES Y DIVISAS'
												WHEN @TIPO_OPER = 1 OR @TIPO_OPER = 4 THEN--= 'ST' OR @TIPO_OPER = 'SP' THEN--= 'TASA' OR @TIPO_OPER = 'CAMARA' THEN 
														'SWAP DE TASA DE INTERES' 
												ELSE 
													'' 
												END
											--END
										ELSE
											CASE WHEN @TIPO_OPER = 1 OR @TIPO_OPER = 2 OR @TIPO_OPER = 12  OR @TIPO_OPER = 14 THEN --= 'Moneda' OR @TIPO_OPER = 'Arbitraje a futuro' OR @TIPO_OPER = 'Arbitraje Moneda MX-$' OR @TIPO_OPER = 'Forward Observado' THEN
														'COMPRAVENTA Y ARBITRAJE A FUTURO DE MONEDA EXTRANJERA'
												WHEN @TIPO_OPER = 3 THEN --= 'Seguro Inflación' THEN 
														'FORWARD SOBRE UNIDADES DE REAJUSTABILIDAD E ÍNDICES DE TASAS PROMEDIOS'
												WHEN @TIPO_OPER = 10 THEN --= 'Forward Bon Trades' THEN 
														'FORWARD SOBRE TASAS DE INTERÉS DE INSTRUMENTOS DE RENTA FIJA Y DE INTERMEDIACIÓN FINANCIERA'
											ELSE
													''
									
											END
										END			
	,	'Preliminar'				= @Preliminar

	,	GLOSA_FIRMAS_1				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 1 then 
														(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 1)) 

												--WHEN  @NUM_AVALES >= 2 THEN
													--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 1, 2)) 
												ELSE
													'Sin Firma'
														
												END


	,	GLOSA_FIRMAS_2				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 2 then 
														(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 2)) 
														
											--WHEN @NUM_AVALES >= 4 then
												--				(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 3, 4))
											ELSE
														'Sin Firma'
											END

					,	GLOSA_FIRMAS_3				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 3 then 
																(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 3)) 
														--WHEN @NUM_AVALES >= 6 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 5, 6))
														ELSE
														'Sin Firma'
														END

				,	GLOSA_FIRMAS_4				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 4 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 4)) 
														--WHEN @NUM_AVALES >= 8 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 7, 8))
														ELSE
														'Sin Firma'
														END

				,	GLOSA_FIRMAS_5				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 5 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 5)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
														'Sin Firma'
														END
				,	GLOSA_FIRMAS_6				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 6 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 6)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
														'Sin Firma'
														END
				,	GLOSA_FIRMAS_7				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 7 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 7)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
														'Sin Firma'
														END
				,	GLOSA_FIRMAS_8				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 8 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 8)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
														'Sin Firma'
														END
				,	GLOSA_FIRMAS_9				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 9 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 9)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
														'Sin Firma'
														END
				,	GLOSA_FIRMAS_10				= CASE WHEN  @ClausulaAval = 'SI' AND @NUM_AVALES >= 10 then 
															(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_2 (@RUT_CLIENTE, 10)) 
														--WHEN @NUM_AVALES >= 10 then
															--	(SELECT FIRMAS = DBO.Fx_Retorna_Firmas_avales_1 (@RUT_CLIENTE, 9, 10))
														ELSE
														'Sin Firma'
														END

					,   GLOSA_REPRESENTANTE			=  --CASE WHEN @ClienteEmpresa = 'SI' AND @cNom_Apoderado_Cliente_1 <> '' AND @cNom_Apoderado_Cliente_2 <> '' THEN 
														CASE WHEN @ClienteEmpresa = 'SI'  THEN  --> FUSION
														 --	'representado por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_1 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_1 ))
															--+ ' y por don ' + LTRIM(RTRIM( @cNom_Apoderado_Cliente_2 )) + ', cédula de identidad N°' +  LTRIM(RTRIM( @cRut_Apoderado_cliente_2 ))
															
															
															'representado por los apoderados individualizados al final de este contrato' --> FUSION
															+ ', domiciliados en ' + ltrim(rtrim(CLI.CLDIRECC)) 
															+ ', comuna de ' + ltrim(rtrim(ISNULL ((SELECT	COMU.NOMBRE 
																							FROM	BACPARAMSUDA..COMUNA COMU   
																									INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE
																							WHERE	CLRUT = @RUT_CLIENTE),'')))
															+ ', ciudad de ' + ISNULL ((SELECT	NOMBRE 
																	FROM	BACPARAMSUDA..CIUDAD CIU  
																			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE
																	WHERE CLRUT = @RUT_CLIENTE),'')
															+ ','
														 
														 /*
														 -- *** BLOEUQADO POR FUSION *** 
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
														*/

														ELSE 
															''
														END


	,	INDICE_ORDEN				= 0
	
	 ,   'LogoBanco'   = (select BannerLargoContrato from bacparamsuda..Contratos_ParametrosGenerales)  

	 ,	'Clausula_Tipo_Pago'	= @ClausulaTipoPago

	   , ' Clausula_Custodia'	= @ClausulaCustodia

	    -- , 'Correo_Cliente_SIGA'	= (select top 1 email from bacparamsuda..cliente where clrut = @RUT_CLIENTE)
		, 'Correo_Cliente_SIGA'	= (select top 1 dir_nombre from BDC72.dbo.DIRECCION where par_tdi_id = 'TDIREECOME' and per_id = @RUT_CLIENTE) --> Para Fusion
  
FROM (		
		SELECT     CT.SISTEMA  
	   ,  CONTRATO  
	   ,  CATEGORIA  
	   ,  CLAUSULA  
	   ,  GLOSA1  = ''
	   ,  GLOSA2	= ''
		, NOMBRE_AVAL			= 			CASE WHEN @NUM_AVALES > 0 THEN 
												ISNULL(( SELECT TOP 1 NOMBRE_AVAL
														FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
											ELSE
												'Sin Aval'
											END

		, RUT_EMPRESA_AVAL		= 			ISNULL(( SELECT TOP 1 LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL
														FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		, DIRECCION_AVAL		= 			ISNULL(( SELECT TOP 1 DIRECCION_AVAL
														FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		, FONO_AVAL				=			ISNULL((SELECT CLFONO FROM BACPARAMSUDA..CLIENTE 
													WHERE CLRUT = (SELECT TOP 1 RUT_AVAL FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																	WHERE rut_cliente = @RUT_CLIENTE)),'Sin Info')
																	
		, GLOSA3				=			'' 
		, RUT_APOD_AVAL_1		=			ISNULL((SELECT TOP 1 LTRIM(RTRIM(CONVERT(CHAR(10),RUT_APOD_AVAL_1))) + '-' + DV_RAA_1
														 FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		, NOM_APOD_AVAL_1		=			ISNULL((SELECT TOP 1 NOM_APOD_AVAL_1 FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		, RUT_APOD_AVAL_2		=			ISNULL((SELECT TOP 1 LTRIM(RTRIM(CONVERT(CHAR(10),RUT_APOD_AVAL_2))) + '-' + DV_RAA_2
														 FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		, NOM_APOD_AVAL_2		=			ISNULL((SELECT TOP 1 NOM_APOD_AVAL_2 FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
	   ,  INDICE_ORDEN  = 0
	   ,  UTILIZA_AVAL  = ''
	   ,  ACTIVA  = ''
	   
	   
	   FROM   
				CONTRATO_ContratosClausulasSeleccionadas  CT  
	   WHERE	CATEGORIA		= 'CONTRATO'  
	   AND		CT.Rut_Cliente	= @RUT_CLIENTE
	)		CLAU 

	--,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX, FECHA_ESCRITURA   
	--					FROM BACPARAMSUDA..CLIENTE 
	--					WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  

	 , (SELECT	CLNOMBRE
--		RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT)))		
		--, RUT_CLIENTE = (select replace (replace (convert (varchar(20), convert(money, CLRUT ), 1), '.00', ''), ',','.'))
		--, RUT_CLIENTE = (select replace (replace (convert (varchar(20), convert(money, rtrim(ltrim(convert(varchar(20),CLRUT))) ), 1), '.00', ''), ',','.'))
		 , RUT_CLIENTE = (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.'))))
		+ '-' 
		+ ltrim(rtrim(CLDV))
		, CLDIRECC
		, CLFONO
		, CLFAX 
		, FECHA_ESCRITURA 
		FROM BACPARAMSUDA..CLIENTE
		WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE) CLI


	--,	(SELECT COMU.NOMBRE 
	--					FROM BACPARAMSUDA..COMUNA COMU   
	--					INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE  
	--					WHERE CLRUT = @RUT_CLIENTE) COMUNA   
	--,	(SELECT NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
	--					INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
	--					WHERE CLRUT = @RUT_CLIENTE) CIUDAD  


	
	--,	(	SELECT	entidad
	--			, codigo
	--			, nombre          = clnombre
 --     			, rut             = clrut
 --     			, direccion       = isnull( cldirecc, '')
	--			, comuna          = isnull( nom_ciu, '')
	--			, ciudad          = isnull( ciudad, '')
	--			, telefono        --= isnull( clfono, 0)
	--			, fax             --= isnull( clfax, 0)
	--			, fechaant        = CONVERT(CHAR(10), fechaAnt,  103)
	--			, fechaproc       --= CONVERT(CHAR(10), fechaProc, 103)
	--			, fechaprox       = CONVERT(CHAR(10), fechaProx, 103)
	--			, numero_operacion
	--			, rutbcch
	--			, iniciodia
	--			, libor
	--			, paridad
	--			, tasamtm
	--			, tasas
	--			, findia
	--			, cierreMesa
	--			, codigo_cliente = codigobanco
	--			, devengo
	--			, contabilidad		
	--			, 'Cantidad'     = 1
	--			, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
	--			, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
	--			,	'digrut'            = cldv
	--		FROM	bacswapsuda..SwapGeneral
	--				INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco
	--				LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) Banco
	--		ORDER 
	--		BY		INDICE_ORDEN  

		
		,	(SELECT	--entidad
				 --codigo
				 nombre				=  RazonSocial -- clnombre
      			, rut				= RutEntidad -- clrut
      			--, direccion       = isnull( DireccionLegal, '') -- isnull( cldirecc, '')
				, direccion			= isnull(DireccionLegal + ', ' + Comuna + ', ' + Ciudad, '')
				, comuna			= isnull( Comuna, '') -- isnull( nom_ciu, '')
				, ciudad			= isnull( ciudad, '')
				, TelefonoLegal        --= isnull( clfono, 0)
				--, fax             --= isnull( clfax, 0)
				--, fechaant        = CONVERT(CHAR(10), fechaAnt,  103)
				--, fechaproc       --= CONVERT(CHAR(10), fechaProc, 103)
				--, fechaprox       = CONVERT(CHAR(10), fechaProx, 103)
				--, numero_operacion
				--, rutbcch
				--, iniciodia
				--, libor
				--, paridad
				--, tasamtm
				--, tasas
				--, findia
				--, cierreMesa
				, codigo_cliente = codigoEntidad
				--, devengo
				--, contabilidad		
				, 'Cantidad'     = 1
				--, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
				--, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
				,	'digrut'            = cldv
			FROM	bacparamsuda..Contratos_ParametrosGenerales
					INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = RutEntidad AND clcodigo = codigoEntidad
					LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) Banco
			ORDER 
			BY		INDICE_ORDEN  

END

GO
