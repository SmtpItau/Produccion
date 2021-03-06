USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_CCG_DERIVADOS_SINFIRMA]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[CONTRATO_CCG_DERIVADOS_SINFIRMA]
(  
	 		@RUT_CLIENTE		AS NUMERIC(11)  
	 ,		@COD_CLIENTE		AS NUMERIC(10)  
	 ,		@RUT_APODERADO1		AS NUMERIC(11) = 0  
	 ,		@RUT_APODERADO2		AS NUMERIC(11) = 0  
	 ,		@RUT_APODERADOB1	AS NUMERIC(11) = 0  
	 ,		@RUT_APODERADOB2	AS NUMERIC(11) = 0  
	,		@Preliminar				INT

  
)  
AS  
BEGIN  
SET NOCOUNT ON  

--SELECT * FROM CONTRATO_ContratosClausulasSeleccionadas 

DECLARE @TieneAval as numeric(5)
DECLARE @FinTexto as int
DECLARE @RegimenConyugal as varchar(10)

SET @TieneAval = 0


SET @TieneAval = (select count(*) from BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  where rut_cliente = @RUT_CLIENTE)
SET @RegimenConyugal = (select TOP 1 REGIMEN_CONYUGA_AVAL from bacparamsuda..TBL_AVAL_CLIENTE_DERIVADO where rut_cliente = @RUT_CLIENTE)


	DECLARE @cNom_Apoderado_Banco_1		VARCHAR(40);	SET @cNom_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RUT_APODERADOB1, 1)
	DECLARE @cRut_Apoderado_Banco_1		VARCHAR(40);	SET	@cRut_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RUT_APODERADOB1, 2)
	DECLARE @cNom_Apoderado_Banco_2		VARCHAR(40);	SET @cNom_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RUT_APODERADOB2, 1)
	DECLARE @cRut_Apoderado_Banco_2		VARCHAR(40);	SET	@cRut_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RUT_APODERADOB2, 2)
	DECLARE @cNom_Apoderado_Cliente_1	VARCHAR(40);	SET @cNom_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO1, 1)
	DECLARE @cRut_Apoderado_Cliente_1	VARCHAR(40);	SET @cRut_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO1, 2)
	DECLARE @cNom_Apoderado_Cliente_2	VARCHAR(40);	SET @cNom_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO2, 1)
	DECLARE @cRut_Apoderado_Cliente_2	VARCHAR(40);	SET @cRut_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO2, 2)


	
	DECLARE @cadena_ante varchar(50)
	DECLARE @cadena_desp varchar(50)
	if @cRut_Apoderado_Cliente_1 <> ''
	begin
		SET @cadena_ante = SUBSTRING(@cRut_Apoderado_Cliente_1, 1, charindex('-', @cRut_Apoderado_Cliente_1) - 1); 
		SET @cadena_desp = SUBSTRING(@cRut_Apoderado_Cliente_1, charindex('-', @cRut_Apoderado_Cliente_1), charindex('-', @cRut_Apoderado_Cliente_1) + 1); 
		SET @cRut_Apoderado_Cliente_1 = (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( @cadena_ante ))))) ), 1), '.00', ''), ',','.')+@cadena_desp)
	end

	if @cRut_Apoderado_Cliente_2 <> ''
	begin
		SET @cadena_ante = SUBSTRING(@cRut_Apoderado_Cliente_2, 1, charindex('-', @cRut_Apoderado_Cliente_2) - 1); 
		SET @cadena_desp = SUBSTRING(@cRut_Apoderado_Cliente_2, charindex('-', @cRut_Apoderado_Cliente_2), charindex('-', @cRut_Apoderado_Cliente_2) + 1); 
		SET @cRut_Apoderado_Cliente_2 = (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( @cadena_ante ))))) ), 1), '.00', ''), ',','.')+@cadena_desp)
	end

	if @cRut_Apoderado_Banco_1 <> ''
	begin
		SET @cadena_ante = SUBSTRING(@cRut_Apoderado_Banco_1, 1, charindex('-', @cRut_Apoderado_Banco_1) - 1); 
		SET @cadena_desp = SUBSTRING(@cRut_Apoderado_Banco_1, charindex('-', @cRut_Apoderado_Banco_1), charindex('-', @cRut_Apoderado_Banco_1) + 1); 
		SET @cRut_Apoderado_Banco_1 = (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( @cadena_ante ))))) ), 1), '.00', ''), ',','.')+@cadena_desp)
	end

	if @cRut_Apoderado_Banco_2 <> ''
	begin
		SET @cadena_ante = SUBSTRING(@cRut_Apoderado_Banco_2, 1, charindex('-', @cRut_Apoderado_Banco_2) - 1); 
		SET @cadena_desp = SUBSTRING(@cRut_Apoderado_Banco_2, charindex('-', @cRut_Apoderado_Banco_2), charindex('-', @cRut_Apoderado_Banco_2) + 1); 
		SET @cRut_Apoderado_Banco_2 = (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( @cadena_ante ))))) ), 1), '.00', ''), ',','.')+@cadena_desp)
	end


SELECT    
	  --'FECHA_CONTRATO'			= FECHAPROC  
		  
	  --'FECHA_CONTRATO'			= dbo.Fx_Retorna_Mes( BANCO.FECHAPROC )	
	   'FECHA_CONTRATO'			= dbo.Fx_Retorna_Mes( DBO.Fx_Retorna_FechaContrato (@RUT_CLIENTE, @COD_CLIENTE ))		
								
										
	,  'CLIENTE'				= CLNOMBRE  
	--,  RUT_CLIENTE  
	    ,   RUT_CLIENTE      =  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( RUT_CLIENTE ))))) ), 1), '.00', ''), ',','.'))+'-' +LTRIM(RTRIM( dv_cli ))

		-- ,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX ,FECHA_ESCRITURA 

	--,	'NUMERO_OPERACION' = @NUM_OPER
	
	,  'DIRECCION_CLI'				= CLI.CLDIRECC  
	,	'FONO_CLI'					= CLI.CLFONO
	,	'FAX_CLI'					= CLI.CLFAX
	,  'COMUNA'						= COMUNA.NOMBRE  
	,  'CIUDAD'						--= CIUDAD.NOMBRE  
									= isnull ((SELECT NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
										INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
											WHERE CLRUT = @RUT_CLIENTE),'Sin Info')
	----------------------------------------------------------------------------------------------------------
	,  'APODERADO_CLIENTE_1'		= @cNom_Apoderado_Cliente_1  
	,  'RUT_APODERADO_CLIENTE_1'	= @cRut_Apoderado_Cliente_1

	,  'APODERADO_CLIENTE_2'		= @cNom_Apoderado_Cliente_2 
	,  'RUT_APODERADO_CLIENTE_2'	= @cRut_Apoderado_Cliente_2
	----------------------------------------------------------------------------------------------------------
	--,	'FECHA_ESCRITURA_CLIENTE'	= CLI.FECHA_ESCRITURA 
	,	'FECHA_ESCRITURA_CLIENTE'	= dbo.Fx_Retorna_Mes( CLI.FECHA_ESCRITURA )		
	
	,	'NOMBRE_BANCO'				= Banco.nombre
	,	'RUT_BANCO'					--= Banco.rut
										--=	RTRIM(LTRIM(CONVERT(CHAR(10),Banco.rut))) + '-' + '9'
									= (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( Banco.rut ))))) ), 1), '.00', ''), ',','.'))+'-'+'9'
	-----------------------------------------------------------------------------------------------------------------------------
	,  'APODERADO_BANCO_1'			= LTRIM(RTRIM( @cNom_Apoderado_Banco_1 )) 
	,  'RUT_APODERADO_BANCO_1'		= LTRIM(RTRIM( @cRut_Apoderado_Banco_1 ))

	,  'APODERADO_BANCO_2'			= LTRIM(RTRIM( @cNom_Apoderado_Banco_2 ))
	,  'RUT_APODERADO_BANCO_2'		= LTRIM(RTRIM( @cRut_Apoderado_Banco_2 ))
	-----------------------------------------------------------------------------------------------------------------------------

	,	'FECHA_ESCRITURA_BANCO'		= dbo.Fx_Retorna_Mes( Banco.fecha_escritura )	
	
	,  'DIRECCION_BANCO'			= DIRECCION  
	,  'COMUNA_BANCO'				= Banco.comuna
	,	'CIUDAD_BANCO'				= Banco.Ciudad
	,	'TELEFONO_BANCO'			= TELEFONOLEGAL
	,	'FAX_BANCO'					=	FAX

	
	,  'SISTEMA'     = CLAU.SISTEMA  
	,  CLAU.CONTRATO  
	,  CLAU.CATEGORIA  
	,  CLAU.CLAUSULA  
	
	,  GLOSA1  
	,  GLOSA2     --= convert(varchar(max),GLOSA2)
	,  GLOSA3	/*= (Select ' representada por don(ña) ' + LTRIM(RTRIM(APOCLI.APNOMBRE)) )
					+ ', cédula nacional de identidad N° ' +  LTRIM(RTRIM(CONVERT(CHAR(10),APOCLI.RUT_APODERADO)))
					+ ', y don(ña) ' + LTRIM(RTRIM(APOCLI2.APNOMBRE))
					+ ', cédula nacional de identidad N° ' +  LTRIM(RTRIM(CONVERT(CHAR(10),APOCLI2.RUT_APODERADO))) + ','
					*/
	
	
	,	'EMPRESA AVAL'		= NOMBRE_AVAL
	,	'RUT_EMPRESA_AVAL'		= RUT_EMPRESA_AVAL
	,	'DIRECCION_AVAL'	= DIRECCION_AVAL
	,	'FONO_AVAL'			= FONO_AVAL
	,	RUT_APOD_AVAL_1
	,	NOM_APOD_AVAL_1
	,	RUT_APOD_AVAL_2
	,	NOM_APOD_AVAL_2
		
	,	'Preliminar'		= ISNULL(@Preliminar,0)
									
	,  INDICE_ORDEN  
	
	 ,   'LogoBanco'				= logoBanco
	 , Direccion_Pie_Firma			= Direccion_Pie_Firma
	 , URLBanco						= URLBanco
	, LogoBancoPieFirma				= LogoBancoPieFirma

FROM (		
		SELECT     CT.SISTEMA  
	   ,  CONTRATO  
	   ,  CATEGORIA  
	   ,  CLAUSULA  
	   ,  GLOSA1  
	   ,  GLOSA2	= CASE 
										WHEN CLAUSULA IN ('RAG7','RAG4', 'AS4') and @TieneAval > 0 THEN
										
												
											CASE WHEN @RegimenConyugal = 'NA' THEN
												
														(SELECT REPLACE(SUBSTRING(GLOSA2,1,DATALENGTH(GLOSA2)), '@AVALES', (SELECT TOP 1 LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + 'Rol Unico Tributario '
																							+ 'N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 
																							+ ' representada por don(ña) ' + LTRIM(RTRIM(NOM_APOD_AVAL_1))
																							+ ', cédula nacional de identidad N° ' +  LTRIM(RTRIM(CONVERT(CHAR(10),RUT_APOD_AVAL_1))) + '-' + DV_RAA_1
																							+ ', y don(ña) ' + LTRIM(RTRIM(NOM_APOD_AVAL_2))
																							+ ', cédula nacional de identidad N° ' +  LTRIM(RTRIM(CONVERT(CHAR(10),RUT_APOD_AVAL_2))) + '-' + DV_RAA_2

																FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE RUT_CLIENTE = @RUT_CLIENTE)) 
													 FROM bacparamsuda..TBL_CLAUSULAS WHERE sistema = CT.SISTEMA and tipo_contrato = CT.CONTRATO
														 and codigo_clausula = CT.CLAUSULA)
														 
											--END
											WHEN @RegimenConyugal = 'CSDOSB' THEN
												(SELECT REPLACE(SUBSTRING(GLOSA2,1,DATALENGTH(GLOSA2)), '@AVALES', (SELECT TOP 1 'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + ' casado(a) y separado(a) totalmente de bienes, '
																							+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 

																FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE RUT_CLIENTE = @RUT_CLIENTE)) 
													 FROM bacparamsuda..TBL_CLAUSULAS WHERE sistema = CT.SISTEMA and tipo_contrato = CT.CONTRATO
														 and codigo_clausula = CT.CLAUSULA)
											--END		
											 WHEN @RegimenConyugal = 'CSDOSC' THEN
												(SELECT REPLACE(SUBSTRING(GLOSA2,1,DATALENGTH(GLOSA2)), '@AVALES', (SELECT TOP 1 'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + ' casado(a) bajo el régimen de sociedad conyugal, '
																							+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 

																FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE RUT_CLIENTE = @RUT_CLIENTE)) 
													 FROM bacparamsuda..TBL_CLAUSULAS WHERE sistema = CT.SISTEMA and tipo_contrato = CT.CONTRATO 
														 and codigo_clausula = CT.CLAUSULA)
														 
											WHEN @RegimenConyugal = 'CSDOPG' THEN
												(SELECT REPLACE(SUBSTRING(GLOSA2,1,DATALENGTH(GLOSA2)), '@AVALES', (SELECT TOP 1 'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + ' casado(a) bajo el régimen de participación en los gananciales, '
																							+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 

																FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE RUT_CLIENTE = @RUT_CLIENTE)) 
													 FROM bacparamsuda..TBL_CLAUSULAS WHERE sistema = CT.SISTEMA and tipo_contrato = CT.CONTRATO 
														 and codigo_clausula = CT.CLAUSULA)
											
											WHEN @RegimenConyugal = 'STRO' THEN
												(SELECT REPLACE(SUBSTRING(GLOSA2,1,DATALENGTH(GLOSA2)), '@AVALES', (SELECT TOP 1 'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + ' soltero, '
																							+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 

																FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE RUT_CLIENTE = @RUT_CLIENTE)) 
													 FROM bacparamsuda..TBL_CLAUSULAS WHERE sistema = CT.SISTEMA and tipo_contrato = CT.CONTRATO 
														 and codigo_clausula = CT.CLAUSULA)
														 
														 
											END	
												 			 
										ELSE
											GLOSA2
										END

		, NOMBRE_AVAL			= 			ISNULL(( SELECT TOP 1 NOMBRE_AVAL
														FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')

		--, RUT_EMPRESA_AVAL		= 			ISNULL(( SELECT TOP 1 LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL
		--												FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
		--												WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		, RUT_EMPRESA_AVAL		= 			ISNULL(( SELECT TOP 1 replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( RUT_AVAL ))))) ), 1), '.00', ''), ',','.')+ '-' + DV_AVAL
														FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')


		, DIRECCION_AVAL		= 			ISNULL(( SELECT TOP 1 DIRECCION_AVAL
														FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		, FONO_AVAL				=			ISNULL((SELECT CLFONO FROM BACPARAMSUDA..CLIENTE 
													WHERE CLRUT = (SELECT TOP 1 RUT_AVAL FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																	WHERE rut_cliente = @RUT_CLIENTE)),'Sin Info')
																	
		, GLOSA3				=			CASE WHEN CLAUSULA IN ('RAG7','RAG4', 'AS4') and @TieneAval > 0 THEN
													CASE WHEN @RegimenConyugal = 'NA' THEN
																''
							
													--END
													WHEN @RegimenConyugal = 'CSDOSB' THEN
															(SELECT TOP 1 'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + ' casado(a) y separado(a) totalmente de bienes, '
																							+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 

																FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE RUT_CLIENTE = @RUT_CLIENTE)
													WHEN @RegimenConyugal = 'CSDOSC' THEN
															(SELECT TOP 1 'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + ' casado(a) bajo el régimen de sociedad conyugal, '
																							+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 

															FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
															WHERE RUT_CLIENTE = @RUT_CLIENTE)
													WHEN @RegimenConyugal = 'CSDOPG' THEN
															(SELECT TOP 1 'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + ' casado(a) bajo el régimen de participación en los gananciales, '
																							+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 

																FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE RUT_CLIENTE = @RUT_CLIENTE)
													WHEN @RegimenConyugal = 'STRO' THEN
																(SELECT TOP 1 'don(ña) ' + LTRIM(RTRIM(NOMBRE_AVAL)) 
																							+ ', ' + ' soltero, '
																							+ 'cédula nacional de identidad N° ' + LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL 

																FROM   BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
																WHERE RUT_CLIENTE = @RUT_CLIENTE)
													WHEN CONTRATO = 'ACCE' THEN --AND CLAUSULA = 'RAG4' THEN
																(SELECT 'en adelante "Garante(s)",')
													END		
												ELSE
													--CASE WHEN CLAUSULA IN ('RAG4') THEN 
													--		(SELECT 'en adelante "Garante(s)",')
													--ELSE
													''
													--END
												END	
		
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
	   ,  INDICE_ORDEN  
	   ,  UTILIZA_AVAL  
	   ,  ACTIVA  
	   
	  
	   
	   FROM   

		 CONTRATO_ContratosClausulasSeleccionadas  CT  
	   ,   BACPARAMSUDA..TBL_CLAUSULAS CLA  
	   WHERE CATEGORIA IN ('CLAUSULA') 
	   AND CT.Rut_Cliente = @RUT_CLIENTE
	    AND CT.CONTRATO = CLA.TIPO_CONTRATO  
	   AND  CT.CLAUSULA = CLA.CODIGO_CLAUSULA  
	   AND  CLA.SISTEMA = CT.SISTEMA   
	 )		CLAU 
	 

			
			
		 --,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX ,FECHA_ESCRITURA 
			--FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  

				 ,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))), dv_cli = cldv, CLDIRECC, CLFONO, CLFAX ,FECHA_ESCRITURA 
			FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  

		 , (SELECT COMU.NOMBRE FROM BACPARAMSUDA..COMUNA COMU   
			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE  
			WHERE CLRUT = @RUT_CLIENTE) COMUNA   

		 --, (SELECT NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
			--INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
			--WHERE CLRUT = @RUT_CLIENTE) CIUDAD  


/**********
		 ,(SELECT	entidad
		, codigo
		, nombre          = clnombre
      		, rut             = clrut
      		, direccion       = isnull( cldirecc, '')
		, comuna          = isnull( nom_ciu, '')
		, ciudad          = isnull( ciudad, '')
		, telefono        --= isnull( clfono, 0)
		, fax             --= isnull( clfax, 0)
		, fechaant        = CONVERT(CHAR(10), fechaAnt,  103)
		, fechaproc       --= CONVERT(CHAR(10), fechaProc, 103)
		, fechaprox       = CONVERT(CHAR(10), fechaProx, 103)
		, numero_operacion
		, rutbcch
		, iniciodia
		, libor
		, paridad
		, tasamtm
		, tasas
		, findia
		, cierreMesa
		, codigo_cliente = codigobanco
		, devengo
		, contabilidad		
		, 'Cantidad'     = 1
		, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
		, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
		,	'digrut'            = cldv
	FROM	bacswapsuda..SwapGeneral
          INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco
          LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) Banco
		
			
		--***************/

		
			,	(SELECT	--entidad
				 --codigo
				 nombre          =  RazonSocial -- clnombre
      			, rut             = RutEntidad -- clrut
      			, direccion       = isnull( DireccionLegal, '') -- isnull( cldirecc, '')
				, comuna          = isnull( Comuna, '') -- isnull( nom_ciu, '')
				, ciudad          = isnull( ciudad, '')
				, TelefonoLegal        --= isnull( clfono, 0)
				, fax             = isnull( clfax, 0)
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
				, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
				--, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
				,	'digrut'            = cldv
				, logoBanco				= Logo
				, Direccion_Pie_Firma	= DireccionLegalPieFirma
				, URLBanco				= URLBanco
				, LogoBancoPieFirma		= BannerCorto
			FROM	bacparamsuda..Contratos_ParametrosGenerales
					INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = RutEntidad AND clcodigo = codigoEntidad
					LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) Banco


			
		 --ORDER BY   INDICE_ORDEN  
--END  


--/*
UNION all


SELECT    
	  --'FECHA_CONTRATO'			= FECHAPROC  
				  
	  --'FECHA_CONTRATO'			= dbo.Fx_Retorna_Mes( BANCO.FECHAPROC )	
	    'FECHA_CONTRATO'			= dbo.Fx_Retorna_Mes( DBO.Fx_Retorna_FechaContrato (@RUT_CLIENTE, @COD_CLIENTE ))		
										
	,  'CLIENTE'				= CLNOMBRE  
	--,  RUT_CLIENTE  
	   ,   RUT_CLIENTE      =  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( RUT_CLIENTE ))))) ), 1), '.00', ''), ',','.'))+'-' +LTRIM(RTRIM( dv_cli ))

	--,	'NUMERO_OPERACION' = @NUM_OPER
	
	,  'DIRECCION_CLI'				= CLI.CLDIRECC  
	,	'FONO_CLI'					= CLI.CLFONO
	,	'FAX_CLI'					= CLI.CLFAX
	,  'COMUNA'						= COMUNA.NOMBRE  
	,  'CIUDAD'						--= CIUDAD.NOMBRE  
										= isnull ((SELECT NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
											INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
											WHERE CLRUT = @RUT_CLIENTE),'Sin Info')
	 -----------------------------------------------------------------------------------------------
	,  'APODERADO_CLIENTE_1'		=  @cNom_Apoderado_Cliente_1  
	,  'RUT_APODERADO_CLIENTE_1'	=  @cRut_Apoderado_Cliente_1  

	,  'APODERADO_CLIENTE_2'		= @cNom_Apoderado_Cliente_2 
	,  'RUT_APODERADO_CLIENTE_2'	= @cRut_Apoderado_Cliente_2
	 -----------------------------------------------------------------------------------------------

	,	'FECHA_ESCRITURA_CLIENTE'	= dbo.Fx_Retorna_Mes( CLI.FECHA_ESCRITURA )	

	,  'NOMBRE_BANCO'				= Banco.nombre
	,	'RUT_BANCO'					--= Banco.rut
									--=	RTRIM(LTRIM(CONVERT(CHAR(10),Banco.rut))) + '-' + '9'
									= (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( Banco.rut ))))) ), 1), '.00', ''), ',','.'))+'-'+'9'
	-----------------------------------------------------------------------------------------------------------------------------
	,  'APODERADO_BANCO_1'			= @cNom_Apoderado_Banco_1 
	,  'RUT_APODERADO_BANCO_1'		= @cRut_Apoderado_Banco_1  

	,  'APODERADO_BANCO_2'			= @cNom_Apoderado_Banco_2 
	,  'RUT_APODERADO_BANCO_2'		= @cRut_Apoderado_Banco_2  
	------------------------------------------------------------------------------------------------------------------------------
	--,	'FECHA_ESCRITURA_BANCO'		= Banco.fecha_escritura
	,	'FECHA_ESCRITURA_BANCO'		= dbo.Fx_Retorna_Mes( Banco.fecha_escritura )	
	
	,  'DIRECCION_BANCO'			= DIRECCION  
	
	,  'COMUNA_BANCO'				= Banco.comuna
	,	'CIUDAD_BANCO'				= Banco.Ciudad
	
	,	'TELEFONO_BANCO'			= TELEFONOLEGAL
	,	'FAX_BANCO'					=	FAX
	
	,  'SISTEMA'					= CLAU.SISTEMA  
	,  'CONTRATO'					= CLAU.CONTRATO
	,  'CATEGORIA'					= CLAU.CATEGORIA 
	,  'CLAUSULA'					= CLAU.CLAUSULA
	
	,  GLOSA1  
	,  GLOSA2    
	,  GLOSA3						/*= (Select ' representada por don(ña) ' + LTRIM(RTRIM(APOCLI.APNOMBRE)) )
										+ ', cédula nacional de identidad N° ' +  LTRIM(RTRIM(CONVERT(CHAR(10),APOCLI.RUT_APODERADO)))
										+ ', y don(ña) ' + LTRIM(RTRIM(APOCLI2.APNOMBRE))
										+ ', cédula nacional de identidad N° ' +  LTRIM(RTRIM(CONVERT(CHAR(10),APOCLI2.RUT_APODERADO))) + ','
									*/
	
	,	'EMPRESA AVAL'				= NOMBRE_AVAL
	,	'RUT_EMPRESA_AVAL'			= RUT_EMPRESA_AVAL
	,	'DIRECCION_AVAL'			= DIRECCION_AVAL
	,	'FONO_AVAL'					= FONO_AVAL
	,	RUT_APOD_AVAL_1
	,	NOM_APOD_AVAL_1
	,	RUT_APOD_AVAL_2
	,	NOM_APOD_AVAL_2
	--,	'TIPO_OPERACION'			= '' --@TIPO_OPER
	,		'Preliminar'			=	ISNULL(@Preliminar,0)
	,  INDICE_ORDEN					= 0
	 ,   'LogoBanco'				= logoBanco
	 , Direccion_Pie_Firma			= Direccion_Pie_Firma
	, URLBanco						= URLBanco
	, LogoBancoPieFirma				= LogoBancoPieFirma
	
FROM (		
		SELECT     CT.SISTEMA  
	   ,  CONTRATO  
	   ,  CATEGORIA  
	   ,  CLAUSULA  
	   ,  GLOSA1  = ''
	   ,  GLOSA2	= ''
		, NOMBRE_AVAL			= 			ISNULL(( SELECT TOP 1 NOMBRE_AVAL
														FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
														WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		--, RUT_EMPRESA_AVAL		= 			ISNULL(( SELECT TOP 1 LTRIM(RTRIM(CONVERT(CHAR(10),RUT_AVAL))) + '-' + DV_AVAL
		--												FROM BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO  
		--												WHERE rut_cliente = @RUT_CLIENTE),'Sin Aval')
		, RUT_EMPRESA_AVAL		= 			ISNULL(( SELECT TOP 1 replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( RUT_AVAL ))))) ), 1), '.00', ''), ',','.')+ '-' + DV_AVAL
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
	   WHERE CATEGORIA = 'CONTRATO'  
	    AND CT.Rut_Cliente = @RUT_CLIENTE
	 )		CLAU 

	 


			
		 --,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX, FECHA_ESCRITURA   
			--FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  

					 ,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))), dv_cli = cldv, CLDIRECC, CLFONO, CLFAX ,FECHA_ESCRITURA 
			FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  


		 , (SELECT COMU.NOMBRE FROM BACPARAMSUDA..COMUNA COMU   
			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE  
			WHERE CLRUT = @RUT_CLIENTE) COMUNA   

		 --, (SELECT NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
			--INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
			--WHERE CLRUT = @RUT_CLIENTE) CIUDAD  


/*********
 ,(SELECT	entidad
		, codigo
		, nombre          = clnombre
      		, rut             = clrut
      		, direccion       = isnull( cldirecc, '')
		, comuna          = isnull( nom_ciu, '')
		, ciudad          = isnull( ciudad, '')
		, telefono        --= isnull( clfono, 0)
		, fax             --= isnull( clfax, 0)
		, fechaant        = CONVERT(CHAR(10), fechaAnt,  103)
		, fechaproc       --= CONVERT(CHAR(10), fechaProc, 103)
		, fechaprox       = CONVERT(CHAR(10), fechaProx, 103)
		, numero_operacion
		, rutbcch
		, iniciodia
		, libor
		, paridad
		, tasamtm
		, tasas
		, findia
		, cierreMesa
		, codigo_cliente = codigobanco
		, devengo
		, contabilidad		
		, 'Cantidad'     = 1
		, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
		, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
		,	'digrut'            = cldv
	FROM	bacswapsuda..SwapGeneral
          INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco
          LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) Banco
		
	ORDER BY   INDICE_ORDEN  

	--***********/

	
	,	(SELECT	--entidad
				 --codigo
				 nombre          =  RazonSocial -- clnombre
      			, rut             = RutEntidad -- clrut
      			, direccion       = isnull( DireccionLegal, '') -- isnull( cldirecc, '')
				, comuna          = isnull( Comuna, '') -- isnull( nom_ciu, '')
				, ciudad          = isnull( ciudad, '')
				, TelefonoLegal        --= isnull( clfono, 0)
				, fax             = isnull( clfax, 0)
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
				, 'fecha_escritura'   = isnull( fecha_escritura, '') --> (select fecha_escritura from view_cliente where clrut=rut and clcodigo= codigobanco )
				--, 'notaria'           = isnull( nombre_notaria, '')  --> (select nombre_notaria  from view_cliente where clrut=rut and clcodigo= codigobanco)
				,	'digrut'            = cldv
				, logoBanco				= Logo
				, Direccion_Pie_Firma	= DireccionLegalPieFirma
				, URLBanco				= URLBanco
				, LogoBancoPieFirma		= BannerCorto
			FROM	bacparamsuda..Contratos_ParametrosGenerales
					INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = RutEntidad AND clcodigo = codigoEntidad
					LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) Banco
			ORDER 
			BY		INDICE_ORDEN  

			

END


GO
