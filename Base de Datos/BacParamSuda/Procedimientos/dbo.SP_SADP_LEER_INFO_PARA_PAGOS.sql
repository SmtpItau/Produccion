USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_INFO_PARA_PAGOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_INFO_PARA_PAGOS] 
AS
BEGIN

	DECLARE 
			@sCtaADMINISTRADORA		VARCHAR(40)
	,		@sNombreAdministradora	VARCHAR(40)
	,		@sRutAdministradora		VARCHAR(10)
	,		@iRutAdministradora		INT
	
	,		@sCtaAgencia			VARCHAR(40)
	,		@sNombreAgencia			VARCHAR(40)
	,		@sRutAgencia			VARCHAR(10)

	,		@sCtaCorredora			VARCHAR(40)
	,		@sNombreCorredora		VARCHAR(40)
	,		@sRutCorredora			VARCHAR(10)

	,		@IBS_H36USERID			VARCHAR(10)
	,		@IBS_E36TRACAN			VARCHAR(04)
	,		@IBS_ATCANAL			VARCHAR(04)
	,		@IBS_ATTRANS_EMPR		VARCHAR(04)
	,		@IBS_ATTRANS_NATU		VARCHAR(04)
	,		@IBS_E36TRA_PAR			VARCHAR(04)
	,		@IBS_E36TRATYP			VARCHAR(03)		;
	

	DECLARE @dfecha					DATETIME
			
		SET @sCtaADMINISTRADORA		= (SELECT  sCuentaCorriente 
		                       		     FROM SADP_CUENTASCORRIENTES sc
		                       		    INNER
		                       		     JOIN SADP_CONTROL sc2
		                       		       ON sc.iRutCliente = sc2.iRut_FFMM
		                       		      AND sc.iCodCliente = 0
		                       		      AND sc.id_banco    = 27
										  AND sc.iCodMoneda   =999)	;
		                       		      
		SET @sCtaAgencia			= (SELECT  sCuentaCorriente 
		                       		     FROM SADP_CUENTASCORRIENTES sc
		                       		    INNER
		                       		     JOIN SADP_CONTROL sc2
		                       		       ON sc.iRutCliente = sc2.iRut_Agencia
		                       		      AND sc.iCodCliente = 0
		                       		      AND sc.id_banco    = 27
										  AND sc.iCodMoneda   =999)	;
		                       		      
		SET @sCtaCorredora			= (SELECT  sCuentaCorriente 
		                       		     FROM SADP_CUENTASCORRIENTES sc
		                       		    INNER
		                       		     JOIN SADP_CONTROL sc2
		                       		       ON sc.iRutCliente = sc2.iRut_CDB
		                       		      AND sc.iCodCliente = 0
		                       		      AND sc.id_banco    = 27
										  AND sc.iCodMoneda   =999)	;

	SELECT  @IBS_H36USERID			= IBS_H36USERID			   
	,		@IBS_E36TRACAN			= IBS_E36TRACAN			
	,		@IBS_ATCANAL			= IBS_ATCANAL			
	,		@IBS_ATTRANS_EMPR		= IBS_ATTRANS_EMPR		
	,		@IBS_ATTRANS_NATU		= IBS_ATTRANS_NATU		
	,		@IBS_E36TRA_PAR			= IBS_E36TRA_PAR			
	,		@IBS_E36TRATYP			= IBS_E36TRATYP
	,		@sNombreAdministradora	= sc.Nombre_FFMM
	,		@iRutAdministradora		= sc.iRut_ffmm
	,		@sRutAdministradora		= ltrim(rtrim(CONVERT(CHAR(9),sc.iRut_ffmm)))+sc.cDv_ffmm
	,		@sNombreAgencia			= sc.Nombre_Agencai
	,		@sRutAgencia			= ltrim(rtrim(CONVERT(CHAR(9),sc.iRut_agencia)))+sc.cDv_agencia
	,		@sNombreCorredora		= sc.Nombre_CDB
	,		@sRutCorredora			= ltrim(rtrim(CONVERT(CHAR(9),sc.iRut_CDB)))+sc.cDv_CDB
	,		@dfecha					= sc.dFechaProceso					
	FROM SADP_CONTROL sc											;
	 

/*	SELECT	@IBS_H36USERID				AS H36USERID
		,	@IBS_E36TRACAN				AS E36TRACAN
		,	@IBS_E36TRATYP				AS E36TRATYP
		,	0							AS E36TRAMOD
		,	0							AS E36TRACOP
		,	0							AS E36TRAREF
		,	@IBS_ATCANAL				AS ATCANAL
		,	@IBS_ATTRANS_EMPR			AS ATTRANS	 --> Valor Fijo para las empresas //362 es clientes	
		,	'CLP'						AS E36TRACCY
		,	DAY(fecha)					AS E36TRAFPD
		,	MONTH(fecha)				AS E36TRAFPM
		,	YEAR(fecha)					AS E36TRAFPY
		,	27							AS E36TRADBC
		,	@sRutAdministradora			AS E36TRADID
		,	@sRutAdministradora			AS ATRUTUS
		,	@sNombreAdministradora		AS E36TRADNA
		,	sc.sCuentaCorriente			AS E36TRADAC
		,	@IBS_E36TRA_PAR				AS E36TRADAY
		,	27							AS E36TRACBC
		,	@sRutAdministradora			AS E36TRACID
		,	@sNombreAdministradora		AS E36TRACNA
		,	@sCtaADMINISTRADORA			AS E36TRACAC
		,	@IBS_E36TRA_PAR				AS E36TRACAY
		,	srp.Monto					AS E36TRAMTO
		,	srp.idFolio 				AS NumOperacion
		,	'FFMM'						AS Sistema
	 FROM bacparamsuda.dbo.sadp_rescates_pago srp
	INNER 
	 JOIN FMParticipes.dbo.FMP_FONDOS ff
	   ON ff.cod_fondo =  srp.codFondo 
	INNER 
	 JOIN bacparamsuda.dbo.SADP_CUENTASCORRIENTES sc 
	   ON sc.iRutCliente =  @iRutAdministradora
	  AND sc.iCodCliente=  ff.cod_fondo_madre
	  AND sc.id_banco = 27
	  AND sc.bPrincipal= 1
	WHERE srp.Estado = 'P'	  
	UNION
	*/ 	  
	SELECT	@IBS_H36USERID				AS H36USERID
		,	@IBS_E36TRACAN				AS E36TRACAN
		,	@IBS_E36TRATYP				AS E36TRATYP
		,	0							AS E36TRAMOD
		,	0							AS E36TRACOP
		,	0							AS E36TRAREF
		,	@IBS_ATCANAL				AS ATCANAL
		
		,	@IBS_ATTRANS_EMPR			AS ATTRANS	 --> Valor Fijo para las empresas //362 es clientes	
		,	'CLP'						AS E36TRACCY
		,	DAY(fecha)					AS E36TRAFPD
		,	MONTH(fecha)				AS E36TRAFPM
		,	YEAR(fecha)					AS E36TRAFPY
		,	27							AS E36TRADBC
		,	CASE 
				WHEN cModulo ='FFMM'	THEN @sRutAdministradora
				WHEN cModulo ='GPI'		THEN @sRutAgencia
				WHEN cModulo ='CDB'		THEN @sRutCorredora
			END							AS E36TRADID
		,	CASE 
				WHEN cModulo ='FFMM'	THEN @sRutAdministradora
				WHEN cModulo ='GPI'		THEN @sRutAgencia
				WHEN cModulo ='CDB'		THEN @sRutCorredora
			END							AS ATRUTUS
		,	CASE 
				WHEN cModulo ='FFMM'	THEN @sNombreAdministradora		
				WHEN cModulo ='GPI'		THEN @sNombreAgencia		
				WHEN cModulo ='CDB'		THEN @sNombreCorredora		
			END							AS E36TRADNA
		,	CASE 
				WHEN cModulo ='FFMM'	THEN @sCtaADMINISTRADORA		
				WHEN cModulo ='GPI'		THEN @sCtaagencia	
				WHEN cModulo ='CDB'		THEN @sCtaCorredora		
			END							AS E36TRADAC
		,	@IBS_E36TRA_PAR				AS E36TRADAY
		,	27							AS E36TRACBC
		,	LTRIM(RTRIM(CONVERT(CHAR(10),iRutBeneficiario)))+sDigBeneficiario AS E36TRACID
		,	sNomBeneficiario			AS E36TRACNA
		,	RTRIM(LTRIM(sCtaCte))		AS E36TRACAC
		,	@IBS_E36TRA_PAR				AS E36TRACAY
		,	NMonto						AS E36TRAMTO
		,	Id_Detalle_Pago				AS NumOperacion
		,	cModulo						AS Sistema
		,   isecuencia					as Secuencia
	    FROM sadp_detalle_pagos sdp  
	   INNER 
	    JOIN mdlbtr ml
	      ON ml.sistema = sdp.cModulo
	     AND ml.numero_operacion=  sdp.nContrato
	     and ml.secuencia = sdp.isecuencia
	     AND ml.fecha = @dfecha					
 	   WHERE iFormaPago in (103,105) AND cEstado= 'E'
 	     AND sdp.vNumTransferencia =0
 	     
END
 -- select * from mdlbtr where numero_operacion=1448672
 -- select * from sadp_detalle_pagos where ncontrato=1448672
--sp_helptext SP_SADP_CARGA_DATOS_FILIALES
GO
