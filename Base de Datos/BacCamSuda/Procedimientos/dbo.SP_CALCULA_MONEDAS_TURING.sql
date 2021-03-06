USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_MONEDAS_TURING]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CALCULA_MONEDAS_TURING]
	(	@Id_Moneda			INT
	,	@Tipo_Movimiento	CHAR(1)
	,	@Monto				NUMERIC(9) 
	,	@nPerfilComercial	INT
	)	
AS
BEGIN

	--************************************************************************************
	--Procedimiento que calcula t.cambio y paridad dependiendo de moneda, rango de costo *
	--y monto																			 * 
	--************************************************************************************		

	SET NOCOUNT ON
   Declare @clsifica_moneda char(1)
    --Se claifica si es moneda fuerte o debil
        select @clsifica_moneda = mnrrda from BACparAMSUDA..moneda where mncodmon = @id_moneda
   
   -->   Se incluye para realizar el filtro respecto al Origen. El cual se maneja en codificacion discordante entre la tabla de Comex y Origenes
   -->   SELECT * FROM BACPARAMSUDA..TABLA_GENERAL_DETALLE WHERE TBCATEG = 8602 --> Caraga Clase Ejecutivos
   -->   SELECT * FROM BACPARAMSUDA..TABLA_GENERAL_DETALLE WHERE tbcateg = 2700 --> Caraga Origenes
    SET @nPerfilComercial = CASE WHEN @nPerfilComercial = 0  THEN 2   --> EJECUTIVO INTERNACIONAL    --> COMEX
								WHEN @nPerfilComercial = 8  THEN 2   --> EJECUTIVO INTERNACIONAL    --> COMEX
								WHEN @nPerfilComercial = 13 THEN 3   --> EJECUTIVO GRANDES EMPRESAS --> GGEE
								WHEN @nPerfilComercial = 14 THEN 4   --> ESPECIALISTA COMEX         --> ECOMEX
								ELSE							 1   --> NO APLICA                  --> ''
							END

	DECLARE @dFechaProceso	DATETIME
		SET @dFechaProceso	= ( SELECT acfecpro FROM MEAC with(nolock) ) 

 if @clsifica_moneda='M'
 begin
	SELECT  'CostoCal'				= CASE WHEN @Tipo_Movimiento = 'C' THEN costo_compra - spread_compra - spread_trading_compra
									   ELSE								costo_venta  + Spread_Venta  + spread_trading_venta
								  END
		,	'Costo'				= CASE WHEN @Tipo_Movimiento = 'C' THEN costo_compra			ELSE costo_venta			END
		,	'Spread'			= CASE WHEN @Tipo_Movimiento = 'C' THEN spread_compra			ELSE Spread_Venta			END
		,	'Spread_Trading'	= CASE WHEN @Tipo_Movimiento = 'C' THEN spread_trading_compra	ELSE spread_trading_venta	END
		,	'MontoMax'			= Montomax
	FROM	COSTOS_COMEX  
	WHERE	Fecha				= @dFechaProceso
	AND		Perfil_Comercial	= @nPerfilComercial
	AND		Codmoneda			= @Id_Moneda
	AND		@Monto				BETWEEN entre_desde AND entre_hasta
 end

if @clsifica_moneda='D'
 begin
	SELECT  'CostoCal'				= CASE WHEN @Tipo_Movimiento = 'C' THEN costo_compra + spread_compra + spread_trading_compra
									   ELSE								costo_venta  - Spread_Venta  - spread_trading_venta
								  END
		,	'Costo'				= CASE WHEN @Tipo_Movimiento = 'C' THEN costo_compra			ELSE costo_venta			END
		,	'Spread'			= CASE WHEN @Tipo_Movimiento = 'C' THEN spread_compra			ELSE Spread_Venta			END
		,	'Spread_Trading'	= CASE WHEN @Tipo_Movimiento = 'C' THEN spread_trading_compra	ELSE spread_trading_venta	END
		,	'MontoMax'			= Montomax
	FROM	COSTOS_COMEX  
	WHERE	Fecha				= @dFechaProceso
	AND		Perfil_Comercial	= @nPerfilComercial
	AND		Codmoneda			= @Id_Moneda
	AND		@Monto				BETWEEN entre_desde AND entre_hasta
 end


RETURN

	IF  @tipo_movimiento= 'V'   
		SELECT Costo_Venta + Spread_Venta + Spread_Trading_Venta  as 'Paridad',	
				 Costo_Venta,
				 Spread_Venta,  
				 Spread_Trading_Venta,
				 Montomax  
		  FROM  COSTOS_COMEX  
		  WHERE Codmoneda  = @id_moneda
		  AND   @monto     BETWEEN Entre_Desde AND Entre_Hasta
     
	IF  @tipo_movimiento= 'C'   
		SELECT Costo_COMPRA - Spread_Compra - Spread_Trading_Compra  as 'Transferencia',
				 Costo_Compra,
				 Spread_Compra,  
				 Spread_Trading_Compra,
				 Montomax
		  FROM   COSTOS_COMEX  
		  WHERE  Codmoneda  = @id_moneda
		  AND    @monto     BETWEEN Entre_Desde AND Entre_Hasta	
END

GO
