USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[FWD_D_CROSS_FW_DELIVERY]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC FWD_D_CROSS_FW_DELIVERY
CREATE PROCEDURE [dbo].[FWD_D_CROSS_FW_DELIVERY]
AS BEGIN 


--*** GENERADOR DE INTERFAZ MUREX FWD ***--
--*** ESTANDAR FWD CROSS - CLP ***

--Producto			 = Forward Cross
--Monedas			 = Monedas distintas de USD
--Tipo Liquidación = Estandar

DECLARE @TotalReg AS INTEGER
DECLARE @TipoOperacion AS INTEGER
DECLARE @PREcanumoper AS varchar(2)
DECLARE @vnc_desde AS DATETIME
DECLARE @OperadorDefaultMurex AS varchar(10)
DECLARE @conDetalle AS varchar(3)

SET @conDetalle = 'NO'	--SI=SI (TESTING), NO=NO (PRODUCCION), RES=CON RESUMEN (TESTING), ALL=TODO (TESTING)
SET @OperadorDefaultMurex = ''
SET @vnc_desde = '20201016'	--20210130' --'20201016'	--'19000101'
SET @TipoOperacion = 0
SET @PREcanumoper = ''		--uso solo para pruebas

-------------------- TRADER MUREX ---------
	DECLARE @totalUM AS INTEGER
	DECLARE @totalUB AS INTEGER

	SELECT "Colaborador" = 'Jiska Vos', "USER ID ITAU" = 'CJDV9015' INTO #tmpUsuariosMUREX UNION 
	SELECT "Colaborador" = 'Luis Perez', "USER ID ITAU" = 'CLPV7353' UNION 
	SELECT "Colaborador" = 'Marcelo Otarola', "USER ID ITAU" = 'CMOI0880' UNION 
	SELECT "Colaborador" = 'Martin Finger', "USER ID ITAU" = 'CMFR3217' UNION 
	SELECT "Colaborador" = 'AVECEDO, MARCELA', "USER ID ITAU" = 'CMAS2820' UNION 
	SELECT "Colaborador" = 'AVENDAÑO SALAZAR CLAUDIA ANDREA', "USER ID ITAU" = 'CCAS3191' UNION 
	SELECT "Colaborador" = 'IGNACIO ARBIZU PAIS', "USER ID ITAU" = 'CIAP0956' UNION 
	SELECT "Colaborador" = 'CIFUENTES PIZARRO MARIA FRANCISCA', "USER ID ITAU" = 'CMCP7133' UNION 
	SELECT "Colaborador" = 'CORIA MALDONADO LUIS ANTONIO', "USER ID ITAU" = 'CLCM1076' UNION 
	SELECT "Colaborador" = 'CORNEJO BELMAR VIVIANA BEATRIZ', "USER ID ITAU" = 'CVCB4928' UNION 
	SELECT "Colaborador" = 'CRUZAT UGARTE MATIAS', "USER ID ITAU" = 'CMCU6463' UNION 
	SELECT "Colaborador" = 'DIAZ FERRER MARIA JOSE', "USER ID ITAU" = 'CMDF8200' UNION 
	SELECT "Colaborador" = 'DIAZ, TOMAS', "USER ID ITAU" = 'CTDL7864' UNION 
	SELECT "Colaborador" = 'FORNO JELDES CRISTIAN ALFREDO', "USER ID ITAU" = 'CCFJ6408' UNION 
	SELECT "Colaborador" = 'GOFFARD RODRIGUEZ MICHEL CRISTIAN', "USER ID ITAU" = 'CMGR4915' UNION 
	SELECT "Colaborador" = 'GRAU PEQUEÑO ANDRES FARRAN', "USER ID ITAU" = 'CAGP436K' UNION 
	SELECT "Colaborador" = 'LUIS FARIAS SANCHEZ', "USER ID ITAU" = 'CLFS4749' UNION 
	SELECT "Colaborador" = 'LAGOS, JORGE ', "USER ID ITAU" = 'CJLM2936' UNION 
	SELECT "Colaborador" = 'MACKENNEY DA GIAU MARTHA PATRICIA', "USER ID ITAU" = 'CMMG2984' UNION 
	SELECT "Colaborador" = 'NASER, CRISTOBAL ', "USER ID ITAU" = 'CCNR6817' UNION 
	SELECT "Colaborador" = 'OBAID, MAURICIO ANDRÉS', "USER ID ITAU" = 'CMOG1777' UNION 
	SELECT "Colaborador" = 'PALACIOS, DANIEL', "USER ID ITAU" = 'CDPP3266' UNION 
	SELECT "Colaborador" = 'PATRICIO, RONCAGLIOLO', "USER ID ITAU" = 'CPRG444K' UNION 
	SELECT "Colaborador" = 'PONCE, JOSE LUIS ', "USER ID ITAU" = 'CJPS8271' UNION 
	SELECT "Colaborador" = 'RABAH RAMIREZ ALBERTO EDUARDO', "USER ID ITAU" = 'CARR9233' UNION 
	SELECT "Colaborador" = 'RAMIREZ, CAMILA', "USER ID ITAU" = 'CCRP5440' UNION 
	SELECT "Colaborador" = 'RAMIREZ, LORETO', "USER ID ITAU" = 'CLRP1107' UNION 
	SELECT "Colaborador" = 'REINIKE HERMAN GERARDO ANDRES', "USER ID ITAU" = 'CGRH0392' UNION 
	SELECT "Colaborador" = 'RINGELING, MARIANA', "USER ID ITAU" = 'CMRA7518' UNION 
	SELECT "Colaborador" = 'RIVERA LAGOS FELIPE JAVIER', "USER ID ITAU" = 'CFRL7607' UNION 
	SELECT "Colaborador" = 'RODRIGUEZ JUAN', "USER ID ITAU" = 'CJRA0393' UNION 
	SELECT "Colaborador" = 'ROSSI VILLAR PAOLA LORENA', "USER ID ITAU" = 'CPRV2151' UNION 
	SELECT "Colaborador" = 'SANTAMARIA ARTIGAS DANIEL IGNACIO', "USER ID ITAU" = 'CDSA2371' UNION 
	SELECT "Colaborador" = 'SILVA HERRERA ELIZABETH CAROLINA', "USER ID ITAU" = 'CESH0571' UNION 
	SELECT "Colaborador" = 'TORRES , LORENA', "USER ID ITAU" = 'CLTM3774' UNION 
	SELECT "Colaborador" = 'TUTELEERS TRENOVA JUAN PABLO', "USER ID ITAU" = 'CJTT8921' UNION 
	SELECT "Colaborador" = 'UMAÑA ARIAS PABLO ALEJANDRO', "USER ID ITAU" = 'CPUA0010' UNION 
	SELECT "Colaborador" = 'VILLENA PRIEGO PAULA FRANCISCA', "USER ID ITAU" = 'CPVP8594' UNION 
	SELECT "Colaborador" = 'YATES, SEBASTIAN ', "USER ID ITAU" = 'CSYO0476' UNION 
	SELECT "Colaborador" = 'ZARATE DE MENDOZA MARIO ALFONSO', "USER ID ITAU" = 'CMZD4830' UNION 
	SELECT "Colaborador" = 'Alejandro Teuber', "USER ID ITAU" = 'CATQ4698' UNION 
	SELECT "Colaborador" = 'Jose Pedro Melo', "USER ID ITAU" = 'CJMO2443' UNION 
	SELECT "Colaborador" = 'Luis Tapia V', "USER ID ITAU" = 'CLTV8426' UNION 
	SELECT "Colaborador" = 'Matias Stange', "USER ID ITAU" = 'CMSC1441' UNION 
	SELECT "Colaborador" = 'Michelle Montagnon', "USER ID ITAU" = 'CMMS1316' UNION 
	SELECT "Colaborador" = 'Pablo Vergara', "USER ID ITAU" = 'CPVC6556' UNION 
	SELECT "Colaborador" = 'Roberto Navarrete', "USER ID ITAU" = 'CRNC0366' UNION 
	SELECT "Colaborador" = 'Acuña Nelson', "USER ID ITAU" = 'CNAV0174' UNION 
	SELECT "Colaborador" = 'Alvarez Jose Miguel', "USER ID ITAU" = 'CJAN1418' UNION 
	SELECT "Colaborador" = 'Arroyo Rodrigo', "USER ID ITAU" = 'CRAP3579' UNION 
	SELECT "Colaborador" = 'Coromionas Matias', "USER ID ITAU" = 'CMCS5469' UNION 
	SELECT "Colaborador" = 'Flores Rodrigo', "USER ID ITAU" = 'CRFV0022' UNION 
	SELECT "Colaborador" = 'Hamel Ignacio', "USER ID ITAU" = 'CIHC0275' UNION 
	SELECT "Colaborador" = 'Huidobro Pablo', "USER ID ITAU" = 'CPHH0174' UNION 
	SELECT "Colaborador" = 'Linares Nolberto', "USER ID ITAU" = 'CNLB2726' UNION 
	SELECT "Colaborador" = 'Martinez Pablo', "USER ID ITAU" = 'CPMO742K' UNION 
	SELECT "Colaborador" = 'Massu Tomas', "USER ID ITAU" = 'CTMS5004' UNION 
	SELECT "Colaborador" = 'MEHECH , MARCELLE ', "USER ID ITAU" = 'NBKQ6EB' UNION 
	SELECT "Colaborador" = 'Ramirez Pedro', "USER ID ITAU" = 'CPRC1418' UNION 
	SELECT "Colaborador" = 'Salgado Tomas', "USER ID ITAU" = 'CRSE6198' UNION 
	SELECT "Colaborador" = 'Yañez Darwing', "USER ID ITAU" = 'CDYS5060' union
	SELECT "Colaborador" = 'Yañez Darwing', "USER ID ITAU" = 'CCFJ6408' 
		              
	SET @totalUM = @@ROWCOUNT
	
	SELECT "TRADER_BAC" = 'CRAMIREZ', "TRADER_ITAU" = 'CCRP5440' INTO #tmpRelTrader UNION 
	SELECT "TRADER_BAC" = 'Pvillena', "TRADER_ITAU" = 'CPVP8594' UNION 
	SELECT "TRADER_BAC" = 'RFLORES', "TRADER_ITAU" = 'CRFV0022' UNION 
	SELECT "TRADER_BAC" = 'NACUNA', "TRADER_ITAU" = 'CNLB2726' UNION		--HOMOLOGACIÓN 
	SELECT "TRADER_BAC" = 'PCONCHA', "TRADER_ITAU" = 'CCNR6817'				--HOMOLOGACIÓN 
	SELECT "TRADER_BAC" = 'CCFJ6408', "TRADER_ITAU" = 'CJRA0393'				--HOMOLOGACIÓN 
				
	SELECT DISTINCT 	
		--"OPERACIONES" = 'FWD',
		U.usuario,
		U.nombre,	
		U.tipo_usuario	,
		U.fecha_expira	,
		U.RutUsuario,	
		U.usuario_original
	INTO #tmpOperBAC 
	FROM 
		Bacfwdsuda..MFCARES AS FWD INNER JOIN BacParamSuda..USUARIO AS U ON
			U.USUARIO = FWD.caoperador
	WHERE 
--		FWD.CAESTADO <> 'A'
		CaFechaProceso >= '20190101' and 
		CAFECHA BETWEEN '20190101' AND '20191231' --OR
	--order by
	--	2 
	UNION
		SELECT DISTINCT --top 10 
		--	SAO.MoRutCliente, SAO.MoCodigo, 
		--	"OPERACIONES" = 'SAO',
 			U.usuario,
			U.nombre,	
			U.tipo_usuario	,
			U.fecha_expira	,
			U.RutUsuario,	
			U.usuario_original
		FROM 
		--	CbMdbOpc..MoHisEncContrato AS SAO --LEFT JOIN BacParamSuda..CLIENTE AS cl ON
			CbMdbOpc..MoEncContrato AS SAO INNER JOIN BacParamSuda..USUARIO AS U ON
				U.USUARIO = SAO.MoOperador
		WHERE 
			MoFechaContrato BETWEEN '20190101' AND '20200131' OR
			MoFechaPagoPrima > '20190101'
		--ORDER BY 
		--	2
	UNION
		SELECT DISTINCT --M.*
		--	"OPERACIONES" = 'SPOT',	
 			U.usuario,
			U.nombre,	
			U.tipo_usuario	,
			U.fecha_expira	,
			U.RutUsuario,	
			U.usuario_original
		FROM [BacCamSuda].dbo.MEMOH AS M INNER JOIN BacParamSuda..USUARIO AS U ON
				U.USUARIO = m.MOOPER
		WHERE
			MOFECH between '20190101' and '20200131' OR 
			MOVALUTA1 >= '20190101' OR 
			MOVALUTA2>= '20190101'
	--ORDER BY 2
	UNION
		SELECT DISTINCT 
		--	"OPERACIONES" = 'SWP',	
			U.usuario,
			U.nombre,	
			U.tipo_usuario	,
			U.fecha_expira	,
			U.RutUsuario,	
			U.usuario_original
		FROM   BacSwapSuda..CARTERAHIS AS SWP INNER JOIN BacParamSuda..USUARIO AS U ON
			U.USUARIO = SWP.operador
      WHERE  
	  			(SWP.fecha_inicio >= '20190101' OR
				SWP.fecha_termino >= '20190101' )
		ORDER BY 2
      
   SET @totalUB = @@ROWCOUNT
   
   
	--SELECT 
	--	"USUARIOS TRADER MUREX" = @totalUM,
	--	"USUARIOS BAC" = @totalUB
	
	SELECT 
			--"OPERACIONES" = OB.OPERACIONES,
			"COD. OPER. BAC" = OB.usuario,
			"ES VALIDO EN MUREX" = OM.[USER ID ITAU],
			"TRADER A INFORMAR" = CASE WHEN OM.[USER ID ITAU] = OB.usuario THEN
												OM.[USER ID ITAU] 
										ELSE
											(SELECT TOP 1 U.USUARIO 
											FROM BacParamSuda..USUARIO AS U LEFT JOIN BacParamSuda..USUARIO AS OM3 on
												OM3.rutusuario = U.rutusuario 
											WHERE
												NOT U.rutusuario = '' AND
												U.[RutUsuario] = OB.RutUsuario AND
												OM3.usuario_original = '' AND
												LEFT(U.USUARIO, 1) = 'C'
											ORDER BY U.USUARIO DESC)
										--ELSE
										END,
			"TRADER ES VALIDO EN MUREX" = CASE WHEN EXISTS (SELECT 1 FROM #tmpUsuariosMUREX AS OM2 
																	WHERE OM2.[USER ID ITAU] = 
																				CASE WHEN OM.[USER ID ITAU] = OB.usuario THEN
																						OM.[USER ID ITAU] 
																				ELSE
																					(SELECT TOP 1 U.USUARIO 
																					FROM BacParamSuda..USUARIO AS U INNER JOIN #tmpUsuariosMUREX AS OM3 on
																						OM3.[USER ID ITAU] = U.USUARIO
																					WHERE
																						U.[RutUsuario] = OB.RutUsuario AND
																						--U.USUARIO <> OB.usuario --AND
																						--U.USUARIO = OM.[USER ID ITAU]
																						LEFT(U.USUARIO, 1) = 'C'
																					ORDER BY U.USUARIO DESC)

																				END) THEN 'SI'
											ELSE
												'NO'
											END,
			OB.nombre,	
			OB.tipo_usuario	,
			OB.fecha_expira	,
			OB.RutUsuario,	
			OB.usuario_original		 
		--OM.* 
	INTO #RESULTADO
   FROM #tmpOperBAC AS OB LEFT JOIN #tmpUsuariosMUREX AS OM ON
				OB.usuario = OM.[USER ID ITAU]
--	WHERE 
--		OM.[USER ID ITAU] IS NULL
	ORDER BY
		NOMBRE


	SELECT 
		--R.OPERACIONES,
		R.[COD. OPER. BAC], 
--		R.[ES VALIDO EN MUREX], 
		"TRADER A INFORMAR" = RTRIM(LTRIM(CASE WHEN R.[TRADER A INFORMAR] IS NULL THEN 
										(SELECT RT.TRADER_ITAU FROM #tmpUsuariosMUREX AS M INNER JOIN #tmpRelTrader AS RT ON
												M.[USER ID ITAU] = RT.TRADER_ITAU
										WHERE
												RT.TRADER_BAC = R.[COD. OPER. BAC])
									ELSE 
										R.[TRADER A INFORMAR] 
									END)), 
		R.[nombre] 
	INTO #TRADER_MUREX
	FROM #RESULTADO AS R LEFT JOIN #tmpUsuariosMUREX AS OM ON
				R.[TRADER A INFORMAR] = OM.[USER ID ITAU]

--SELECT '#TRADER_MUREX', * FROM #TRADER_MUREX ORDER BY 2
-------------------- TRADER MUREX --------- 


CREATE TABLE #pasoForward (
--	"action" varChar(35), 
--	"objectNature" varChar(35), 
	"PRODUCTO" varChar(35), 
	"userName" varChar(35), --20200430.rchs."user" varChar(35), --20200421.rchs.	"userName" varChar(35), 
	"group" varChar(35), 
	"group_BAC" varChar(35), 
--	"publishingSystem" varChar(35), 
	"Trading_date" varChar(35), 
--	"type" varChar(35), 
--	"Strategy" varChar(35), 
	"CurrencyPair_driver" varChar(35), 
	"CurrencyPair_driver_BAC" varChar(35), 
	"Counterpart" varChar(35), 
	"BUY_SELL" varChar(35), 
	"BUY_SELL_BAC" varChar(35), 
	"Nominal" varChar(35), 
	"Nominal_unit" varChar(35), 
	"PAY_DATE1" varChar(35), 
	"Maturity" varChar(35), 
	"VALUTA1" varChar(35), 
	"Non_Deliverable" varChar(35), 
--	"pf_Payment_ccy" varChar(35), 
	"Portfolio" varChar(35), 

--	"udfCharacterLabels" varChar(1000), 
--	"udfCharacterValues" varChar(1000), 
--	"udfCharacterValues_BAC" varChar(1000), 
--	"udfDateLabels" varChar(100), 
--	"udfDateValues" varChar(100), 
--	"udfNumericLabels" varChar(1000), 
--	"udfNumericValues" varChar(1000),

	"ALLOCATED" varChar(35), 
	--"BROKER_Y_N" varChar(35), 
	"CANAL_CONT" varChar(35), 
	"JUST_VR" varChar(35), 
	"ESTRATEGIA" varChar(35), 

	"FWD" varChar(35), 
	"FWDMRG" varChar(35), 
	"FWDCLT" varChar(35), 
	"SPOT" varChar(35), 
	"SPOTMRG" varChar(35), 
	"SPOTCLT" varChar(35), 
	"SWPT" varChar(35), 
	"SWPTMRG" varChar(35), 
	"SWPTCLT" varChar(35), 
	"FWD1" varChar(35), 
	"FWDMRG1" varChar(35), 
	"FWDCLT1" varChar(35), 
	"SPOT1" varChar(35), 
	"SPOTMRG1" varChar(35), 
	"SPOTCLT1" varChar(35), 
	"SWPT1" varChar(35), 
	"SWPTMRG1" varChar(35), 
	"SWPTCLT1" varChar(35), 

	"FWD2" varChar(35), 								
	"FWDMRG2" varChar(35), 
	"FWDCLT2" varChar(35), 
	"SPOT2" varChar(35), 
	"SPOTMRG2" varChar(35), 
	"SPOTCLT2" varChar(35), 
	"SWPT2" varChar(35), 
	"SWPTMRG2" varChar(35), 
	"SWPTCLT2" varChar(35), 

	"FWD3" varChar(35), 								
	"FWDMRG3" varChar(35), 
	"FWDCLT3" varChar(35), 
	"SPOT3" varChar(35), 
	"SPOTMRG3" varChar(35), 
	"SPOTCLT3" varChar(35), 
	"SWPT3" varChar(35), 
	"SWPTMRG3" varChar(35), 
	"SWPTCLT3" varChar(35), 

	"MKT_FWD1" varChar(35), 
	"MKT_FWD2" varChar(35), 
	"MKT_SPOT1" varChar(35), 
	"MKT_SPOT2" varChar(35), 

	"MUT_BRK" varChar(35), 
	"MUT_BRK_1S" varChar(35), 
	"MUT_BRK_DT" varChar(35), 
	"MUT_BRK_SH" varChar(35), 
	"SALES_TRAD" varChar(35), 
	"TIPO_SPOT" varChar(35), 	

--	"VENC" varChar(35), 
	"XVA_MRG" varChar(35), 

	"price" varChar(35), 
	"margin" varChar(35), 
	"sourceSistemId" varChar(35), 
	"sourceModule" varChar(35), 
	"sourceModule_BAC" varChar(35), 
	"ourName" varChar(35), 
	"theirName" varChar(35), 
	"altId" varChar(35),
	"PVP_DVP" varChar(35),
--	"JUST_VR" varChar(35),
	"tradeGlobalId" varChar(35),

--complementarios internos para relacion entre tablas
	"clRut" varChar(35),
	"clCodCli" varChar(35),
	"otros_BAC" varChar(250),
	
--20200421.rchs.Agregar campo Sourcetrader
	"IMP_USR" Varchar(35),		--20200805.pll.reemplazar campo Sourcetrader por IMP_USR (solicitado por Mario Rivas)
	"NOMINAL2"  Varchar(35),	--20200924-	NOMINAL DEL SEGUNDO INSTRUMENTO - solicitado por Mario Rivas
	"VAAMT"  Varchar(35)			--20201004-	MARGEN DE LA OPERACION - solicitado por Mario Rivas
	)

--	De/Para	Estado Compra-Venta
SELECT "mu_buySell" = 'Buy', "Cod_BAC" = 'C' INTO #PasobuySell UNION
SELECT "mu_buySell" = 'Sell', "Cod_BAC" = 'V' 
--SELECT * FROM #PasobuySell

--	De/Para	Estado PVP_DVP
SELECT "mu_PVP_DVP" = 'DVP', "Cod_BAC" = '1' INTO #PVP_DVP UNION
SELECT "mu_PVP_DVP" = 'No', "Cod_BAC" = '0' UNION
SELECT "mu_PVP_DVP" = 'PVP', "Cod_BAC" = '2' 
--SELECT * FROM #PVP_DVP

--	De/Para	group
-- FO = Trading		--FO_SALES = Sales		(caSubCartera_Normativa)
SELECT "mu_group" = 'FO_TEC', "Cod_BAC" = 0 INTO #Pasogroup UNION		--Trading
SELECT "mu_group" = 'FO_SALES', "Cod_BAC" = 1 UNION					--Sales
SELECT "mu_group" = 'FO_FWD', "Cod_BAC" = 2 UNION
SELECT "mu_group" = 'FO_FXO', "Cod_BAC" = 9 UNION
SELECT "mu_group" = 'FO_SPT', "Cod_BAC" = 5 UNION
SELECT "mu_group" = 'FO_SUPER', "Cod_BAC" = 6 UNION
SELECT "mu_group" = 'FO_ALM', "Cod_BAC" = 7 UNION
SELECT "mu_group" = 'FO_INST', "Cod_BAC" = 8 UNION
SELECT "mu_group" = 'FO_LIQ', "Cod_BAC" = 9 UNION
SELECT "mu_group" = 'FO_IRD', "Cod_BAC" = 10 UNION
SELECT "mu_group" = 'FP_FX_SPT', "Cod_BAC" = 11 UNION
SELECT "mu_group" = 'FO_FX_FWD', "Cod_BAC" = 12
--SELECT * FROM #Pasogroup

--	De/Para	 sourceModule
SELECT "mu_SourceModule" = 'Datatec', "Cod_BAC" = 1 INTO #PasoSourceModule UNION
SELECT "mu_SourceModule" = 'E-Cambios', "Cod_BAC" = 2 UNION
SELECT "mu_SourceModule" = 'SecurityServicies', "Cod_BAC" = 3 UNION
SELECT "mu_SourceModule" = 'BloombergFxGo', "Cod_BAC" = 4 UNION
SELECT "mu_SourceModule" = 'DataMigrationBAC', "Cod_BAC" = 5 UNION
SELECT "mu_SourceModule" = 'DataMigrationFINDUR', "Cod_BAC" = 6 UNION
SELECT "mu_SourceModule" = 'DataMigrationSAO', "Cod_BAC" = 7
--SELECT * FROM #PasosourceModule
	
--	De/Para	UDF CANAL_CONT
SELECT "mu_CANAL_CONT" = 'Telefono', "Cod_BAC" = 1 INTO #PasoUDF_CANAL_CONT UNION
SELECT "mu_CANAL_CONT" = 'Chat de Bloomberg', "Cod_BAC" = 2 UNION
SELECT "mu_CANAL_CONT" = 'OTC', "Cod_BAC" = 3 UNION
SELECT "mu_CANAL_CONT" = 'Datatec', "Cod_BAC" = 4 UNION
SELECT "mu_CANAL_CONT" = 'Broker', "Cod_BAC" = 5 UNION
SELECT "mu_CANAL_CONT" = 'Security Services', "Cod_BAC" = 6 UNION
SELECT "mu_CANAL_CONT" = 'Camara EMIR', "Cod_BAC" = 7 UNION
SELECT "mu_CANAL_CONT" = 'Camara DFA', "Cod_BAC" = 8 UNION
SELECT "mu_CANAL_CONT" = 'Plataformas Externas', "Cod_BAC" = 9 UNION
SELECT "mu_CANAL_CONT" = 'CMX - Sucursales', "Cod_BAC" = 10 UNION
SELECT "mu_CANAL_CONT" = 'CMX - Web PTC Persona Fisica', "Cod_BAC" = 11 UNION
SELECT "mu_CANAL_CONT" = 'CMX - Web CDV Persona Fisica', "Cod_BAC" = 12 UNION
SELECT "mu_CANAL_CONT" = 'CMX - Web CDV Empresas', "Cod_BAC" = 13 UNION
SELECT "mu_CANAL_CONT" = 'CMX - Web TAE', "Cod_BAC" = 14 UNION
SELECT "mu_CANAL_CONT" = 'Spot Convivencia', "Cod_BAC" = 15 UNION
SELECT "mu_CANAL_CONT" = 'Bloomberg Interfaz', "Cod_BAC" = 16 UNION
SELECT "mu_CANAL_CONT" = 'CMX - Web PTC Empresa', "Cod_BAC" = 17 UNION
SELECT "mu_CANAL_CONT" = 'CMX  - Web RSU Persona Fisica', "Cod_BAC" = 18 UNION
SELECT "mu_CANAL_CONT" = 'CMX - Web CUO Persona Fisica', "Cod_BAC" = 19 UNION
SELECT "mu_CANAL_CONT" = 'CMX - Web TTR (NY/Chile)', "Cod_BAC" = 20 UNION
SELECT "mu_CANAL_CONT" = 'E-mail', "Cod_BAC" = 21 UNION
SELECT "mu_CANAL_CONT" = 'Spot Posicion de Cambio', "Cod_BAC" = 22 UNION
SELECT "mu_CANAL_CONT" = '', "Cod_BAC" = '0'
--SELECT * FROM #PasoUDF_CANAL_CONT


--	De/Para	Ccy
SELECT "mu_ccy" = 'CLP', "mu_ccy_Descr" = 'Pesos Chilenos', "Cod_BAC" = 999 INTO #PasoCcy UNION
SELECT "mu_ccy" = 'CLF', "mu_ccy_Descr" = 'Unidad de Fomento', "Cod_BAC" = 998 UNION
SELECT "mu_ccy" = 'USD', "mu_ccy_Descr" = 'Dólar Americano', "Cod_BAC" = 13 UNION
SELECT "mu_ccy" = 'EUR', "mu_ccy_Descr" = 'Euro', "Cod_BAC" = 142 UNION
SELECT "mu_ccy" = 'GBP', "mu_ccy_Descr" = 'Libra Esterlina', "Cod_BAC" = 102 UNION
SELECT "mu_ccy" = 'HKD', "mu_ccy_Descr" = 'Dólar de Hong Kong', "Cod_BAC" = 127 UNION
SELECT "mu_ccy" = 'KRW', "mu_ccy_Descr" = 'Won Surcoreano', "Cod_BAC" = 144 UNION
SELECT "mu_ccy" = 'CNY', "mu_ccy_Descr" = 'Yuan Chino Onshore', "Cod_BAC" = 48 UNION
--SELECT "mu_ccy" = 'CNH', "mu_ccy_Descr" = 'Yuan Chino Offshore', "Cod_BAC" = '0' UNION
SELECT "mu_ccy" = 'COP', "mu_ccy_Descr" = 'Peso Colombiano', "Cod_BAC" = 129 UNION
SELECT "mu_ccy" = 'PEN', "mu_ccy_Descr" = 'Nuevo Sol Peruano', "Cod_BAC" = 24 UNION
SELECT "mu_ccy" = 'MXN', "mu_ccy_Descr" = 'Peso Mexicano', "Cod_BAC" = 132 UNION
SELECT "mu_ccy" = 'AUD', "mu_ccy_Descr" = 'Dólar Australiano', "Cod_BAC" = 36 UNION
SELECT "mu_ccy" = 'BRL', "mu_ccy_Descr" = 'Real Brasileño', "Cod_BAC" = 5 UNION
SELECT "mu_ccy" = 'CAD', "mu_ccy_Descr" = 'Dólar Canadiense', "Cod_BAC" = 6 UNION
SELECT "mu_ccy" = 'CHF', "mu_ccy_Descr" = 'Franco Suizo', "Cod_BAC" = 82 UNION
SELECT "mu_ccy" = 'DKK', "mu_ccy_Descr" = 'Corona Danesa', "Cod_BAC" = 51 UNION
SELECT "mu_ccy" = 'JPY', "mu_ccy_Descr" = 'Yen Japonés', "Cod_BAC" = 72 UNION
SELECT "mu_ccy" = 'NOK', "mu_ccy_Descr" = 'Corona Noruega', "Cod_BAC" = 96 UNION
SELECT "mu_ccy" = 'NZD', "mu_ccy_Descr" = 'Dólar Neozelandes', "Cod_BAC" = 97 UNION
SELECT "mu_ccy" = 'SEK', "mu_ccy_Descr" = 'Corona Sueca', "Cod_BAC" = 113 --UNION
--SELECT "mu_ccy" = 'ZAR', "mu_ccy_Descr" = 'Rand Sudafricano', "Cod_BAC" = '0' 
--SELECT * FROM #PasoCcy

--	contract
--PDD=Pares de divisas directas ; PDI=Pares de divisas de inflación ; PDC=Pares de divisas cruzadas

--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.KRW', "Cod_BACMon1" = 13, "Cod_BACMon2" = 144 INTO #PasoContract UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.CLP', "Cod_BACMon1" = 13, "Cod_BACMon2" = 999 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.CNY', "Cod_BACMon1" = 13, "Cod_BACMon2" = 48 UNION
----SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.CNH', "Cod_BACMon1" = 13, "Cod_BACMon2" =  UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.COP', "Cod_BACMon1" = 13, "Cod_BACMon2" = 129 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.PEN', "Cod_BACMon1" = 13, "Cod_BACMon2" = 24 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.MXN', "Cod_BACMon1" = 13, "Cod_BACMon2" = 132 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.AUD', "Cod_BACMon1" = 13, "Cod_BACMon2" = 36 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.BRL', "Cod_BACMon1" = 13, "Cod_BACMon2" = 5 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.CAD', "Cod_BACMon1" = 13, "Cod_BACMon2" = 6 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.CHF', "Cod_BACMon1" = 13, "Cod_BACMon2" = 82 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.DKK', "Cod_BACMon1" = 13, "Cod_BACMon2" = 51 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.EUR', "Cod_BACMon1" = 13, "Cod_BACMon2" = 142 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.GBP', "Cod_BACMon1" = 13, "Cod_BACMon2" = 102 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.JPY', "Cod_BACMon1" = 13, "Cod_BACMon2" = 72 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.NOK', "Cod_BACMon1" = 13, "Cod_BACMon2" = 96 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.NZD', "Cod_BACMon1" = 13, "Cod_BACMon2" = 97 UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.SEK', "Cod_BACMon1" = 13, "Cod_BACMon2" = 113 UNION
----SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.ZAR', "Cod_BACMon1" = 13, "Cod_BACMon2" =  UNION
--SELECT "mu_ccyParMoneda" = 'PDD', "mu_contract" = 'USD.HKD', "Cod_BACMon1" = 13, "Cod_BACMon2" = 127 UNION
DECLARE @SEP_MONEDA AS CHAR(1)
SET @SEP_MONEDA = '/'

SELECT "mu_ccyParMoneda" = 'PDI', "mu_contract" = 'CLF' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 998, "Cod_BACMon2" = 999 INTO #PasoContract UNION
SELECT "mu_ccyParMoneda" = 'PDI', "mu_contract" = 'CLF' + @SEP_MONEDA + 'USD', "Cod_BACMon1" = 998, "Cod_BACMon2" = 13 UNION
SELECT "mu_ccyParMoneda" = 'PDI', "mu_contract" = 'EUR' + @SEP_MONEDA + 'CLF', "Cod_BACMon1" = 142, "Cod_BACMon2" = 998 UNION
SELECT "mu_ccyParMoneda" = 'PDI', "mu_contract" = 'CLF' + @SEP_MONEDA + 'MXN', "Cod_BACMon1" = 998, "Cod_BACMon2" = 132 UNION
SELECT "mu_ccyParMoneda" = 'PDI', "mu_contract" = 'CLF' + @SEP_MONEDA + 'BRL', "Cod_BACMon1" = 998, "Cod_BACMon2" = 5 UNION
SELECT "mu_ccyParMoneda" = 'PDI', "mu_contract" = 'GBP' + @SEP_MONEDA + 'CLF', "Cod_BACMon1" = 102, "Cod_BACMon2" = 998 UNION

SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'KRW' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 144 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'CNY' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 48 UNION
--SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'CLP' + @SEP_MONEDA + 'CNH', "Cod_BACMon1" = 999, "Cod_BACMon2" =  UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'MXN' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 132 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'COP' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 129 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'PEN' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 24 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'AUD' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 36 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'CAD' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 6 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'CHF' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 82 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'DKK' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 51 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'EUR' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 142 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'GBP' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 102 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'JPY' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 72 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'NOK' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 96 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'NZD' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 97 UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'SEK' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" = 113 UNION
--SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'ZAR' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 999, "Cod_BACMon2" =  UNION
SELECT "mu_ccyParMoneda" = 'PDC', "mu_contract" = 'HKD' + @SEP_MONEDA + 'CLP', "Cod_BACMon1" = 127, "Cod_BACMon2" = 999 
--SELECT * FROM #PasoContract 

--	De/Para	MUT_BRK
SELECT "mu_MUT_BRK" = 'Early Termination', "Cod_BAC" = '1' INTO #PasoMUT_BRK UNION
SELECT "mu_MUT_BRK" = 'Mandatory Early Termination', "Cod_BAC" = '2' 
--SELECT * FROM #PasoMUT_BRK

--	De/Para	JUST_VR
--SELECT "mu_JUST_VR" = 'Atencion Cliente', "Cod_BAC" = '1' INTO #PasoJUST_VR
--SELECT * FROM #PasoJUST_VR

--	De/Para	BRKCL_Y_N
SELECT "mu_BRKCL_Y_N" = 'Yes', "Cod_BAC" = '1' INTO #PasoBRKCL_Y_N UNION
SELECT "mu_BRKCL_Y_N" = 'No', "Cod_BAC" = '0' 
--SELECT * FROM #PasoBRKCL_Y_N

--	De/Para	BROKER_Y_N
SELECT "mu_BROKER_Y_N" = 'Yes', "Cod_BAC" = '1' INTO #PasoBROKER_Y_N UNION
SELECT "mu_BROKER_Y_N" = 'No', "Cod_BAC" = '0' 
--SELECT * FROM #PasoBROKER_Y_N

--	De/Para	ESTRATEGIA
SELECT "mu_ESTRATEGIA" = 'Negociacion', "Cod_BAC" = 'E' INTO #PasoESTRATEGIA UNION
SELECT "mu_ESTRATEGIA" = 'Cobertura', "Cod_BAC" = 'C' 
--SELECT * FROM #PasoESTRATEGIA

--	De/Para	Portfolio
--SELECT "mu_Portfolio" = 'MM_FX_VOL_OUT', "Cod_BAC" = 1, "Desc_Bac" = '1-HEDGE FX' INTO #PasoPortfolio UNION	
SELECT "mu_Portfolio" = 'MM_FX_FWMX', "Cod_BAC" = 1, "Desc_Bac" = '1-HEDGE FX' INTO #PasoPortfolio UNION	
SELECT "mu_Portfolio" = 'MM_IR', "Cod_BAC" = 3, "Desc_Bac" = 'HEDGE IR' UNION 
SELECT "mu_Portfolio" = 'ALM_FC_C40', "Cod_BAC" = 4, "Desc_Bac" = '4 - BALANCE' UNION 
SELECT "mu_Portfolio" = 'MM_FX_VOL', "Cod_BAC" = 8, "Desc_Bac" = '8-OPCIONES ' UNION 
SELECT "mu_Portfolio" = 'LQD_RF_IG', "Cod_BAC" = 12, "Desc_Bac" = '12 - COMDER, otros libros de colateralizacion' UNION 
SELECT "mu_Portfolio" = 'MMRF_D_TESUSD', "Cod_BAC" = 13, "Desc_Bac" = 'MM RENTA FIJA ' UNION 
SELECT "mu_Portfolio" = 'MMRF_D_COLTES', "Cod_BAC" = 15, "Desc_Bac" = 'LATAM R.FIJA' UNION 
SELECT "mu_Portfolio" = 'MMRF_D_TES_CEN', "Cod_BAC" = 20, "Desc_Bac" = '13A MM RENTA FIJA BONO CENTRAL & TESORERIA ' UNION 
SELECT "mu_Portfolio" = 'MMRF_D_180CORP', "Cod_BAC" = 21, "Desc_Bac" = '13B MM RENTA FIJA BONO CORPORATIVO LOCAL ' UNION 
SELECT "mu_Portfolio" = 'MMRF_D_180BANC', "Cod_BAC" = 22, "Desc_Bac" = '13C MM RENTA FIJA CORP BANCARIO & DAP 180 ' UNION 
SELECT "mu_Portfolio" = 'MMRF_D_LATAMUSD', "Cod_BAC" = 23, "Desc_Bac" = '13D MM RENTA FIJA BONO LATAM USD ' UNION 
SELECT "mu_Portfolio" = 'ALM_RF_AFS', "Cod_BAC" = 24, "Desc_Bac" = '4A - ALM: INST BCCH Y T. GENERAL DE LA REPÚBLICA' UNION 
SELECT "mu_Portfolio" = 'ALM_RF_AFS', "Cod_BAC" = 25, "Desc_Bac" = '4B - ALM: INSTRUMENTOS BANCARIOS' UNION 
SELECT "mu_Portfolio" = 'LQD_RF_AC_BCCH', "Cod_BAC" = 34, "Desc_Bac" = 'Instrumentos BCCH - 4C' UNION 
SELECT "mu_Portfolio" = 'LQD_DERIVADOS', "Cod_BAC" = 35, "Desc_Bac" = '4D - LIQUIDEZ: INSTRUMENTOS BANCARIOS' UNION 
SELECT "mu_Portfolio" = 'LQD_RF_IG', "Cod_BAC" = 39, "Desc_Bac" = '4G - LIQUIDEZ: Treasuries USD' 
--SELECT * FROM #PasoPortfolio

--	De/Para	SalesTrading
SELECT "Cod_BAC" = 'ARABAH', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' INTO #PasoSalesTrad UNION 
SELECT "Cod_BAC" = 'ATEUBER', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CARR9233', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CATQ4698', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CAVENDANO', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CCAS3191', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CCFJ6408', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CCNR6817', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CDPP3266', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CDYS5060', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CFORNO', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CIHC0275', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CJAN1418', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CJDV9015', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'cjmo2443', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CJRA0393', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CLCM1076', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CLPV7353', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'clrp1107', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CMCP7133', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CMCS5469', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CMCU6463', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CMDF8200', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CMFR3217', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CMGR4915', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CMMS1316', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CMOG1777', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CMOI0880', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CMSC1441', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CMZD4830', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CNLB2726', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CPHG0773', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CPHH0174', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CPMO742K', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CPRC1418', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CPRC742K', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CPRG444K', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CPRV2151', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CPUA0010', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'CPVC6556', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CRAP3579', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CRNC0366', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CRSE6198', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'CTMS5004', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'DYANEZS', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'IHAMEL', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'jalvarez', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'LCORIA', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'LPEREZ', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'LPEREZV', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'mcifuentes', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'MCOROMINAS', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'MCRUZAT', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'MDIAZF', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'MGOFFARD', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'MSTANGE', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'MZARATE', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'MZARATEM', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'NBKQ6EB', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'NLINARES', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'phuidobro', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'pmartinez', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'PRAMIREZ', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'PROSSI', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'PUMANA', "esTrader" = 'S', "mu_SalesTrad" = 'Sales' UNION 
SELECT "Cod_BAC" = 'PVERGARA', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'RARROYO', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'RFLORES', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'RNAVARRETE', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'tmassu', "esTrader" = 'S', "mu_SalesTrad" = 'Trading' UNION 
SELECT "Cod_BAC" = 'TSALGADO', "esTrader" = 'S', "mu_SalesTrad" = 'Trading'
--SELECT * FROM #PasoSalesTrad

--Actividad Contraparte
SELECT "mu_ACT_CONTRAPARTE" = 'BANK', "Cod_BAC" = 2 into #PasoActivContraparte UNION
--SELECT "ACT_CONTRAPARTE" = 'BROKER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CUSTOMER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'FICTIVE', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'INTERNAL PARTY', "Cod_BAC" = 9 UNION
SELECT "mu_ACT_CONTRAPARTE" = 'OTHER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'GROUP', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'SUBSIDIARY', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'BRANCH', "Cod_BAC" = 9 UNION
SELECT "ACT_CONTRAPARTE" = 'CORPORATE', "Cod_BAC" = 7 UNION
SELECT "ACT_CONTRAPARTE" = 'STATE', "Cod_BAC" = 11 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLEARER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLIENT', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'ISSUER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'AGENT', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'LEGAL ENTITY', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'REFERENCE ENTITY', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'GUARANTOR', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'OPERATOR', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CUSTODIAN', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'AUDITOR', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'TRANSFER AGENT', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CENTRAL ADMINISTRATI', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'PROMOTER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'MANAGEMENT COMPANY', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'INVESTMENT MANAGER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'PROCESSING AREA', "Cod_BAC" = 9 UNION
SELECT "ACT_CONTRAPARTE" = 'HEDGE FUND', "Cod_BAC" = 6 UNION
--SELECT "ACT_CONTRAPARTE" = 'FUND', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CCP', "Cod_BAC" = 9 UNION
SELECT "ACT_CONTRAPARTE" = 'SETTLEMENT AGENT', "Cod_BAC" = 8 
--SELECT "ACT_CONTRAPARTE" = 'TRIPARTY AGENT', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLEARING BROKER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'FUND.INTERNAL', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'FUND.MANDATE', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLS MEMBER', "Cod_BAC" = 9 UNION
--SELECT "ACT_CONTRAPARTE" = 'CLS TPS MEMBER', "Cod_BAC" = 9
--SELECT * FROM #PasoActivContraparte

INSERT INTO #pasoForward
	([PRODUCTO], [userName], [group], [group_BAC], [Trading_date], [CurrencyPair_driver], 
	[CurrencyPair_driver_BAC], [Counterpart], [BUY_SELL], [BUY_SELL_BAC], [Nominal],
	[Nominal_unit], [PAY_DATE1], [Maturity], [VALUTA1], [Non_Deliverable], --[pf_Payment_ccy],
	[Portfolio], 
	
	--[udfCharacterLabels], [udfCharacterValues], 
	--[udfNumericLabels],  [udfNumericValues], 
	
	[ALLOCATED], 
	--"BROKER_Y_N], 
	[CANAL_CONT], 
	[JUST_VR], 
	[ESTRATEGIA], 

	[FWD], 
	[FWDMRG], 
	[FWDCLT], 
	[SPOT], 
	[SPOTMRG], 
	[SPOTCLT], 
	[SWPT], 
	[SWPTMRG], 
	[SWPTCLT], 
	
	[FWD1], 
	[FWDMRG1], 
	[FWDCLT1], 
	[SPOT1], 
	[SPOTMRG1], 
	[SPOTCLT1], 
	[SWPT1], 
	[SWPTMRG1], 
	[SWPTCLT1], 

	[FWD2], 								
	[FWDMRG2], 
	[FWDCLT2], 
	[SPOT2], 
	[SPOTMRG2], 
	[SPOTCLT2], 
	[SWPT2], 
	[SWPTMRG2], 
	[SWPTCLT2], 

	--[FWD3], 								
	--[FWDMRG3], 
	--[FWDCLT3], 
	--[SPOT3], 
	--[SPOTMRG3], 
	--[SPOTCLT3], 
	--[SWPT3], 
	--[SWPTMRG3], 
	--[SWPTCLT3], 

	[MKT_FWD1], 
	[MKT_FWD2], 
	[MKT_SPOT1], 
	[MKT_SPOT2], 

	--[MUT_BRK], 
	--[MUT_BRK_1S], 
	--[MUT_BRK_DT], 
	--[MUT_BRK_SH], 
	[SALES_TRAD], 
	[TIPO_SPOT], 	

--	[VENC], 
--	[XVA_MRG], 
	
	[price], [margin], [sourceSistemId], [sourceModule],
	[sourceModule_BAC], [ourName], [theirName], [altId], [PVP_DVP], 
	--[JUST_VR], 
	[tradeGlobalId],
	[clRut], [clCodCli], [otros_BAC], [IMP_USR], [NOMINAL2],
	[VAAMT])
SELECT --top 1000
	"PRODUCTO" = 'CROSS',
	--"userName" = 'GCORREA',	--ISNULL(LTRIM(RTRIM(FWD.caoperador)), ''), --Codigo Trader -- mantener en forma temporal
	"userName" = 'PROCESOS', --T.[TRADER A INFORMAR],	--'GCORREA'
	"group" = GRP.mu_group, --prd.descripcion, --Indica la mesa dueña de la operación
	"group_BAC" = GRP.Cod_BAC, --prd.descripcion, --Indica la mesa dueña de la operación
	"Trading_date" = RTRIM(CONVERT(CHAR(10), FWD.cafecha, 112)), --Fecha Operación
	"CurrencyPair_driver" = ISNULL(C.mu_contract, ''),	--Par de Divisas 
	"CurrencyPair_driver_BAC" = CAST(CASE WHEN MN1.mncodmon = 13 THEN 
											MN1.mncodmon 
										ELSE MN2.mncodmon
										END AS VARCHAR(20)) + '.' +
									--C.Cod_BACMon2 = 
										CAST(CASE WHEN MN1.mncodmon = 13 THEN 
													MN2.mncodmon 
											ELSE MN1.mncodmon
										END AS VARCHAR(20)),				--Par de Divisas-BAC
	"Counterpart" = SUBSTRING(CAST(CL.clrut AS VARCHAR(12)) + '-' + CAST(CL.CLDV AS VARCHAR(12)), 1, 35) +	--rut Contraparte
								(CASE WHEN (SELECT COUNT(1) FROM BacParamSuda..cliente cl2 
												WHERE cl2.clrut = CL.clrut AND 
													cl2.clvigente = 'S' AND 
													LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('MALO_%') AND
													LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%') 
												GROUP BY cl2.clrut) > 1 THEN ('-' + RIGHT('0' + LTRIM(RTRIM(cl.clcodigo)), 2))
							ELSE ''
							END),
	"BUY_SELL" = BS.MU_buySell, --Determina si es compra o venta
	"BUY_SELL_BAC" = BS.Cod_BAC, --Determina si es compra o venta
	"Nominal" = FWD.camtomon1, --Monto de la operación
	"Nominal_unit" = Ccy1.mu_ccy, --Divisa Contratada
	"PAY_DATE1" = RTRIM(CONVERT(CHAR(10), (SELECT Bacfwdsuda.dbo.CalcularFechaValuta(FWD.cafpagomx, FWD.cafecvcto)), 112)),
	"Maturity" =  RTRIM(CONVERT(CHAR(10), FWD.cafecvcto, 112)),		--Fecha de Vencimiento
	"VALUTA1" = CAST(ISNULL((SELECT diasvalor 
												FROM   Bacfwdsuda..VIEW_FORMA_DE_PAGO  
												WHERE  Codigo = FWD.cafpagomx), 0) AS VARCHAR(2)) + 'od',	--VALUTA

	"Non_Deliverable" = CASE WHEN FWD.catipmoda = 'E' THEN 'N' ELSE 'Y' END, --Indicador Delivery  (N), 
	--"pf_Payment_ccy" = ISNULL(Ccy2.mu_ccy, ''),
	"Portfolio" = ISNULL(rtrim(POR.mu_Portfolio), ''),  

	"ALLOCATED" = 		'No',	-- + ';' +					--ALLOCATED
	--"BROKER_Y_N" = 	--	ISNULL(BRO.mu_BROKER_Y_N, ''),	-- + ';' +	--BROKER_Y_N
	"CANAL_CONT" =		CAST(CC.mu_CANAL_CONT AS VARCHAR(10)),	-- + ';' +	--CANAL_CONT
--	"JUST_VR" = 		JV.mu_JUST_VR,	-- + ';' + --JUST_VR
	"JUST_VR" = 		'',	--JV.mu_JUST_VR,	--JUST_VR
	"ESTRATEGIA" = 	E.mu_ESTRATEGIA, 		--ESTRATEGIA

	--	"udfNumericValues" = 
	--------------		Mx/CLP
	--"FWD" = 		CAST(FWD.cacosto_mxclp AS VARCHAR(20)),	-- + ';' +		--FWD			(Precio forward al cliente)
	"FWD" = 		CAST(CONVERT(NUMERIC(20,7),FWD.cacosto_mxclp) AS VARCHAR(20)),		
	"FWDMRG" = 	CAST(0 AS VARCHAR(20)),	-- + ';' +	--FWDMRG		(Margen de forward)
	--"FWDCLT" =	CAST(FWD.caprecal AS VARCHAR(20)),	-- + ';' +				--FWDCLT		(Precio forward al cliente)
	"FWDCLT" = 		CAST(CONVERT(NUMERIC(20,7),FWD.caprecal) AS VARCHAR(20)),			

	--"SPOT" =		CAST((FWD.caSpotTipCam * FWD.caSpotParidad)AS VARCHAR(20)),	-- + ';' +			--SPOT		(Precio spot de posicion)
	--"SPOT" =		CAST(CONVERT(NUMERIC(21,4), ROUND((FWD.caSpotTipCam * FWD.caSpotParidad), 4)) AS VARCHAR(20)),	
	"SPOT" =	CASE WHEN MN1.mnrefusd = 1 THEN
					CAST(CONVERT(NUMERIC(21,8), FWD.caSpotTipCam * FWD.caSpotParidad)AS VARCHAR(20))
				ELSE
					CAST(CONVERT(NUMERIC(21,8), FWD.caSpotTipCam / FWD.caSpotParidad)AS VARCHAR(20))
				END,

	"SPOTMRG" = CAST(0 AS VARCHAR(20)),	-- + ';' +	--SPOTMRG	(Margen de sales del spot)
	--"SPOTCLT" = CAST(FWD.caSpotTipCam * FWD.caSpotParidad AS VARCHAR(20)),	-- + ';' +			--SPOTCLT	(Precio spot al cliente)
	--"SPOTCLT" =	CAST(CONVERT(NUMERIC(21,4), ROUND(FWD.caSpotTipCam * FWD.caSpotParidad, 4)) AS VARCHAR(20)),	
	"SPOTCLT" =	CASE WHEN MN1.mnrefusd = 1 THEN
						CAST(convert(numeric(21,8), FWD.caSpotTipCam * FWD.caSpotParidad)AS VARCHAR(20))
					ELSE
						CAST(convert(numeric(21,8), FWD.caSpotTipCam / FWD.caSpotParidad)AS VARCHAR(20))
					END,

	"SWPT" =		CAST(0 AS VARCHAR(20)),	
	"SWPTMRG" =	CAST(0 AS VARCHAR(20)),	
	"SWPTCLT" =	CAST(0 AS VARCHAR(20)),	

	------------		Mx/USD
	--"FWD1" = 	CAST(FWD.cacosto_mxusd AS VARCHAR(20)),	-- + ';' +			--FWD1					(Precio forward al cliente)
	"FWD1" = 	CAST(CAST(FWD.cacosto_mxusd AS NUMERIC(20,7)) AS VARCHAR(20)),	-- + ';' +			--FWDCLT1					(Precio forward al cliente)
	"FWDMRG1" =	CAST(0 AS VARCHAR(20)),	-- + ';' +	--FWDMRG		(Margen de forward)
	--"FWDCLT1" =	CAST(FWD.caparmon2 AS VARCHAR(20)),	-- + ';' +			--FWDCLT1					(Precio forward al cliente)
	"FWDCLT1" = CAST(CAST(FWD.caparmon2 AS NUMERIC(20,7)) AS VARCHAR(20)),	-- + ';' +			--FWDCLT1					(Precio forward al cliente)	

	--"SPOT1" = 	CAST(FWD.caSpotParidad AS VARCHAR(20)),	-- + ';' + --SPOT1			(Precio spot de posicion)
	"SPOT1" = 		CAST(CAST(FWD.caSpotParidad AS NUMERIC(20,7)) AS VARCHAR(20)),	-- + ';' +			--FWDCLT1					(Precio forward al cliente)	
	"SPOTMRG1" =	CAST(0 AS VARCHAR(20)),	-- + ';' +	--SPOTMRG1		(Margen de sales del spot)
	--"SPOTCLT1" = 		CAST(FWD2.caSpotParidad AS VARCHAR(20)),	-- + ';' +			--SPOTCLT1		(Precio spot al cliente)
	"SPOTCLT1" =	CAST(CAST(FWD.caSpotParidad AS NUMERIC(20,7)) AS VARCHAR(20)),	-- + ';' +			--FWDCLT1					(Precio forward al cliente)	

	"SWPT1" =			CAST(0 AS VARCHAR(20)),	
	"SWPTMRG1" =		CAST(0 AS VARCHAR(20)),	
	"SWPTCLT1" =		CAST(0 AS VARCHAR(20)),	

	--------------	USD/CLP
	--"FWD2" = 		CAST(FWD.cacosto_usdclp AS VARCHAR(20)),	-- + ';' +			--FWD2					(Precio forward al cliente)
	"FWD2" = 		CAST(CAST(FWD.cacosto_usdclp AS NUMERIC(20,7)) AS VARCHAR(20)),
	"FWDMRG2" = 	CAST(0 AS VARCHAR(20)),	-- + ';' +		--FWDMRG2					(Margen de forward)
	--"FWDCLT2" = 	CAST(FWD.capremon2 AS VARCHAR(20)),	-- + ';' +			--FWDCLT2					(Precio forward al cliente)
	"FWDCLT2" = 		CAST(CAST(FWD.capremon2 AS NUMERIC(20,7)) AS VARCHAR(20)),

	--"SPOT2" =		CAST((FWD.caSpotTipCam)AS VARCHAR(20)),	-- + ';' +			--SPOT		(Precio spot de posicion)
	"SPOT2" = 		CAST(CAST(FWD.caSpotTipCam AS NUMERIC(20,7)) AS VARCHAR(20)),
	"SPOTMRG2" = 	CAST(0 AS VARCHAR(20)),	-- + ';' +	--SPOTMRG	(Margen de sales del spot)
	--"SPOTCLT2" =	CAST(FWD.caSpotTipCam AS VARCHAR(20)),	-- + ';' +				--SPOTCLT	(Precio spot al cliente)
	"SPOTCLT2" =	CAST(CAST(FWD.caSpotTipCam AS NUMERIC(20,7)) AS VARCHAR(20)),
									
	"SWPT2" =			CAST(0 AS VARCHAR(20)),	
	"SWPTMRG2" =		CAST(0 AS VARCHAR(20)),	
	"SWPTCLT2" =		CAST(0 AS VARCHAR(20)),	

	--"MKT_FWD1" = 		CAST(FWD.catasaEfectMon1 AS VARCHAR(20)),	-- + ';' +				--'MKT_FWD1 
	"MKT_FWD1" = 	CAST(CONVERT(NUMERIC(20,12),FWD.catasaEfectMon1) AS VARCHAR(20)),	
	--"MKT_FWD2" = 		CAST(FWD.catasaEfectMon2 AS VARCHAR(20)),	-- + ';' +				--'MKT_FWD2 
	"MKT_FWD2" = 	CAST(CONVERT(NUMERIC(20,12),FWD.catasaEfectMon2) AS VARCHAR(20)),	

	--"MKT_SPOT1" =	CAST(FWD2.catasaEfectMon1 AS VARCHAR(20)),	-- + ';' +				--'MKT_SPOT1 
	"MKT_SPOT1" = 	CAST(CONVERT(NUMERIC(20,12),FWD2.catasaEfectMon1) AS VARCHAR(20)),		
	--"MKT_SPOT2" =	CAST(FWD2.catasaEfectMon2 AS VARCHAR(20)),	-- + ';' +				--'MKT_SPOT2 
	"MKT_SPOT2" = 	CAST(CONVERT(NUMERIC(20,12),FWD2.catasaEfectMon2) AS VARCHAR(20)),		


--	"SALES_TRAD" = 	ISNULL(ST.mu_SalesTrad, ''),	--  + ';' +	--SALES_TRAD
	"SALES_TRAD" = ISNULL(ST.mu_SalesTrad,
									CASE WHEN AC.mu_ACT_CONTRAPARTE = 'BANK' THEN 
										'Trading'
									ELSE
										'Sales'
									END),
	
	"TIPO_SPOT" = 		'Forward',	-- + ';' +					--TIPO_SPOT

--	"VENC" = RTRIM(CONVERT(VARCHAR(10), FWD.cafecvcto, 112)), --Valores de las UDF de tipo fecha, Ver UDF Posibles
--	XVA_MRG
--								'',

--	"price" = CONVERT(NUMERIC(21,8), FWD.catipcam), --Precio Final
	"price" = CASE WHEN mn1.mnnemo = 'UF ' THEN 
							ROUND(CASE FWD.cacodpos1 WHEN 2 THEN FWD.caparmon1 ELSE FWD.caprecal END, 9)
						WHEN (mn2.mnnemo <> 'UF ' OR mn2.mnnemo <> 'USD') THEN
							ROUND(CASE FWD.cacodpos1 WHEN 2 THEN FWD.caparmon1 ELSE FWD.caprecal END, 4)
						WHEN (mn2.mnnemo = 'UF ') THEN
							ROUND(FWD.catipcam, 4)
						ELSE
							ROUND(CASE FWD.cacodpos1 WHEN 2 THEN FWD.caparmon1 ELSE FWD.caprecal END, 2)
						END,
	
	"margin" = 0, --Margen 
	"sourceSistemId" = @PREcanumoper + CAST(FWD.canumoper AS VARCHAR(20)), --Numero de operación
	"sourceModule" = SM.mu_SourceModule, --Identifica el sistema origen
	"sourceModule_BAC" = SM.Cod_BAC, --Identifica el sistema origen
	
	"ourName" = 'ITAU-Chile', --MXpress', 
	"theirName" = 	SUBSTRING(CAST(CL.clrut AS VARCHAR(12)) + '-' + CAST(CL.CLDV AS VARCHAR(12)), 1, 35) +	--rut Contraparte
								(CASE WHEN (SELECT COUNT(1) FROM BacParamSuda..cliente cl2 
												WHERE cl2.clrut = CL.clrut AND 
													cl2.clvigente = 'S' AND 
													LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('MALO_%') AND
													LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%') 
												GROUP BY cl2.clrut) > 1 THEN ('-' + RIGHT('0' + LTRIM(RTRIM(cl.clcodigo)), 2))
							ELSE ''
							END),

	"altId" = 	'"' + SM.mu_SourceModule + ',UID,' + @PREcanumoper + CAST(FWD.canumoper AS VARCHAR(10)) + '"',
	"PVP_DVP" = PD.mu_PVP_DVP,	
--	"JUST_VR" = JV.mu_JUST_VR,	
	"tradeGlobalId" = @PREcanumoper + CAST(FWD.canumoper AS VARCHAR(10)),
	
	"clRut" = CL.clrut ,
	"clCodCli" = CL.clcodigo,
   "otros_BAC" =  CASE WHEN FWD.cacalvtadol = 14 THEN 'FORWARD STARTING'  
										WHEN FWD.cacalvtadol = 15 THEN 'FORWARD ASIATICO'  
										WHEN FWD.cacalvtadol = 16 THEN 'SPOT OBSERVADO'  
										ELSE      prd.descripcion   
										END + ';' + 
										CAST(FWD.var_moneda2 AS VARCHAR(20))+ ';' + 
										CAST(fwd.cacodpos1 AS VARCHAR(20)),
	--"IMP_USR" = LTRIM(RTRIM(ISNULL(T.[TRADER A INFORMAR], @OperadorDefaultMurex)))		--sourcetrader
	"IMP_USR" = RTRIM(ISNULL(T.[TRADER A INFORMAR], (SELECT ISNULL(TRADER_ITAU, '') FROM #tmpRelTrader WHERE TRADER_BAC = FWD.caoperador))),
	"NOMINAL2" = FWD.caequmon2,
--	"VAAMT" = CAST(CAST(FWD2.Resultado_Mesa AS NUMERIC(20,7)) + CAST(FWD.cadiferen AS NUMERIC(20,7)) AS VARCHAR(20))
	"VAAMT" = CAST(CAST(ROUND(FWD.resultado_mesa * (SELECT Tipo_Cambio FROM BacParamSuda..valor_moneda_contable			--(formula entregada por C.Cerda 20201020)
															WHERE 	Codigo_Moneda = 994 and	fecha = FWD.cafecha) 
				+ FWD2.resultado_mesa, 0) AS NUMERIC(20,0)) AS VARCHAR(35))

FROM 
----***(APLICAR A CONSULTA ESPECÍFICA POR X DÍAS ATRÁS--- SOLO PARA TEST) *******
--	MFCARES AS FWD LEFT JOIN BacParamSuda..CLIENTE AS cl ON
	Bacfwdsuda..MFCA AS FWD LEFT JOIN BacParamSuda..CLIENTE AS cl ON
----***(APLICAR A CONSULTA ESPECÍFICA POR X DÍAS ATRÁS--- SOLO PARA TEST) *******	
		CL.CLRUT = FWD.cacodigo AND
		CL.CLCODIGO = FWD.cacodcli AND
		FWD.canumoper = FWD.var_moneda2 		--PRINCIPAL O ARBITRAJE 

----***(APLICAR A CONSULTA ESPECÍFICA POR X DÍAS ATRÁS--- SOLO PARA TEST) *******		
--	LEFT JOIN MFCARES AS FWD2 ON
	LEFT JOIN Bacfwdsuda..MFCA AS FWD2 ON		--SECUNDARIO O SEGURO DE CAMBIO
----***(APLICAR A CONSULTA ESPECÍFICA POR X DÍAS ATRÁS--- SOLO PARA TEST) *******	
		FWD2.var_moneda2 = FWD.var_moneda2 AND
		FWD2.canumoper <> FWD2.var_moneda2 
		
	LEFT JOIN #PasobuySell AS BS ON
		BS.cod_bac = FWD.catipoper
	LEFT JOIN BacParamSuda.dbo.MONEDA   MN1 ON mn1.mncodmon   = FWD.cacodmon1  
	--LEFT JOIN BacParamSuda.dbo.MONEDA   MN2 ON mn2.mncodmon   = FWD.cacodmon2    
	LEFT JOIN BacParamSuda.dbo.MONEDA   MN2 ON mn2.mncodmon   = FWD2.cacodmon2    
	LEFT JOIN #PasoContract AS C ON
		C.Cod_BACMon1 = CASE WHEN MN1.mncodmon = 999 THEN 
				MN1.mncodmon 
			ELSE MN2.mncodmon
			END AND
		C.Cod_BACMon2 = CASE WHEN MN1.mncodmon = 999 THEN 
				MN2.mncodmon 
			ELSE MN1.mncodmon
			END
	LEFT JOIN BacParamSuda.dbo.PRODUCTO PRD ON 
			PRD.id_sistema = 'BFW' AND PRD.codigo_producto = FWD.cacodpos1
	LEFT JOIN #PasoCcy AS Ccy1 ON
			Ccy1.cod_bac = Mn1.mncodmon
	LEFT JOIN #PasoCcy AS Ccy2 ON
			Ccy2.cod_bac = Mn2.mncodmon 			
	LEFT JOIN #Pasogroup AS Grp ON
			Grp.cod_bac = 0 --FO_TEC
	LEFT JOIN #PasoUDF_CANAL_CONT AS CC ON
			CC.cod_bac = 1
	LEFT JOIN #PVP_DVP AS PD ON
			PD.cod_bac = 0
	LEFT JOIN #PasoESTRATEGIA AS E ON
			E.cod_bac = fwd.catipmoda	
	LEFT JOIN #PasoSourceModule AS SM ON
			SM.cod_bac = 5
--	LEFT JOIN #PasoJUST_VR AS JV ON	
--			JV.cod_bac = 1
	LEFT JOIN #PasoBRKCL_Y_N AS BRK ON	
			BRK.cod_bac = FWD.bEarlyTermination
	LEFT JOIN #PasoBROKER_Y_N AS BRO ON
			BRO.cod_bac = FWD.cabroker
--	LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS POR ON 
--			POR.tbcateg   = 204 AND						
--			POR.tbcodigo1 = FWD.cacodcart
	LEFT JOIN 	#PasoPortfolio AS POR ON 
			POR.Cod_BAC = FWD.cacodcart
	LEFT JOIN #TRADER_MUREX AS T ON
		T.[COD. OPER. BAC] = FWD.caoperador 
	LEFT JOIN #PasoSalesTrad AS ST ON
--		ST.cod_bac = 1 --Para CROSS siempre s Sales	--20200804 indicado por MArio R.
		ST.cod_bac = ISNULL(T.[TRADER A INFORMAR], (SELECT ISNULL(TRADER_ITAU, '') FROM #tmpRelTrader WHERE TRADER_BAC = FWD.caoperador)) 	
	LEFT JOIN #PasoActivContraparte AS AC ON --cltipcli
		(((
			ac.cod_bac = 2 and cl.cltipcli IN(1, 2)) or	--BANCOS
			(ac.cod_bac = 11 and cl.cltipcli IN(10, 11)) or	--ESTADO
			(ac.cod_bac = 7 and cl.cltipcli not IN(1,2,10,11) and CL.seg_comercial = 3) or		--CORPORATIVO
--					(ac.cod_bac = 6 and cl.cltipcli = 6) or		--AFPs
			
			(ac.cod_bac = 9 and cl.cltipcli not IN(1,2,10,11) AND CL.seg_comercial <> 3)) 		-- OTROS
		)
			
WHERE
FWD.canumoper IN( 619936
,618384
) and 

----***(APLICAR A CONSULTA ESPECÍFICA POR X DÍAS ATRÁS--- SOLO PARA TEST) *******
--	FWD.CaFechaProceso = @vnc_desde AND	
--	FWD2.CaFechaProceso = FWD.CaFechaProceso AND
----***(APLICAR A CONSULTA ESPECÍFICA POR X DÍAS ATRÁS--- SOLO PARA TEST) *******

	--(FWD.cacodpos1 = @TipoOperacion or @TipoOperacion = 0) AND
	CL.clvigente = 'S' AND 
	LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('MALO_%') AND
	LTRIM(RTRIM(CL.Clnombre)) NOT LIKE('%NO USAR%') AND	

	(FWD.cafecvcto >= @vnc_desde or @vnc_desde = '19000101') AND

	FWD.var_moneda2 <> 0 AND
	
	--NOT ((FWD.cacodmon1 = 13 and FWD.cacodmon2 = 999) OR (FWD.cacodmon1 = 999 and FWD.cacodmon2 = 13)) AND
--	((FWD.cacodmon1 <> 13 and FWD.cacodmon2 = 998) OR (FWD.cacodmon1 <> 998 and FWD.cacodmon2 <> 13)) AND
	FWD.catipmoda = 'E' --AND
	--FWD.var_moneda2 IN(615113)

--			and clrut = 97036000  --muestra
--			and not (CL.Clnombre like '%banco%' or CL.Clnombre like '%banc%' or CL.Clnombre like '%bank%')
--			and (CL.cltipcli = 6 ) --and not CL.Clnombre like '%tipo%')
ORDER BY 
	FWD.var_moneda2 DESC, FWD.canumoper , CL.clrut DESC, CL.CLCODIGO	

	select '#pasoForward', * from #pasoForward

SELECT @TotalReg = @@ROWCOUNT

/*
SELECT "linea_murex" = 
	'PRODUCTO' + ',' + 'userName' + ',' + 	'group' + ',' +  'Trading_date' + ',' + 'CurrencyPair_driver' + ',' + 
	'Counterpart' + ',' + 'BUY_SELL' + ',' + 	'Nominal' + ',' + 	'Nominal_unit' + ',' + 	'PAY_DATE1' + ',' + 
	--'Maturity' + ',' + 'Non_Deliverable' + ',' + 'pf_Payment_ccy' + ',' + 'Portfolio'  + ',' +
	'Maturity' + ',' + 'VALUTA1' + ',' + 'Non_Deliverable' + ',' + 'Portfolio'  + ',' +

	--'udfCharacterLabels' + ',' + 	'udfCharacterValues' + ',' + 	
	--'udfDateLabels' + ',' + 	'udfDateValues' + ',' + 
	--'udfNumericLabels' + ',' +	'udfNumericValues' + ',' + 
	'ALLOCATED' + ',' + 
--	'BROKER_Y_N' + ',' + 
	'CANAL_CONT' + ',' + 
	'JUST_VR' + ',' + 
	'ESTRATEGIA' + ',' + 

	'FWD' + ',' + 
	'FWDMRG' + ',' + 
	'FWDCLT' + ',' + 
	'SPOT' + ',' + 
	'SPOTMRG' + ',' + 
	'SPOTCLT' + ',' + 
	'SWPT' + ',' + 
	'SWPTMRG' + ',' + 
	'SWPTCLT' + ',' + 
	'FWD1' + ',' + 								
	'FWDMRG1' + ',' + 
	'FWDCLT1' + ',' + 
	'SPOT1' + ',' + 
	'SPOTMRG1' + ',' + 
	'SPOTCLT1' + ',' + 
	'SWPT1' + ',' + 
	'SWPTMRG1' + ',' + 
	'SWPTCLT1' + ',' + 
	'FWD2' + ',' + 								
	'FWDMRG2' + ',' + 
	'FWDCLT2' + ',' + 
	'SPOT2' + ',' + 
	'SPOTMRG2' + ',' + 
	'SPOTCLT2' + ',' + 
	'SWPT2' + ',' + 
	'SWPTMRG2' + ',' + 
	'SWPTCLT2' + ',' + 

	--'FWD3' + ',' + 								
	--'FWDMRG3' + ',' + 
	--'FWDCLT3' + ',' + 
	--'SPOT3' + ',' + 
	--'SPOTMRG3' + ',' + 
	--'SPOTCLT3' + ',' + 
	--'SWPT3' + ',' + 
	--'SWPTMRG3' + ',' + 
	--'SWPTCLT3' + ',' + 

	'MKT_FWD1' + ',' + 
	'MKT_FWD2' + ',' + 

	'MKT_SPOT1' + ',' + 
	'MKT_SPOT2' + ',' + 

	--MUT_BRK' + ',' + 
	--MUT_BRK_1S' + ',' + 
	--MUT_BRK_DT' + ',' + 
	--MUT_BRK_SH' + ',' + 
	'SALES_TRAD' + ',' + 
	'TIPO_SPOT' + ',' + 	
--	'VENC' + ',' + 
	--XVA_MRG' + ',' + 

	'price' + ',' + 'margin' + ',' + 'sourceSistemId' + ',' + 'sourceModule' + ',' + 
	'ourName' + ',' + 'theirName' + ',' + --'altId' + ',' + 
	'PVP_DVP' + ',' + --'JUST_VR' + ',' + 
	'tradeGlobalId' + ',' + 'IMP_USR' + ',' + 'NOMINAL2' + ',' + 'VAAMT'
UNION*/
SELECT "lineas_datos" = 
	FWD.[PRODUCTO] + ',' + 
--	FWD.[action] + ',' + 	
--	FWD.[objectNature] + ',' + 	
	FWD.[userName] + ',' + 	
	FWD.[group] + ',' + 	
--	FWD.[publishingSystem] + ',' + 	
	FWD.[Trading_date] + ',' + 	
--	FWD.[type] + ',' + 	
--	FWD.[Strategy] + ',' + 	
	FWD.[CurrencyPair_driver] + ',' + 
	FWD.[Counterpart] + ',' + 
	FWD.[BUY_SELL] + ',' + 
	FWD.[Nominal] + ',' + 
	FWD.[Nominal_unit] + ',' + 
	FWD.[PAY_DATE1] + ',' + 
	FWD.[Maturity] + ',' + 
	FWD.[VALUTA1] + ',' + 
	FWD.[Non_Deliverable] + ',' + 
--	FWD.[pf_Payment_ccy] + ',' + 
	FWD.[Portfolio] + ',' + 
	
--	FWD.[udfCharacterLabels] + ',' + 
--	FWD.[udfCharacterValues] + ',' + 
----	FWD.[udfDateLabels] + ',' + 
----	FWD.[udfDateValues] + ',' + 
--	FWD.[udfNumericLabels] + ',' +
--	FWD.[udfNumericValues] + ',' + 

	FWD.[ALLOCATED] + ',' + 
	--"BROKER_Y_N] + ',' + 
	FWD.[CANAL_CONT] + ',' + 
	FWD.[JUST_VR] + ',' + 
	FWD.[ESTRATEGIA] + ',' + 

	FWD.[FWD] + ',' + 
	FWD.[FWDMRG] + ',' + 
	FWD.[FWDCLT] + ',' + 
	FWD.[SPOT] + ',' + 
	FWD.[SPOTMRG] + ',' + 
	FWD.[SPOTCLT] + ',' + 
	FWD.[SWPT] + ',' + 
	FWD.[SWPTMRG] + ',' + 
	FWD.[SWPTCLT] + ',' + 
	FWD.[FWD1] + ',' + 
	FWD.[FWDMRG1] + ',' + 
	FWD.[FWDCLT1] + ',' + 
	FWD.[SPOT1] + ',' + 
	FWD.[SPOTMRG1] + ',' + 
	FWD.[SPOTCLT1] + ',' + 
	FWD.[SWPT1] + ',' + 
	FWD.[SWPTMRG1] + ',' + 
	FWD.[SWPTCLT1] + ',' + 

	FWD.[FWD2] + ',' + 								
	FWD.[FWDMRG2] + ',' + 
	FWD.[FWDCLT2] + ',' + 
	FWD.[SPOT2] + ',' + 
	FWD.[SPOTMRG2] + ',' + 
	FWD.[SPOTCLT2] + ',' + 
	FWD.[SWPT2] + ',' + 
	FWD.[SWPTMRG2] + ',' + 
	FWD.[SWPTCLT2] + ',' + 

	--FWD.[FWD3] + ',' + 								
	--FWD.[FWDMRG3] + ',' + 
	--FWD.[FWDCLT3] + ',' + 
	--FWD.[SPOT3] + ',' + 
	--FWD.[SPOTMRG3] + ',' + 
	--FWD.[SPOTCLT3] + ',' + 
	--FWD.[SWPT3] + ',' + 
	--FWD.[SWPTMRG3] + ',' + 
	--FWD.[SWPTCLT3] + ',' + 

	FWD.[MKT_FWD1] + ',' + 
	FWD.[MKT_FWD2] + ',' + 
	FWD.[MKT_SPOT1] + ',' + 
	FWD.[MKT_SPOT2] + ',' + 

	--FWD.[MUT_BRK] + ',' + 
	--FWD.[MUT_BRK_1S] + ',' + 
	--FWD.[MUT_BRK_DT] + ',' + 
	--FWD.[MUT_BRK_SH] + ',' + 

	FWD.[SALES_TRAD] + ',' + 
	FWD.[TIPO_SPOT] + ',' + 	

--	FWD.[VENC] + ',' + 
--FWD.[XVA_MRG] + ',' + 

	FWD.[price] + ',' +
	FWD.[margin] + ',' + 
	FWD.[sourceSistemId] + ',' + 
	FWD.[sourceModule] + ',' + 
	FWD.[ourName] + ',' + 
	FWD.[theirName] + ',' + 
--	FWD.[altId] + ',' + 
	FWD.[PVP_DVP] + ',' + 
--	FWD.[JUST_VR] + ',' + 
	FWD.[tradeGlobalId] + ',' + 
	--FWD.[IMP_USR] + ',' + 
	FWD.[NOMINAL2] + ',' + 
	FWD.[VAAMT]
FROM 
	#pasoForward AS FWD
ORDER BY 1 DESC

select 'aaaaaaaa',*
FROM 
	#pasoForward AS FWD
ORDER BY 1 DESC

--exec reportes.dbo.FWD_D_CROSS_FW_DELIVERY
--linea de encabezado --
--INSERT INTO #pasoContraparte

--select '@conDetalle',@conDetalle


	IF @conDetalle IN('SI', 'ALL') 
		SELECT * FROM #pasoForward --WHERE tradeGlobalId = 618374

	IF @conDetalle IN('RES', 'ALL') 
		SELECT 
			"Cliente" = SP.Counterpart,
			"TotalRegxCliBuy" = CASE WHEN sp.BUY_SELL = 'buy' THEN COUNT(1) ELSE 0 END,
			"TotalRegxCliSell" = CASE WHEN sp.BUY_SELL = 'Sell' THEN COUNT(1) ELSE 0 END --,
		INTO
			#pasoTotalCuadratura
		FROM #pasoForward AS SP
		GROUP BY SP.Counterpart, sp.BUY_SELL
	
	IF @conDetalle IN('RES', 'ALL') 
		SELECT 
				Cliente,
				"TotalRegxCliBuy" = SUM(TotalRegxCliBuy),
				"TotalRegxCliSell" = SUM(TotalRegxCliSell),
				"TotalRegxCli" = SUM(TotalRegxCliBuy) + SUM(TotalRegxCliSell) 
		FROM #pasoTotalCuadratura AS TC 
		GROUP BY Cliente
		ORDER BY 1

	IF @conDetalle IN('RES', 'ALL') 	
		SELECT
			"Total Registros" = @TotalReg


END 
GO
