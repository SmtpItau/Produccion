USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_OPC]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_OPC
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_OPC]
		@FECHA		 DATE = NULL
AS 
BEGIN
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ DETALLE OPERACIONES RF
--MODIFICACION	: 01-08-2018	DUPLICADOS
--MODIFICACION	: 05-10-2018	DUPLICADOS

SET NOCOUNT ON
--DECLARE @FECHA DATE
DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE

--set @FECHA = '2016-06-30'


IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT fechaproc FROM CbMdbOpc.dbo.OpcionesGeneral   with (nolock) ) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA 
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')


;WITH CARTERA_GEN_OPT
(
/*1*/		 NRO_DOCUMENTO			
/*2*/		,NRO_OPERACION			
/*3*/		,NRO_CORRELATIVO		
/*7*/		,COD_SUBPRODU			
/*8*/		,NUM_CUENTA				
/*9*/		,NUM_SECUENCIA_CTO		
/*10*/		,COD_DIVISA				
/*11*/		,COD_REAJUSTE			
/*12*/		,IDF_PERS_ODS			
/*15*/		,COD_GESTOR_PROD		
/*25*/		,FEC_ALTA_CTO			
/*26*/		,FEC_INI_GEST			
/*27*/		,FEC_CAN_ANT			
/*28*/		,FEC_ULT_LIQ			
/*29*/		,FEC_PRX_LIQ			
/*30*/		,FEC_ULT_REV			
/*31*/		,FEC_PRX_REV			
/*32*/		,FEC_VEN				
/*37*/		,PLZ_CONTRACTUAL		
--------------------------------------------------
/*40*/		,IMP_INI_MO				
/*41*/		,IMP_CUO_MO				
/*42*/		,IMP_CUO_INI_MO			
/*43*/		,NUM_CUO_PAC			
/*44*/		,NUM_CUO_PEND			
/*45*/		,IMP_PAGO_ML			
/*46*/		,IMP_PAGO_MO			

-------------------------------------------------
/*47*/		,IND_CAN_ANT			
/*48*/		,IND_TAS_PREDEF			
/*49*/		,TAS_PREDEF				
/*50*/		,IMP_INI_ML				
/*51*/		,TAS_INT_ORIGEN			
/*52*/		,COD_PORTAFOLIO			

/*55*/		,COD_CARTERA_FINANCI	
/*56*/		,COD_TIP_LIBRO			
/*59*/		,T_FLUJO				
-------------------------------------------
)
AS
(
--CARTERA VIGENTE
	SELECT DISTINCT

/*1*/		 NRO_DOCUMENTO			= H.CaNumFolio
/*2*/		,NRO_OPERACION			= H.CaNumContrato 
/*3*/		,NRO_CORRELATIVO		= D.CaNumEstructura

/*7*/		,COD_SUBPRODU			= H.CaCodEstructura
/*8*/		,NUM_CUENTA				= H.CaNumContrato
/*9*/		,NUM_SECUENCIA_CTO		= D.CaNumEstructura
/*10*/		,COD_DIVISA				= (case	
										 when D.CaCodMon1 in(998,997,999) then 'CLP'
										 when D.CaCodMon1 in(994,13) then 'USD'
										 else (select mnnemo from BacParamSuda.dbo.MONEDA with(nolock) where mncodmon = CaCodMon1)
										 end)
/*11*/		,COD_REAJUSTE			= (case
										 when D.CaCodMon1 in (998) then 'UF'
										 else null
										 end)
/*12*/		,IDF_PERS_ODS			= convert(varchar,H.CaRutCliente) + '-' + (select ltrim(rtrim(cldv)) from BacParamSuda.dbo.Cliente where Clrut = H.CaRutCliente and Clcodigo = H.CaCodigo)
/*15*/		,COD_GESTOR_PROD		= ltrim(rtrim(H.CaOperador))

-----------------------------------------------------
/*25*/		,FEC_ALTA_CTO			=H.CaFechaContrato
/*26*/		,FEC_INI_GEST			=H.CaFechaContrato
/*27*/		,FEC_CAN_ANT			=convert(date,'1900-01-01')
/*28*/		,FEC_ULT_LIQ			=H.CaFechaContrato
/*29*/		,FEC_PRX_LIQ			=D.CaFechaVcto
/*30*/		,FEC_ULT_REV			=H.CaFechaContrato
/*31*/		,FEC_PRX_REV			=D.CaFechaVcto
/*32*/		,FEC_VEN				=D.CaFechaVcto

-----------------------------------------------------
/*37*/		,PLZ_CONTRACTUAL		=datediff(dd,h.CaFechaContrato,d.CaFechaVcto)
------------------------------------=0--------------
/*40*/		,IMP_INI_MO				=d.CaMontoMon1
/*41*/		,IMP_CUO_MO				=0
/*42*/		,IMP_CUO_INI_MO			=d.CaMontoMon1
/*43*/		,NUM_CUO_PAC			=1
/*44*/		,NUM_CUO_PEND			=1
/*45*/		,IMP_PAGO_ML			=d.CaMontoMon2
/*46*/		,IMP_PAGO_MO			=d.CaMontoMon1
------------------------------------=0-------------
--+++MGM Cambio en el Indicador de Cancelacion a 5
/*47*/		,IND_CAN_ANT			=5--null
-----MGM 30-07-2018
/*48*/		,IND_TAS_PREDEF			='N'
/*49*/		,TAS_PREDEF				=0
/*50*/		,IMP_INI_ML				=d.CaMontoMon2
/*51*/		,TAS_INT_ORIGEN			=0
/*52*/		,COD_PORTAFOLIO			= h.CaCarteraFinanciera

/*55*/		,COD_CARTERA_FINANCI	= h.CaCarteraFinanciera
/*56*/		,COD_TIP_LIBRO			= h.CaLibro

/*59*/		,T_FLUJO				='V'			
--+++fmo 20180802 operaciones duplicadas
	FROM  CBMDBOPC.DBO.CaEncContrato AS H WITH(NOLOCK)
	INNER JOIN  CBMDBOPC.DBO.CaDetContrato AS D WITH(NOLOCK) ON H.CANUMCONTRATO = D.CANUMCONTRATO
	LEFT JOIN	CBMDBOPC.DBO.OPCIONESTRUCTURA AS E WITH(NOLOCK) ON H.CACODESTRUCTURA = E.OPCESTCOD
	WHERE LTRIM(RTRIM(H.CAESTADO))=''
	AND D.CAFECHAVCTO >= @FECHA_PROC_FILTRO
-----fmo 20180802 operaciones duplicadas
	UNION
	SELECT DISTINCT 
	*
	FROM 
	(
		-- CARTERA VENCIDA DEL MES
		SELECT DISTINCT
/*1*/		 NRO_DOCUMENTO			= H.CaNumFolio
/*2*/		,NRO_OPERACION			= H.CaNumContrato
/*3*/		,NRO_CORRELATIVO		= D.CaNumEstructura

/*7*/		,COD_SUBPRODU			= H.CaCodEstructura
/*8*/		,NUM_CUENTA				= H.CaNumContrato
/*9*/		,NUM_SECUENCIA_CTO		= D.CaNumEstructura
/*10*/		,COD_DIVISA				= (case	
										 when D.CaCodMon1 in(998,997,999) then 'CLP'
										 when D.CaCodMon1 in(994,13) then 'USD'
										 else (select mnnemo from BacParamSuda.dbo.MONEDA with(nolock) where mncodmon = CaCodMon1)
										 end)
/*11*/		,COD_REAJUSTE			= (case
										 when D.CaCodMon1 in (998) then 'UF'
										 else null
										 end)
/*12*/		,IDF_PERS_ODS			= convert(varchar,H.CaRutCliente) + '-' + (select ltrim(rtrim(cldv)) from BacParamSuda.dbo.Cliente where Clrut = H.CaRutCliente and Clcodigo = H.CaCodigo)

/*15*/		,COD_GESTOR_PROD		= ltrim(rtrim(H.CaOperador))

--------------------------------------------------------
/*25*/		,FEC_ALTA_CTO			=H.CaFechaContrato
/*26*/		,FEC_INI_GEST			=H.CaFechaContrato
/*27*/		,FEC_CAN_ANT			=convert(date,'1900-01-01')
/*28*/		,FEC_ULT_LIQ			=H.CaFechaContrato
/*29*/		,FEC_PRX_LIQ			=D.CaFechaVcto
/*30*/		,FEC_ULT_REV			=H.CaFechaContrato
/*31*/		,FEC_PRX_REV			=D.CaFechaVcto
/*32*/		,FEC_VEN				=D.CaFechaVcto
---------------------------------------------------------------
/*37*/		,PLZ_CONTRACTUAL		=datediff(dd,h.CaFechaContrato,d.CaFechaVcto)
------------------------------------=0--------------
/*40*/		,IMP_INI_MO				=d.CaMontoMon1
/*41*/		,IMP_CUO_MO				=0
/*42*/		,IMP_CUO_INI_MO			=d.CaMontoMon1
/*43*/		,NUM_CUO_PAC			=1
/*44*/		,NUM_CUO_PEND			=0
/*45*/		,IMP_PAGO_ML			=d.CaMontoMon2
/*46*/		,IMP_PAGO_MO			=d.CaMontoMon1
------------------------------------=0-------------
--+++MGM Cambio en el Indicador de Cancelacion a 5
/*47*/		,IND_CAN_ANT			=5--null
-----MGM 30-07-2018
/*48*/		,IND_TAS_PREDEF			='N'
/*49*/		,TAS_PREDEF				=0.0
/*50*/		,IMP_INI_ML				=d.CaMontoMon2
/*51*/		,TAS_INT_ORIGEN			=0.0
/*52*/		,COD_PORTAFOLIO			= h.CaCarteraFinanciera

/*55*/		,COD_CARTERA_FINANCI	= h.CaCarteraFinanciera
/*56*/		,COD_TIP_LIBRO			= h.CaLibro

/*59*/		,T_FLUJO				='V'				
--+++fmo 20180802 operaciones duplicadas
	FROM CBMDBOPC.DBO.CAVENENCCONTRATO AS H WITH(NOLOCK)
	INNER JOIN	CBMDBOPC.DBO.CAVENDETCONTRATO AS D WITH(NOLOCK)ON H.CANUMCONTRATO = D.CANUMCONTRATO
	LEFT JOIN	CBMDBOPC.DBO.OPCIONESTRUCTURA AS E WITH(NOLOCK)ON H.CACODESTRUCTURA = E.OPCESTCOD
	WHERE D.CAFECHAVCTO BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO
	AND LTRIM(RTRIM(H.CAESTADO))=''
	AND H.CaTipoTransaccion <> 'ANTICIPA'
-----fmo 20180802 operaciones duplicadas
		UNION 
		-- CARTERA ANTICIPADA 
		SELECT DISTINCT 
/*1*/		 NRO_DOCUMENTO			= H.MoNumFolio
/*2*/		,NRO_OPERACION			= H.MoNumContrato
/*3*/		,NRO_CORRELATIVO		= D.MoNumEstructura
/*7*/		,COD_SUBPRODU			= H.MoCodEstructura
/*8*/		,NUM_CUENTA				= H.MoNumContrato
/*9*/		,NUM_SECUENCIA_CTO		= D.MoNumEstructura
/*10*/		,COD_DIVISA				= (case	
										 when D.MoCodMon1 in(998,997,999) then 'CLP'
										 when D.MoCodMon1 in(994,13) then 'USD'
										 else (select mnnemo from BacParamSuda.dbo.MONEDA with(nolock) where mncodmon = d.MoCodMon1)
										 end)
/*11*/		,COD_REAJUSTE			= (case
										 when D.MoCodMon1 in (998) then 'UF'
										 else null
										 end)
/*12*/		,IDF_PERS_ODS			= convert(varchar,H.MoRutCliente) + '-' + (select ltrim(rtrim(cldv)) from BacParamSuda.dbo.Cliente where Clrut = H.MoRutCliente and Clcodigo = H.MoCodigo)
/*15*/		,COD_GESTOR_PROD		= ltrim(rtrim(H.MoOperador))
-------------------------------------------------

/*25*/		,FEC_ALTA_CTO			=MoFechaContrato
/*26*/		,FEC_INI_GEST			=MoFechaContrato
/*27*/		,FEC_CAN_ANT			=MoFechaUnwind
/*28*/		,FEC_ULT_LIQ			=MoFechaContrato
/*29*/		,FEC_PRX_LIQ			=MoFechaVcto
/*30*/		,FEC_ULT_REV			=MoFechaContrato
/*31*/		,FEC_PRX_REV			=MoFechaVcto
/*32*/		,FEC_VEN				=MoFechaVcto
-------------------------------------------------
/*37*/		,PLZ_CONTRACTUAL		=datediff(dd,h.MoFechaContrato,d.MoFechaVcto)
------------------------------------=0--------------
/*40*/		,IMP_INI_MO				=d.MoMontoMon1
/*41*/		,IMP_CUO_MO				=0
/*42*/		,IMP_CUO_INI_MO			=d.MoMontoMon1
/*43*/		,NUM_CUO_PAC			=1
/*44*/		,NUM_CUO_PEND			=0
/*45*/		,IMP_PAGO_ML			=d.MoMontoMon2
/*46*/		,IMP_PAGO_MO			=d.MoMontoMon1
------------------------------------=0-------------
--+++fmo 20180802 operaciones anticipadas
/*47*/		,IND_CAN_ANT			=1
-----fmo 20180802 operaciones anticipadas
/*48*/		,IND_TAS_PREDEF			='N'
/*49*/		,TAS_PREDEF				=0.0
/*50*/		,IMP_INI_ML				=d.MoMontoMon2
/*51*/		,TAS_INT_ORIGEN			=0.0
/*52*/		,COD_PORTAFOLIO			= h.MoCarteraFinanciera

/*55*/		,COD_CARTERA_FINANCI	= h.MoCarteraFinanciera
/*56*/		,COD_TIP_LIBRO			= h.MoLibro

/*59*/		,T_FLUJO				='A'		
		FROM			CBMDBOPC.DBO.MOHISENCCONTRATO AS H WITH(NOLOCK)	
			INNER JOIN	CBMDBOPC.DBO.MOHISDETCONTRATO AS D WITH(NOLOCK) 
			ON H.MONUMFOLIO = D.MONUMFOLIO
			LEFT JOIN	CBMDBOPC.DBO.OPCIONESTRUCTURA AS E WITH(NOLOCK)
			ON H.MOCODESTRUCTURA = E.OPCESTCOD
		WHERE 
			MoFechaUnwind BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO
		AND H.MOTIPOTRANSACCION = 'ANTICIPA'
		--AND LTRIM(RTRIM(MOESTADO))=''
	) AS CARTERA_CANCELADA

) 
SELECT DISTINCT
/*1*/		 NRO_DOCUMENTO			= 0
/*2*/		,NRO_OPERACION			
/*3*/		,NRO_CORRELATIVO		
/*4*/		,FEC_DATA				= @FECHA_PROC_FILTRO
/*5*/		,COD_ENTIDAD			='1769' 	
/*6*/		,COD_PRODUCTO			='OPT'
/*7*/		,COD_SUBPRODU			
/*8*/		,NUM_CUENTA				
/*9*/		,NUM_SECUENCIA_CTO		= REPLICATE('0', 4 - LEN(ISNULL(NUM_SECUENCIA_CTO,0))) + CONVERT(CHAR, ISNULL(NUM_SECUENCIA_CTO,0)) 
/*10*/		,COD_DIVISA				
/*11*/		,COD_REAJUSTE			
/*12*/		,IDF_PERS_ODS			
/*13*/		,COD_CENTRO_CONT		='2230'
/*14*/		,COD_OFI_COMERCIAL		=''
/*15*/		,COD_GESTOR_PROD		
/*16*/		,COD_BASE_TAS_INT		=(case
										when PLZ_CONTRACTUAL <=90 then 'M'
										when PLZ_CONTRACTUAL >=91 and PLZ_CONTRACTUAL <=179 then 'M'
										when PLZ_CONTRACTUAL >=180 and PLZ_CONTRACTUAL <=364 then 'S'
										when PLZ_CONTRACTUAL >=365 then 'A'
										end
										)
/*17*/		,COD_BCA_INT			='1'
/*18*/		,COD_COMPOS_INT			='C'
/*19*/		,COD_MOD_PAGO			='V'
/*20*/		,COD_MET_AMRT			='1'
/*21*/		,COD_CUR_REF			=0
/*22*/		,COD_TIP_TAS			='F'
/*23*/		,TAS_INT				= 0.0
/*24*/		,TAS_DIF_INC_REF		= 0.0
---------------------------------------------------
/*25*/		,FEC_ALTA_CTO			
/*26*/		,FEC_INI_GEST			
/*27*/		,FEC_CAN_ANT			
/*28*/		,FEC_ULT_LIQ			
/*29*/		,FEC_PRX_LIQ			
/*30*/		,FEC_ULT_REV			
/*31*/		,FEC_PRX_REV			
/*32*/		,FEC_VEN				
--------------------------------------------------

/*33*/		,FRE_PAGO_INT			= (case 
										when PLZ_CONTRACTUAL <31 then 1
										when PLZ_CONTRACTUAL >=31 and PLZ_CONTRACTUAL <365 then 
											case when round(PLZ_CONTRACTUAL/30,0,0)>=12 then 3
											else 2
											end																						
										when PLZ_CONTRACTUAL >=365 then 3
									   end)
/*34*/		,COD_UNI_FRE_PAGO_INT	= (case 
										when PLZ_CONTRACTUAL <31 then 'D'
										when PLZ_CONTRACTUAL >=31 and PLZ_CONTRACTUAL <365 then 
											case when round(PLZ_CONTRACTUAL/30,0,0)>=12 then 'A'
											else 'M'
											end																						
										when PLZ_CONTRACTUAL >=365 then 'A'
									   end)
/*35*/		,FRE_REV_INT			= (case 
										when PLZ_CONTRACTUAL <31 then 1
										when PLZ_CONTRACTUAL >=31 and PLZ_CONTRACTUAL <365 then 
											case when round(PLZ_CONTRACTUAL/30,0,0)>=12 then 3
											else 2
											end																						
										when PLZ_CONTRACTUAL >=365 then 3
									   end)
/*36*/		,COD_UNI_FRE_REV_INT	= (case 
										when PLZ_CONTRACTUAL <31 then 'D'
										when PLZ_CONTRACTUAL >=31 and PLZ_CONTRACTUAL <365 then 
											case when round(PLZ_CONTRACTUAL/30,0,0)>=12 then 'A'
											else 'M'
											end																						
										when PLZ_CONTRACTUAL >=365 then 'A'
									   end)
/*37*/		,PLZ_CONTRACTUAL		
/*38*/		,PLZ_AMRT				= 	(case										
										when plz_contractual <31 then plz_contractual
										when plz_contractual >=31 and plz_contractual <365 then 
											case when round(plz_contractual/30,0,0)>=12 then 1
											else round(plz_contractual/30,0,0)
											end																						
										when plz_contractual >=365 then 											
											round(plz_contractual/365,0,0) 
									   end)										   									   							
/*39*/		,COD_UNI_PLZ_AMRT		= (case 
										when PLZ_CONTRACTUAL <31 then 'D'
										when PLZ_CONTRACTUAL >=31 and PLZ_CONTRACTUAL <365 then 
											case when round(PLZ_CONTRACTUAL/30,0,0)>=12 then 'A'
											else 'M'
											end																						
										when PLZ_CONTRACTUAL >=365 then 'A'
									   end)
--------------------------------------------------
/*40*/		,IMP_INI_MO				
/*41*/		,IMP_CUO_MO				
/*42*/		,IMP_CUO_INI_MO			
/*43*/		,NUM_CUO_PAC			
/*44*/		,NUM_CUO_PEND			
/*45*/		,IMP_PAGO_ML			
/*46*/		,IMP_PAGO_MO			

-------------------------------------------------
/*47*/		,IND_CAN_ANT			
/*48*/		,IND_TAS_PREDEF			
/*49*/		,TAS_PREDEF				
/*50*/		,IMP_INI_ML				
/*51*/		,TAS_INT_ORIGEN			
/*52*/		,COD_PORTAFOLIO					
/*53*/		,DES_PORTAFOLIO				= substring(
											(select tbglosa from BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock)
											where tbcodigo1 = cod_cartera_financi 
											and tbcateg=204),1,20)
/*54*/		,COD_NEMOTECNICO			= null
/*55*/		,COD_CARTERA_FINANCI		=(case
											when cod_cartera_financi= 1 then 'TR'  -- trading
											when cod_cartera_financi= 2 then 'PLP' -- portfolio lp
											when cod_cartera_financi= 3 then 'ET' -- estructuración
											when cod_cartera_financi= 4 then 'BL' -- balance
											when cod_cartera_financi= 9 then 'PR' -- propietario
											when cod_cartera_financi= 10 then 'PLO' -- portfolio lo 180
											when cod_cartera_financi= 13 then 'MT' -- mm tasa   -- revisar
											when cod_cartera_financi= 14 then 'MF' -- mm fx -- revisar
											when cod_cartera_financi= 16 then 'BGF' -- balance gestion financiera -- revisar
											else
												'BGL' -- balance gestion liquidez
											end)
/*56*/		,COD_TIP_LIBRO				= (case when cod_tip_libro=1 then 'N' else 'B' end)
/*57*/		,NUM_DOC					= null
/*58*/		,NUM_OPE_ANT				= null		
/*59*/		,T_FLUJO					= 1
FROM CARTERA_GEN_OPT
ORDER BY NRO_OPERACION ASC

END
GO
