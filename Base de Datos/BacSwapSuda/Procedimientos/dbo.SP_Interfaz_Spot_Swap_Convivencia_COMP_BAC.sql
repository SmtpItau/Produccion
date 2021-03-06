USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_Interfaz_Spot_Swap_Convivencia_COMP_BAC]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext 'dbo.SP_Interfaz_Spot_Swap_Convivencia_COMP_BAC'

CREATE PROCEDURE [dbo].[SP_Interfaz_Spot_Swap_Convivencia_COMP_BAC]AS BEGIN 	SET NOCOUNT ON 	SET DATEFORMAT DMY 	DECLARE @SEP  VARCHAR(1)    SET @SEP  = ','	DECLARE @conDetalle  VARCHAR(1)    SET @conDetalle  = 'N'				--en produccion mantener valor 'N'	DECLARE @Fecha datetime
	SELECT @Fecha = CONVERT(DATETIME, fechaproc, 112)  FROM BacSwapSuda.dbo.SwapGeneral	
--	SET @Fecha = '20200522'		--SOLO PARA PRUEBA
	CREATE TABLE #Spot_Swap_Conv		 ( [global_ID]		INT, 
			[Trader]			VARCHAR(40), 
			[F. Inicio Operacion]	VARCHAR(40), 
			[Sales/Trading]	VARCHAR(40), 
			[Estrategia]		VARCHAR(40), 
			[Rut Contraparte] VARCHAR(40), 
			[Canal Contratacion] VARCHAR(40), 
			[Compra/Venta]			VARCHAR(40), 
			[Fecha vencimiento]	VARCHAR(40), 
			[Fecha Liquidacion]	VARCHAR(40), 
			[Precio (T/C)] VARCHAR(40), 
			[Nominal USD]	VARCHAR(40), 
			[Monto CLP]		VARCHAR(40), 
			[Contraparte]	VARCHAR(60), 
			[Producto]		VARCHAR(40)		)         	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512	CREATE TABLE #Spot_Swap_Conv_SALIDA	(		[global_ID]		INT,		--PARA COMPATIBILIDAD DE SALIDA		REG_SALIDA		Varchar(2000))	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512-------------------- TRADER MUREX --------------------
--				Definición de tabla DE/PARA - INI
	DECLARE @totalUM AS INTEGER
	DECLARE @totalUB AS INTEGER

	
	SELECT "TRADER_BAC" = 'CRAMIREZ', "TRADER_ITAU" = 'CCRP5440' INTO #tmpRelTrader UNION 
	SELECT "TRADER_BAC" = 'Pvillena', "TRADER_ITAU" = 'CPVP8594' UNION 
	SELECT "TRADER_BAC" = 'RFLORES', "TRADER_ITAU" = 'CRFV0022'


	SELECT DISTINCT 
	--	"OPERACIONES" = 'SWP',	
		U.usuario,
		U.nombre,	
		U.tipo_usuario	,
		U.fecha_expira	,
		U.RutUsuario,	
		U.usuario_original
	INTO #tmpOperBAC 			
	FROM BacParamSuda..USUARIO AS U	
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
											--FROM BacParamSuda..USUARIO AS U INNER JOIN BACPARAMSUDA..TBL_CNV_USER_MUREX AS OM3 on
												--OM3.[USER ID ITAU] = U.USUARIO
											FROM BacParamSuda..USUARIO AS U INNER JOIN BacParamSuda..USUARIO AS OM3 on
												OM3.RutUsuario = U.RutUsuario
											WHERE
												U.[RutUsuario] = OB.RutUsuario AND
												LTRIM(U.usuario_original)  = ''
												--U.USUARIO <> OB.usuario --AND
												--U.USUARIO = OM.[USER ID ITAU]
												--LEFT(U.USUARIO, 1) = 'C'
											ORDER BY U.USUARIO DESC)
										--ELSE
										END,
			"TRADER ES VALIDO EN MUREX" = CASE WHEN EXISTS (SELECT 1 FROM BACPARAMSUDA..TBL_CNV_USER_MUREX AS OM2 						
																	WHERE OM2.[USER ID ITAU] = 
																				CASE WHEN OM.[USER ID ITAU] = OB.usuario THEN
																						OM.[USER ID ITAU] 
																				ELSE
																					(SELECT TOP 1 U.USUARIO 
																					--FROM BacParamSuda..USUARIO AS U INNER JOIN BacParamSuda..USUARIO AS OM3 on
																					--	OM3.[USER ID ITAU] = U.USUARIO
																					FROM BacParamSuda..USUARIO AS U INNER JOIN BacParamSuda..USUARIO AS OM3 on
																						OM3.RutUsuario = U.RutUsuario
																					WHERE
																						U.[RutUsuario] = OB.RutUsuario AND
																						LTRIM(U.usuario_original)  = ''
																						--U.USUARIO <> OB.usuario --AND
																						--U.USUARIO = OM.[USER ID ITAU]
																						--LEFT(U.USUARIO, 1) = 'C'
																					ORDER BY U.USUARIO DESC, U.usuario_original)

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
   FROM #tmpOperBAC AS OB LEFT JOIN BACPARAMSUDA..TBL_CNV_USER_MUREX AS OM ON   
				OB.usuario = OM.[USER ID ITAU]
--	WHERE 
--		OM.[USER ID ITAU] IS NULL
	ORDER BY
		NOMBRE

--select * from #RESULTADO

	SELECT 
		--R.OPERACIONES,
		R.[COD. OPER. BAC], 
--		R.[ES VALIDO EN MUREX], 
		"TRADER A INFORMAR" = RTRIM(LTRIM(CASE WHEN R.[TRADER A INFORMAR] IS NULL THEN 
										(SELECT RT.TRADER_ITAU FROM BACPARAMSUDA..TBL_CNV_USER_MUREX AS M INNER JOIN #tmpRelTrader AS RT ON
												M.[USER ID ITAU] = RT.TRADER_ITAU
										WHERE
												RT.TRADER_BAC = R.[COD. OPER. BAC])
									ELSE 
										R.[TRADER A INFORMAR] 
									END)), 
		--"TRADER ES VALIDO EN MUREX" = CASE WHEN R.[TRADER A INFORMAR] IS NULL THEN 
		--										(SELECT CASE WHEN RT.TRADER_ITAU IS NULL THEN 'NO' ELSE 'SI' END 
		--										FROM #tmpUsuariosMUREX AS M INNER JOIN #tmpRelTrader AS RT ON
		--												M.[USER ID ITAU] = RT.TRADER_ITAU
		--										WHERE
		--												RT.TRADER_BAC = R.[COD. OPER. BAC])
		--									ELSE 
		--										R.[TRADER ES VALIDO EN MUREX]
		--									END, 		
		R.[nombre] 
		--R.[tipo_usuario], 
		--R.[fecha_expira], 
		--R.[RutUsuario], 
		--R.[usuario_original]
	INTO #TRADER_MUREX
	FROM #RESULTADO AS R LEFT JOIN BACPARAMSUDA..TBL_CNV_USER_MUREX AS OM ON	
				R.[TRADER A INFORMAR] = OM.[USER ID ITAU]

--select * from #TRADER_MUREX
---			Definición de tabla DE/PARA - FIN		---
-------------------- TRADER MUREX --------------------

	--	DE/PARA - Estado Compra-Venta
	SELECT "mu_buySell" = 'Buy', "Cod_BAC" = 'C' INTO #PasobuySell UNION
	SELECT "mu_buySell" = 'Sell', "Cod_BAC" = 'V' 
	--SELECT * FROM #PasobuySell
   ----	DE/PARA - Sales-Trading
	SELECT "mu_SalesTrading" = 'Trading', "Cod_BAC" = 4 INTO #PasoSalesTrading UNION
	SELECT "mu_SalesTrading" = 'Sales', "Cod_BAC" = 0
	--SELECT * FROM #PasoSalesTrading

   ----	DE/PARA - Estrategia
	SELECT "mu_Estrategia" = 'Negociacion', "Cod_BAC" = 'T' INTO #PasoEstrategia UNION
	SELECT "mu_Estrategia" = 'Cobertura', "Cod_BAC" = 'C'
	--SELECT * FROM #PasoEstrategia
		--*** IRS ***	INSERT INTO #Spot_Swap_Conv	SELECT  distinct
		"global_ID"		= Caj.Numero_Operacion ,
		"Trader"			= ISNULL(T.[TRADER A INFORMAR], ISNULL((SELECT Operador FROM BACPARAMSUDA..TBL_CNV_USUITAU_X_OPERACION 
																				WHERE TipOper = 'SWP' AND 
																						NumOper = Caj.Numero_Operacion), CajRes.Operador)),			
		"F. Inicio Operacion" = CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 fecha_cierre FROM BacSwapSuda..cartera where numero_operacion = Caj.Numero_Operacion), '19000101'), 103),
		"Sales/Trading" = ST.mu_SalesTrading , 
		"Estrategia" = E.mu_Estrategia,	
		"Rut Contraparte" = CAST(CajRes.Rut_Contraparte AS VARCHAR(10)) + '-' + cl.cldv,
		"Canal Contratacion" = 'Spot Convivencia ND BAC',
		"Compra/Venta" = isnull(BS.MU_buySell, ''),
		"Fecha vencimiento" = RTRIM(CONVERT(CHAR(10), ISNULL(CajRes.fecha_vence_flujo, '19000101'), 103)),
		"Fecha Liquidacion" = RTRIM(CONVERT(CHAR(10), ISNULL(Caj.FechaLiquidacion, '19000101'), 103)),
		"Precio (T/C)" = ISNULL(Caj.ValorUSDCLP, 0),
		"Nominal USD" = CAST(ROUND(ROUND(CAST(ABS(CajRes.MontoM1) AS FLOAT),3), 2,0) AS NUMERIC(20, 2)),
		"Monto CLP" = ABS( ISNULL(CajRes.MontoM1Local, 0)),
		"Contraparte" = ISNULL(cl.clnombre, ''),
		"Producto" = 	CASE WHEN Caj.Producto = 1 THEN 'IRS'
								WHEN Caj.Producto = 2 THEN 'CCS'
								WHEN Caj.Producto = 3 THEN	'FR'
								WHEN Caj.Producto = 4 THEN 'IRS'	--PROM. CAMARA'
							END							
	FROM   BacParamSuda..TBL_CAJA_DERIVADOS_DETALLE Caj	
       left join BacParamSuda..TBL_CAJA_DERIVADOS CajRes	on CajRes.Modulo = 'PCS' 
	                                and CajRes.NUmero_operacion =  Caj.Numero_operacion 
									and cajRes.fechaLiquidacion = Caj.fechaLiquidacion	
									and CajRes.MonedaM1 = Caj.MonedaM1	        
      LEFT JOIN BacParamSuda..Moneda  Mda1 on Mda1.mncodmon = Caj.MonedaM1 
	   LEFT JOIN BacSwapSuda..FLUJOS_VCTOS_SPOT Vcto on 
							Vcto.NumeroOperacion = Caj.Numero_Operacion AND 
							Vcto.FechaLiq = Caj.fechaLiquidacion
		LEFT JOIN BacParamSuda..MONEDA Mda     ON Mda.mncodmon    = Caj.MonedaM1
		LEFT JOIN BacParamSuda..MONEDA MdaCnv  ON MdaCnv.mncodmon = CajRes.MonedaM2
				   
      LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO Entre  ON 
				Entre.codigo = case when caj.MontoM1 > 0 then cajRes.formaPago2 else cajRes.formaPago1 end
         
		LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO Recib  ON 
				Recib.codigo = case when caj.MontoM1 > 0 then cajRes.formaPago1 else cajRes.formaPago2 end                     
		LEFT JOIN #TRADER_MUREX AS T ON
				T.[COD. OPER. BAC] = CajRes.Operador
		LEFT  JOIN BACPARAMSUDA..CLIENTE AS CL ON
			cl.clrut = CajRes.Rut_Contraparte AND
			cl.clcodigo = CajRes.Codigo_Contraparte  
		LEFT JOIN #PasobuySell AS BS ON
			BS.cod_bac = CASE WHEN CajRes.MontoM1 > 1 THEN 'C' ELSE 'V' END
		LEFT JOIN #PasoSalesTrading AS ST ON
			ST.cod_bac = CASE WHEN (SELECT DISTINCT car_SubCartera_Normativa 
												FROM dbo.Cartera
												WHERE NUMERO_OPERACION = Caj.Numero_operacion) = 4 THEN 4
								ELSE 0 END
		LEFT JOIN #PasoEstrategia AS E ON
			E.cod_bac = (SELECT DISTINCT car_Cartera_Normativa 
							FROM dbo.Cartera
							WHERE NUMERO_OPERACION = Caj.Numero_operacion) 
	WHERE (Caj.fechaLiquidacion = @Fecha or fecha_Vence_Flujo = @Fecha) 
			AND caj.Modulo = 'PCS'
			AND CajRes.Modalidad_Pago = 'C' 
			AND isnull( Vcto.Estado, 0 ) = 0			  
			AND CajRes.MontoM1 <> 0
--			AND Caj.Producto in(1, 2)
			AND (Cajres.MonedaM1 = 13)
--and Cajres.Numero_Operacion = 8898
--AND (Caj.MonedaM1 NOT IN(999, 998))
--AND (Caj.MonedaM1 not in(999, 998) or Caj.MonedaM2 not in(999, 998))

--		AND Caj.MontoM1 <> 0

IF @conDetalle = 'S'
	SELECT 'pago USD' = Caj.MontoM1, 
		 'pago clp' = Caj.MontoM1Local, 
		 'pago USD2' = CajRes.MontoM1,
		 'pago clp2' = CajRes.MontoM1Local,
		 Vcto.Estado,
		 Caj.*, CajRes.*
	FROM   BacParamSuda..TBL_CAJA_DERIVADOS_DETALLE Caj	
       left join BacParamSuda..TBL_CAJA_DERIVADOS CajRes	on CajRes.Modulo = 'PCS' 
	                                and CajRes.NUmero_operacion =  Caj.Numero_operacion 
									and cajRes.fechaLiquidacion = Caj.fechaLiquidacion	
									and CajRes.MonedaM1 = Caj.MonedaM1	        
      LEFT JOIN BacParamSuda..Moneda  Mda1 on Mda1.mncodmon = Caj.MonedaM1 
	   LEFT JOIN BacSwapSuda..FLUJOS_VCTOS_SPOT Vcto on 
							Vcto.NumeroOperacion = Caj.Numero_Operacion AND 
							Vcto.FechaLiq = Caj.fechaLiquidacion
		LEFT JOIN BacParamSuda..MONEDA Mda     ON Mda.mncodmon    = Caj.MonedaM1
		LEFT JOIN BacParamSuda..MONEDA MdaCnv  ON MdaCnv.mncodmon = CajRes.MonedaM2
				   
      LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO Entre  ON 
				Entre.codigo = case when caj.MontoM1 > 0 then cajRes.formaPago2 else cajRes.formaPago1 end
		LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO Recib  ON 
				Recib.codigo = case when caj.MontoM1 > 0 then cajRes.formaPago1 else cajRes.formaPago2 end                     
		LEFT JOIN #TRADER_MUREX AS T ON
				T.[COD. OPER. BAC] = CajRes.Operador
		LEFT  JOIN BACPARAMSUDA..CLIENTE AS CL ON
			cl.clrut = CajRes.Rut_Contraparte AND
			cl.clcodigo = CajRes.Codigo_Contraparte  
		LEFT JOIN #PasobuySell AS BS ON
			BS.cod_bac = CASE WHEN Caj.MontoM1 > 0 THEN 'C' ELSE 'V' END
	WHERE 
			(Caj.fechaLiquidacion = @Fecha or fecha_Vence_Flujo = @Fecha) 
			AND caj.Modulo = 'PCS'
			AND CajRes.Modalidad_Pago = 'C' 
			AND ISNULL( Vcto.Estado, 0 ) = 0			  
			AND CajRes.MontoM1 <> 0
	 --and -- CajRes.numero_operacion in(10178)
			AND Caj.Producto IN(1, 2)
			AND (Cajres.MonedaM1 = 13)
	ORDER BY Caj.NUMERO_OPERACION

--SELECT * FROM #Spot_Swap_Conv
	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	 INSERT INTO #Spot_Swap_Conv_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512             SELECT 
    "global_ID" = global_ID,		--PARA COMPATIBILIDAD DE SALIDA	 "REG_SALIDA" = 
			RTRIM(LTRIM(global_ID)) + @SEP + 
			RTRIM(LTRIM([Trader])) + @SEP + 
			RTRIM(LTRIM([F. Inicio Operacion])) + @SEP + 
			RTRIM(LTRIM([Sales/Trading])) + @SEP + 
			RTRIM(LTRIM([Estrategia])) + @SEP + 
			RTRIM(LTRIM([Rut Contraparte])) + @SEP + 
			RTRIM(LTRIM([Canal Contratacion])) + @SEP + 
			RTRIM(LTRIM([Compra/Venta])) + @SEP + 
			RTRIM(LTRIM([Fecha vencimiento])) + @SEP + 
			RTRIM(LTRIM([Fecha Liquidacion])) + @SEP + 
			RTRIM(LTRIM([Precio (T/C)])) + @SEP + 
			RTRIM(LTRIM([Nominal USD])) + @SEP + 
			RTRIM(LTRIM([Monto CLP])) + @SEP + 
			RTRIM(LTRIM([Contraparte])) + @SEP + 
			RTRIM(LTRIM([Producto])) 	FROM #Spot_Swap_Conv      --ORDER BY SD_ID, INS_ID, CF_FLOW		-- PLL-20200512- NO ES NECESARIO EN ESTE INSERT      	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512	INSERT INTO #Spot_Swap_Conv_SALIDA		SELECT 			global_ID = 0,		--PARA COMPATIBILIDAD DE SALIDA			"REG_SALIDA" = 'global_ID' + @SEP + 
								'Trader' + @SEP + 
								'F. Inicio Operacion' + @SEP + 
								'Sales/Trading' + @SEP + 
								'Estrategia' + @SEP + 
								'Rut Contraparte' + @SEP + 
								'Canal Contratacion' + @SEP + 
								'Compra/Venta' + @SEP + 
								'Fecha vencimiento' + @SEP + 
								'Fecha Liquidacion' + @SEP + 
								'Precio (T/C)' + @SEP + 
								'Nominal USD' + @SEP + 
								'Monto CLP' + @SEP + 
								'Contraparte' + @SEP + 
								'Producto'	SELECT REG_SALIDA FROM #Spot_Swap_Conv_SALIDA 	ORDER BY global_ID	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512      	DROP TABLE #Spot_Swap_Conv	DROP TABLE #Spot_Swap_Conv_SALIDAEND --ROLLBACK TRAN
--GRANT EXECUTE ON SP_Interfaz_Spot_Swap_Convivencia_COMP_BAC TO GRP_BACTRADER



GO
