USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S007_Query_Resultado_C_SWAP]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_S007_Query_Resultado_C_SWAP]
(
    @FechaDesde        DATETIME,
    @FechaHasta        DATETIME,
    @dFechaProceso     DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;
	
	CREATE TABLE #RESULTADOS_MESA
	(
		Modulo                CHAR(3),
		Producto              VARCHAR(50),
		Numero_Operacion      NUMERIC(9),
		Documento             NUMERIC(9),
		Correlativo           NUMERIC(21, 4),
		Serie                 VARCHAR(20),
		RutCliente            NUMERIC(12),
		CodCliente            INT,
		DvCliente             CHAR(1),
		NombreCliente         VARCHAR(150),
		TipoOperacion         VARCHAR(25),
		Monto                 NUMERIC(21, 4),
		MonTransada           CHAR(3),
		MonConversion         CHAR(3),
		TCCierre              NUMERIC(21, 4),
		TCCosto               NUMERIC(21, 4),
		ParidadCierre         NUMERIC(21, 4),
		ParidadCosto          NUMERIC(21, 4),
		MontoPesos            NUMERIC(21, 4),
		Operador              VARCHAR(15),
		MontoDolares          NUMERIC(21, 4),
		ResultadoMesa         NUMERIC(21, 4),
		Fecha                 DATETIME --> CHAR(10)
		,
		Relacionado           VARCHAR(35),
		FolioRelacionado      NUMERIC(9),
		FechaEmision          DATETIME,
		FechaVencimiento      DATETIME,
		SegmentoComercial     INT
	)
	
	CREATE INDEX #ix_orden ON #RESULTADOS_MESA(
	    fecha,
	    Modulo,
	    Producto,
	    RutCliente,
	    CodCliente,
	    Numero_Operacion,
	    Documento,
	    Correlativo
	)
	
	
	IF (@FechaDesde = @FechaHasta AND @dFechaProceso = @FechaDesde)
	BEGIN
	    ---swap diario
	    INSERT INTO #RESULTADOS_MESA
	    SELECT Modulo = 'PCS',
	           Producto              = CASE 
	                           WHEN mvto.tipo_swap = 1 THEN 'SWAP DE TASAS'
	                           WHEN mvto.tipo_swap = 2 THEN 'SWAP DE MONEDAS'
	                           WHEN mvto.tipo_swap = 3 THEN 
	                                'FORWARD RATE AGREETMEN'
	                           WHEN mvto.tipo_swap = 4 THEN 
	                                'SWAP PROMEDIO CAMARA'
	                      END,
	           Numero_Operacion      = mvto.numero_operacion,
	           Documento             = 0,
	           Correlativo           = 0,
	           Serie                 = '',
	           RutCliente            = clie.clrut,
	           CodCliente            = clie.clcodigo,
	           DvCliente             = clie.cldv,
	           NombreCliente         = clie.clnombre,
	           TipoOperacion         = 'C',
	           Monto                 = mvto.compra_capital,
	           MonTransada           = mon1.mnnemo,
	           MonConversion         = mon2.mnnemo,
	           TCCierre              = mvto.compra_valor_tasa,
	           TCCosto               = mvto.Tasa_Transfer,
	           ParidadCierre         = vent.venta_valor_tasa,
	           ParidadCosto          = vent.Tasa_Transfer,
	           MontoPesos            = vent.venta_capital,
	           Operador              = mvto.operador,
	           MontoDolares          = dbo.fn_Monto_Conversion_Moneda (mvto.compra_capital, mon1.mnnemo, mon2.mnnemo, DEFAULT) --PM Función 0
	           ,
	           ResultadoMesa         = mvto.Res_Mesa_Dist_CLP,
	           Fecha                 = mvto.fecha_cierre --> CONVERT(CHAR(10), mvto.fecha_cierre, 103)
	           ,
	           Relacionado           = '--',
	           FolioRelacionado      = 0,
	           FechaEmision          = vent.fecha_inicio,
	           FechaVencimiento      = vent.fecha_termino,
	           SegmentoComercial     = clie.Seg_Comercial
	    FROM   BacSwapSuda.dbo.MOVDIARIO mvto
	           INNER JOIN BacSwapSuda.dbo.MOVDIARIO vent
	                ON  vent.numero_operacion = mvto.numero_operacion
	                AND vent.numero_flujo = mvto.numero_flujo
	                AND vent.tipo_flujo = 2
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.rut_cliente
	                AND clie.clcodigo = mvto.codigo_cliente
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon1
	                ON  mon1.mncodmon = mvto.compra_moneda
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon2
	                ON  mon2.mncodmon = vent.venta_moneda
	    WHERE  mvto.estado <> 'C'
	           AND mvto.fecha_cierre BETWEEN @FechaDesde AND @Fechahasta
	           AND mvto.tipo_flujo = 1
	           AND mvto.numero_flujo = (
	                   SELECT MIN(ctlf.numero_flujo)
	                   FROM   BacSwapSuda.dbo.MOVDIARIO ctlf
	                   WHERE  ctlf.fecha_cierre BETWEEN @FechaDesde AND @Fechahasta
	                          AND ctlf.numero_operacion = mvto.numero_operacion
	                          AND ctlf.tipo_flujo = 1
	               )
	END
	ELSE
	BEGIN
	    /*----- swap historico*/
	    INSERT INTO #RESULTADOS_MESA
	    SELECT Modulo = 'PCS',
	           Producto              = CASE 
	                           WHEN mvto.tipo_swap = 1 THEN 'SWAP DE TASAS'
	                           WHEN mvto.tipo_swap = 2 THEN 'SWAP DE MONEDAS'
	                           WHEN mvto.tipo_swap = 3 THEN 
	                                'FORWARD RATE AGREETMEN'
	                           WHEN mvto.tipo_swap = 4 THEN 
	                                'SWAP PROMEDIO CAMARA'
	                      END,
	           Numero_Operacion      = mvto.numero_operacion,
	           Documento             = 0,
	           Correlativo           = 0,
	           Serie                 = '',
	           RutCliente            = clie.clrut,
	           CodCliente            = clie.clcodigo,
	           DvCliente             = clie.cldv,
	           NombreCliente         = clie.clnombre,
	           TipoOperacion         = 'C',
	           Monto                 = mvto.compra_capital,
	           MonTransada           = mon1.mnnemo,
	           MonConversion         = mon2.mnnemo,
	           TCCierre              = mvto.compra_valor_tasa,
	           TCCosto               = mvto.Tasa_Transfer,
	           ParidadCierre         = vent.venta_valor_tasa,
	           ParidadCosto          = vent.Tasa_Transfer,
	           MontoPesos            = vent.venta_capital,
	           Operador              = mvto.operador,
	           MontoDolares          = dbo.fn_Monto_Conversion_Moneda (mvto.compra_capital, mon1.mnnemo, mon2.mnnemo, DEFAULT) --PM Función
	           ,
	           ResultadoMesa         = mvto.Res_Mesa_Dist_CLP,
	           Fecha                 = mvto.fecha_cierre --> CONVERT(CHAR(10), mvto.fecha_cierre, 103)
	           ,
	           Relacionado           = '--',
	           FolioRelacionado      = 0,
	           FechaEmision          = mvto.fecha_inicio,
	           FechaVencimiento      = mvto.fecha_termino,
	           SegmentoComercial     = clie.Seg_Comercial
	    FROM   BacSwapSuda.dbo.MOVHISTORICO mvto
	           INNER JOIN BacSwapSuda.dbo.MOVHISTORICO vent
	                ON  vent.numero_operacion = mvto.numero_operacion
	                AND vent.numero_flujo = mvto.numero_flujo
	                AND vent.tipo_flujo = 2
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.rut_cliente
	                AND clie.clcodigo = mvto.codigo_cliente
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon1
	                ON  mon1.mncodmon = mvto.compra_moneda
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon2
	                ON  mon2.mncodmon = vent.venta_moneda
	    WHERE  mvto.estado <> 'C'
	           AND mvto.fecha_cierre BETWEEN @FechaDesde AND @Fechahasta
	           AND mvto.tipo_flujo = 1
	           AND mvto.numero_flujo = (
	                   SELECT MIN(ctlf.numero_flujo)
	                   FROM   BacSwapSuda.dbo.MOVHISTORICO ctlf
	                   WHERE  ctlf.fecha_cierre BETWEEN @FechaDesde AND @Fechahasta
	                          AND ctlf.numero_operacion = mvto.numero_operacion
	                          AND ctlf.tipo_flujo = 1
	               )
	END; ---- FIN SWAP
	
	/* swap pcs anticipado */
	
	INSERT INTO #RESULTADOS_MESA
	SELECT Modulo = 'PCS',
	       Producto              = CASE 
	                       WHEN his.tipo_swap = 1 THEN 'ANT SWAP DE TASAS'
	                       WHEN his.tipo_swap = 2 THEN 'ANT SWAP DE MONEDAS'
	                       WHEN his.tipo_swap = 3 THEN 
	                            'ANT FORWARD RATE AGREETMEN'
	                       WHEN his.tipo_swap = 4 THEN 
	                            'ANT SWAP PROMEDIO CAMARA'
	                  END,
	       Numero_Operacion      = his.numero_operacion,
	       Documento             = 0,
	       Correlativo           = 0,
	       Serie                 = '',
	       RutCliente            = clie.clrut,
	       CodCliente            = clie.clcodigo,
	       DvCliente             = clie.cldv,
	       NombreCliente         = clie.clnombre,
	       TipoOperacion         = 'C',
	       Monto                 = his.compra_capital,
	       MonTransada           = mon1.mnnemo,
	       MonConversion         = mon2.mnnemo,
	       TCCierre              = his.compra_valor_tasa,
	       TCCosto               = 0.0 --> his.Tasa_Transfer
	       ,
	       ParidadCierre         = vta.venta_valor_tasa,
	       ParidadCosto          = 0.0 --> vta.Tasa_Transfer
	       ,
	       MontoPesos            = vta.venta_capital,
	       Operador              = his.operador,
	       MontoDolares          = dbo.fn_Monto_Conversion_Moneda (his.compra_capital, mon1.mnnemo, mon2.mnnemo, DEFAULT) --PM Función
	       ,
	       ResultadoMesa         = unw.ResMesa --> his.Res_Mesa_Dist_CLP
	       ,
	       Fecha                 = his.fecha_cierre --> CONVERT(CHAR(10), mvto.fecha_cierre, 103)
	       ,
	       Relacionado           = '--',
	       FolioRelacionado      = 0,
	       FechaEmision          = his.fecha_inicio,
	       FechaVencimiento      = his.fecha_termino,
	       SegmentoComercial     = clie.Seg_Comercial
	FROM   BacSwapsuda.dbo.CARTERAHIS his
	       INNER JOIN BacSwapsuda.dbo.CARTERAHIS vta
	            ON  vta.numero_operacion = his.numero_operacion
	            AND vta.numero_flujo = his.numero_flujo
	            AND vta.tipo_flujo = 2
	       INNER JOIN (
	                SELECT numero_operacion AS NumCon,
	                       MIN(numero_flujo) -1 AS FluCon,
	                       tipo_flujo AS TipCon,
	                       MIN(Devengo_Recibido_Mda_Val /*Principal_Mda_Val*/) AS 
	                       ResMesa
	                FROM   BacswapSuda.dbo.CARTERA_UNWIND
	                WHERE  FechaAnticipo BETWEEN @FechaDesde AND @Fechahasta
	                       AND tipo_flujo = 1
	                GROUP BY
	                       numero_operacion,
	                       tipo_flujo
	            ) unw
	            ON  unw.NumCon = his.numero_operacion
	            AND unw.FluCon = his.numero_flujo
	            AND unw.TipCon = his.tipo_flujo
	       INNER JOIN BacParamSuda.dbo.CLIENTE clie
	            ON  clie.clrut = his.rut_cliente
	            AND clie.clcodigo = his.codigo_cliente
	       LEFT  JOIN BacParamSuda.dbo.MONEDA mon1
	            ON  mon1.mncodmon = his.compra_moneda
	       LEFT  JOIN BacParamSuda.dbo.MONEDA mon2
	            ON  mon2.mncodmon = vta.venta_moneda
	WHERE  his.estado <> 'C'
	       AND his.tipo_flujo = 1;
	
	SELECT *
	FROM   #RESULTADOS_MESA;
	
	SET NOCOUNT OFF;
END;
GO
