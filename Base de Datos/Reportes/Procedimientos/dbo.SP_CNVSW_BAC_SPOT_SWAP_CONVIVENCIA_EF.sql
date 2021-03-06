USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNVSW_BAC_SPOT_SWAP_CONVIVENCIA_EF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_HELPTEXT SP_CNVSW_BAC_SPOT_SWAP_CONVIVENCIA_EF
CREATE  PROCEDURE [dbo].[SP_CNVSW_BAC_SPOT_SWAP_CONVIVENCIA_EF]AS BEGIN 	SET NOCOUNT ON 	SET DATEFORMAT DMY 	DECLARE @SEP  VARCHAR(1)    SET @SEP  = ','	DECLARE @ConDetalle VARCHAR(1) 
   SET @ConDetalle = 'N'			--en producción mantener valor 'N'

	DECLARE @Fecha datetime
	SELECT @Fecha = fechaproc FROM BacSwapSuda.dbo.SwapGeneral	
	--SET @Fecha = '20200609'			-- en caso de prueba
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
			[Contraparte]	VARCHAR(100), 
			[Producto]		VARCHAR(40)		)         	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512	CREATE TABLE #Spot_Swap_Conv_SALIDA	(		[global_ID]		INT,		--PARA COMPATIBILIDAD DE SALIDA		REG_SALIDA		Varchar(1000))	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512-------------------- TRADER MUREX --------------------
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
											--	OM3.[USER ID ITAU] = U.USUARIO
											FROM BacParamSuda..USUARIO AS U INNER JOIN BacParamSuda..USUARIO AS OM3 on
												OM3.RutUsuario = U.RutUsuario
											WHERE
												U.[RutUsuario] = OB.RutUsuario AND
												LTRIM(U.usuario_original)  = '' AND
												--U.USUARIO <> OB.usuario --AND
												--U.USUARIO = OM.[USER ID ITAU]
												LEFT(U.USUARIO, 1) = 'C'
											ORDER BY U.USUARIO DESC)
										--ELSE
										END,
			"TRADER ES VALIDO EN MUREX" = CASE WHEN EXISTS (SELECT 1 FROM BACPARAMSUDA..TBL_CNV_USER_MUREX AS OM2 						
																	WHERE OM2.[USER ID ITAU] = 
																				CASE WHEN OM.[USER ID ITAU] = OB.usuario THEN
																						OM.[USER ID ITAU] 
																				ELSE
																					(SELECT TOP 1 U.USUARIO 
																					FROM BacParamSuda..USUARIO AS U INNER JOIN BACPARAMSUDA..TBL_CNV_USER_MUREX AS OM3 on
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
   FROM #tmpOperBAC AS OB LEFT JOIN BACPARAMSUDA..TBL_CNV_USER_MUREX AS OM ON   
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

---			Definición de tabla DE/PARA - FIN		---
-------------------- TRADER MUREX --------------------

	--	DE/PARA - Estado Compra-Venta
	SELECT "mu_buySell" = 'Buy', "Cod_BAC" = 'C' INTO #PasobuySell UNION
	SELECT "mu_buySell" = 'Sell', "Cod_BAC" = 'V' 
	--SELECT * FROM #PasobuySell
 ----	DE/PARA - Estrategia
	SELECT "mu_Estrategia" = 'Negociacion', "Cod_BAC" = 'T' INTO #PasoEstrategia UNION
	SELECT "mu_Estrategia" = 'Cobertura', "Cod_BAC" = 'C'
	--SELECT * FROM #PasoEstrategia
	INSERT INTO #Spot_Swap_Conv	SELECT  
		"global_ID"		= Caj.Numero_Operacion ,
		--"Trader"			= ISNULL(T.[TRADER A INFORMAR], CAST(CajRes.Operador AS VARCHAR(20))),	--CajRes.Operador,
		"Trader"			= ISNULL(T.[TRADER A INFORMAR], ISNULL((SELECT Operador FROM BACPARAMSUDA..TBL_CNV_USUITAU_X_OPERACION 
																				WHERE TipOper = 'SWP' AND 
																						NumOper = Caj.Numero_Operacion),CAST(CajRes.Operador AS VARCHAR(20)))),	--CajRes.Operador,
		"F. Inicio Operacion"	= CONVERT(VARCHAR(10), ISNULL((select top 1 fecha_cierre from BacSwapSuda..cartera where numero_operacion = Caj.Numero_Operacion), '19000101'), 103),
		"Sales/Trading" = CASE WHEN cl.Cltipcli in(1, 2) THEN 'Trading' ELSE 'Sales' END,	--CajRes.Operador,
		"Estrategia" = ISNULL(E.mu_Estrategia, E.Cod_BAC),
		"Rut Contraparte" = CAST(CajRes.Rut_Contraparte AS VARCHAR(10)) + '-' + cl.cldv,
		"Canal Contratacion" = 'Spot Convivencia EF BAC',
		"Compra/Venta" = BS.MU_buySell,
		"Fecha vencimiento" = RTRIM(CONVERT(CHAR(10), CajRes.fecha_vence_flujo, 103)),
		"Fecha Liquidacion" = RTRIM(CONVERT(CHAR(10), Caj.FechaLiquidacion, 103)),
		"Precio (T/C)" = Caj.ValorMdaPagoCLP,	--	Caj.ValorUSDCLP,
		"Nominal USD" = CAST(ROUND(ROUND(CAST(ABS(Caj.MontoM1 ) AS FLOAT),3), 2,0) AS NUMERIC(20, 2)),
		"Monto CLP" = ABS( Caj.MontoM1Local),
		"Contraparte" = cl.clnombre,
		"Producto" = 	CASE WHEN Caj.Producto = 1 THEN 'IRS'
								WHEN Caj.Producto = 2 THEN 'CCS'
								WHEN Caj.Producto = 3 THEN	'FR'
								WHEN Caj.Producto = 4 THEN 'IRS'	--PROM. CAMARA'
							END						
	FROM   BacParamSuda..TBL_CAJA_DERIVADOS_DETALLE Caj	
       inner join BacParamSuda..TBL_CAJA_DERIVADOS CajRes	ON CajRes.Modulo = 'PCS' 
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
		LEFT  JOIN BACPARAMSUDA..CLIENTE AS CL ON
			cl.clrut = CajRes.Rut_Contraparte AND
			cl.clcodigo = CajRes.Codigo_Contraparte  
		LEFT JOIN #TRADER_MUREX AS T ON
				T.[COD. OPER. BAC] = CajRes.Operador
		LEFT JOIN #PasobuySell AS BS ON
			BS.cod_bac = CASE WHEN Caj.MontoM1 > 0 THEN 'C' ELSE 'V' END
		LEFT JOIN #PasoEstrategia AS E ON
			E.cod_bac = (SELECT DISTINCT car_Cartera_Normativa 
							FROM BacSwapSuda..Cartera
							WHERE NUMERO_OPERACION = Caj.Numero_operacion) 
	WHERE Caj.fechaLiquidacion = @Fecha
			AND caj.Modulo = 'PCS'
			AND CajRes.Modalidad_Pago = 'E' 
			AND isnull( Vcto.Estado, 0 ) = 0			  
			AND Caj.MontoM1 <> 0
	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	 INSERT INTO #Spot_Swap_Conv_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512             SELECT     "global_ID" = global_ID,		--PARA COMPATIBILIDAD DE SALIDA	 "REG_SALIDA" = 
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
								'Producto'	SELECT REG_SALIDA FROM #Spot_Swap_Conv_SALIDA 	ORDER BY global_ID	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512      	IF @ConDetalle = 'S'		--solo para pruebas
		SELECT * FROM #Spot_Swap_Conv

	DROP TABLE #Spot_Swap_Conv	DROP TABLE #Spot_Swap_Conv_SALIDAEND --ROLLBACK TRAN--GRANT EXECUTE ON DBO.SP_CNVSW_BAC_SPOT_SWAP_CONVIVENCIA_EF TO GRP_BACTRADER

GO
