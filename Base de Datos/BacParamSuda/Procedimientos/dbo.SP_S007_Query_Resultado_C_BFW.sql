USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S007_Query_Resultado_C_BFW]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_S007_Query_Resultado_C_BFW]
(
    @FechaDesde        DATETIME,
    @FechaHasta        DATETIME,
    @dFechaProceso     DATETIME,
    @Tipo_Cambio       DECIMAL
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
	
	
	-------------- FORWARD ----- FORWARD --- FORWARD -----------------------------------------------
	IF (@FechaDesde = @FechaHasta AND @dFechaProceso = @FechaDesde)
	BEGIN
	    ---forward diario
	    INSERT INTO #RESULTADOS_MESA
	    SELECT Modulo = 'BFW',
	           Producto               = prod.descripcion,
	           Numero_Operacion       = mvto.monumoper,
	           Numero_Documento       = 0,
	           Numero_Correlativo     = mvto.motipcamSpot,
	           Serie                  = '',
	           RutCliente             = clie.clrut,
	           CodCliente             = clie.clcodigo,
	           DvCliente              = clie.cldv,
	           NombreCliente          = clie.clnombre,
	           TipoOperacion          = mvto.motipoper,
	           Monto                  = mvto.momtomon1,
	           MonTransada            = mon1.mnnemo,
	           MonConversion          = mon2.mnnemo,
	           TCCierre               = CASE 
	                           WHEN mvto.mocodpos1 = 1 THEN mvto.motipcam
	                           WHEN mvto.mocodpos1 = 2 THEN mvto.mopremon1
	                           WHEN mvto.mocodpos1 = 3 THEN mvto.motipcam
	                           WHEN mvto.mocodpos1 = 13 THEN mvto.motipcam
	                      END,
	           TCCosto                = CASE 
	                          WHEN mvto.mocodpos1 = 1 THEN mvto.mopreciopunta
	                          WHEN mvto.mocodpos1 = 2 THEN mvto.mopremon2
	                          WHEN mvto.mocodpos1 = 3 THEN mvto.mopreciopunta
	                          WHEN mvto.mocodpos1 = 13 THEN mvto.mopreciopunta
	                     END,
	           ParidadCierre          = CASE 
	                                WHEN mvto.mocodpos1 = 1 THEN mvto.moparmon1
	                                WHEN mvto.mocodpos1 = 2 THEN mvto.motipcam
	                                WHEN mvto.mocodpos1 = 3 THEN 0.0
	                                WHEN mvto.mocodpos1 = 13 THEN 0.0
	                           END,
	           ParidadCosto           = CASE 
	                               WHEN mvto.mocodpos1 = 1 THEN mvto.moparmon2
	                               WHEN mvto.mocodpos1 = 2 THEN mvto.moparmon1
	                               WHEN mvto.mocodpos1 = 3 THEN 0.0
	                               WHEN mvto.mocodpos1 = 13 THEN 0.0
	                          END,
	           MontoPesos             = mvto.moequmon1,
	           Operador               = mvto.mooperador,
	           MontoDolares           = CASE mvto.mocodpos1
	                               WHEN 2 THEN mvto.momtomon2
	                               ELSE mvto.moequusd1
	                          END,
	           ResultadoMesa          = CASE 
	                                WHEN mvto.mocodpos1 = 2 THEN ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)
	                                ELSE mvto.Resultado_Mesa
	                           END,
	           Fecha                  = mvto.mofecha --> CONVERT(CHAR(10), mvto.mofecha, 103)
	           ,
	           Relacionado            = CASE 
	                              WHEN var_moneda2 <> 0 THEN 
	                                   'Operacion Relacionada MX/CLP'
	                              ELSE '--'
	                         END,
	           FolioRelacionado       = 0,
	           FechaEmision           = mofecEfectiva,
	           FechaVencimiento       = mofecvcto,
	           SegmentoComercial      = clie.Seg_Comercial
	    FROM   BacFwdSuda.dbo.MFMO mvto
	           INNER JOIN bacfwdsuda.dbo.mfca cart
	                ON  cart.canumoper = mvto.monumoper
	           INNER JOIN BacFwdSuda.dbo.MFAC ctro
	                ON  ctro.acfecproc = mvto.mofecha
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.mocodigo
	                AND clie.clcodigo = mvto.mocodcli
	           INNER JOIN BacParamSuda.dbo.PRODUCTO prod
	                ON  prod.id_sistema = 'BFW'
	                AND prod.codigo_producto = mvto.mocodpos1
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon1
	                ON  mon1.mncodmon = mvto.mocodmon1
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon2
	                ON  mon2.mncodmon = mvto.mocodmon2
	           LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont
	                ON  vcont.fecha = ctro.acfecante
	                AND vcont.codigo_moneda = 994
	    WHERE  mvto.moestado <> 'A'
	           AND mvto.mofecha BETWEEN @FechaDesde AND @Fechahasta
	END
	ELSE
	BEGIN
	    ---- forward historico
	    INSERT INTO #RESULTADOS_MESA
	    SELECT Modulo = 'BFW',
	           Producto               = prod.descripcion,
	           Numero_Operacion       = mvto.monumoper,
	           Numero_Documento       = 0,
	           Numero_Correlativo     = mvto.motipcamSpot,
	           Serie                  = '',
	           RutCliente             = clie.clrut,
	           CodCliente             = clie.clcodigo,
	           DvCliente              = clie.cldv,
	           NombreCliente          = clie.clnombre,
	           TipoOperacion          = mvto.motipoper,
	           Monto                  = mvto.momtomon1,
	           MonTransada            = mon1.mnnemo,
	           MonConversion          = mon2.mnnemo,
	           TCCierre               = CASE 
	                           WHEN mvto.mocodpos1 = 1 THEN mvto.motipcam
	                           WHEN mvto.mocodpos1 = 2 THEN mvto.mopremon1
	                           WHEN mvto.mocodpos1 = 3 THEN mvto.motipcam
	                           WHEN mvto.mocodpos1 = 13 THEN mvto.motipcam
	                      END,
	           TCCosto                = CASE 
	                          WHEN mvto.mocodpos1 = 1 THEN mvto.mopreciopunta
	                          WHEN mvto.mocodpos1 = 2 THEN mvto.mopremon2
	                          WHEN mvto.mocodpos1 = 3 THEN mvto.mopreciopunta
	                          WHEN mvto.mocodpos1 = 13 THEN mvto.mopreciopunta
	                     END,
	           ParidadCierre          = CASE 
	                                WHEN mvto.mocodpos1 = 1 THEN mvto.moparmon1
	                                WHEN mvto.mocodpos1 = 2 THEN mvto.motipcam
	                                WHEN mvto.mocodpos1 = 3 THEN 0.0
	                                WHEN mvto.mocodpos1 = 13 THEN 0.0
	                           END,
	           ParidadCosto           = CASE 
	                               WHEN mvto.mocodpos1 = 1 THEN mvto.moparmon2
	                               WHEN mvto.mocodpos1 = 2 THEN mvto.moparmon1
	                               WHEN mvto.mocodpos1 = 3 THEN 0.0
	                               WHEN mvto.mocodpos1 = 13 THEN 0.0
	                          END,
	           MontoPesos             = mvto.moequmon1,
	           Operador               = mvto.mooperador,
	           MontoDolares           = CASE mvto.mocodpos1
	                               WHEN 2 THEN MVTO.momtomon2
	                               ELSE mvto.moequusd1
	                          END,
	           ResultadoMesa          = CASE 
	                                WHEN mvto.mocodpos1 = 2 THEN ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)
	                                ELSE mvto.Resultado_Mesa
	                           END,
	           Fecha                  = mvto.mofecha --> CONVERT(CHAR(10), mvto.mofecha, 103)
	           ,
	           Relacionado            = CASE 
	                              WHEN var_moneda2 <> 0 THEN 
	                                   'Operacion Relacionada MX/CLP'
	                              ELSE '--'
	                         END,
	           FolioRelacionado       = 0,
	           FechaEmision           = mofecEfectiva,
	           FechaVencimiento       = mofecvcto,
	           SegmentoComercial      = clie.Seg_Comercial
	    FROM   BacFwdSuda.dbo.MFMOH mvto
	           INNER JOIN bacfwdsuda.dbo.mfca cart
	                ON  cart.canumoper = mvto.monumoper
	           INNER JOIN BacFwdSuda.dbo.MFACH ctro
	                ON  ctro.acfecproc = mvto.mofecha
	           INNER JOIN BacParamSuda.dbo.CLIENTE clie
	                ON  clie.clrut = mvto.mocodigo
	                AND clie.clcodigo = mvto.mocodcli
	           INNER JOIN BacParamSuda.dbo.PRODUCTO prod
	                ON  prod.id_sistema = 'BFW'
	                AND prod.codigo_producto = mvto.mocodpos1
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon1
	                ON  mon1.mncodmon = mvto.mocodmon1
	           LEFT  JOIN BacParamSuda.dbo.MONEDA mon2
	                ON  mon2.mncodmon = mvto.mocodmon2
	           LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont
	                ON  vcont.fecha = ctro.acfecante
	                AND vcont.codigo_moneda = 994
	    WHERE  mvto.moestado <> 'A'
	           AND mvto.mofecha BETWEEN @FechaDesde AND @Fechahasta
	END; ---- Fin FORWARD
	
	
	/* BFW anticipos */
	SELECT canumoper,
	       cacodpos1,
	       catipoper,
	       catipmoda,
	       cacodigo,
	       cacodcli,
	       cacodmon1,
	       cacodmon2,
	       camtomon1,
	       caequmon1,
	       caequusd1,
	       capremon1,
	       capremon2,
	       capreant,
	       caspread,
	       camtomon2,
	       cafecha,
	       cafecvcto,
	       caestado,
	       caantici,
	       caoperador,
	       precio_spot,
	       caantptosfwd,
	       caantptoscos
	       INTO #TMP_CARTERA_ANTICIPO_FORWARD
	FROM   BacFwdsuda.dbo.MFCA unw WITH(NOLOCK)
	WHERE  unw.cafecvcto BETWEEN @FechaDesde AND @Fechahasta
	       AND unw.caestado <> 'A'
	       AND unw.caantici = 'A';
	
	INSERT INTO #TMP_CARTERA_ANTICIPO_FORWARD
	SELECT canumoper,
	       cacodpos1,
	       catipoper,
	       catipmoda,
	       cacodigo,
	       cacodcli,
	       cacodmon1,
	       cacodmon2,
	       camtomon1,
	       caequmon1,
	       caequusd1,
	       capremon1,
	       capremon2,
	       capreant,
	       caspread,
	       camtomon2,
	       cafecha,
	       cafecvcto,
	       caestado,
	       caantici,
	       caoperador,
	       precio_spot,
	       caantptosfwd = 0.0,
	       caantptoscos = 0.0
	FROM   BacFwdsuda.dbo.MFCAH unw WITH(NOLOCK)
	WHERE  unw.cafecvcto BETWEEN @FechaDesde AND @Fechahasta
	       AND unw.caestado <> 'A'
	       AND unw.caantici = 'A'
	       AND unw.canumoper NOT IN (SELECT canumoper
	                                 FROM   #TMP_CARTERA_ANTICIPO_FORWARD);
	
	
	UPDATE #RESULTADOS_MESA
	SET    Monto = Monto - cant.camtomon1,
	       MontoPesos = MontoPesos - cant.caequmon1,
	       MontoDolares = MontoDolares - CASE 
	                                          WHEN cant.cacodpos1 = 2 AND cant.camtomon1
	                                               <> 13 THEN cant.camtomon2
	                                          ELSE cant.caequusd1
	                                     END
	FROM   #TMP_CARTERA_ANTICIPO_FORWARD cant
	WHERE  #RESULTADOS_MESA.Modulo = 'BFW'
	       AND #RESULTADOS_MESA.Numero_Operacion = cant.canumoper;
	
	
	--fill Forward Anticipado
	INSERT INTO #RESULTADOS_MESA
	SELECT Modulo = 'BFW',
	       Producto               = 'ANT ' + pro.descripcion,
	       Numero_Operacion       = unw.canumoper,
	       Numero_Documento       = 0,
	       Numero_Correlativo     = 0,
	       Serie                  = '',
	       RutCliente             = cli.clrut,
	       CodCliente             = cli.clcodigo,
	       DvCliente              = cli.cldv,
	       NombreCliente          = cli.clnombre,
	       TipoOperacion          = unw.catipoper,
	       Monto                  = unw.camtomon1 --> 0.0 --> unw.camtomon1
	       ,
	       MonTransada            = mn1.mnnemo,
	       MonConversion          = mn1.mnnemo,
	       TCCierre               = CASE 
	                       WHEN unw.cacodpos1 = 2 THEN unw.capremon1
	                       ELSE unw.precio_spot + unw.caantptosfwd
	                  END,
	       TCCosto                = CASE 
	                      WHEN unw.cacodpos1 = 2 THEN unw.capremon2
	                      ELSE unw.capreant + unw.caantptoscos
	                 END,
	       ParidadCierre          = CASE 
	                            WHEN unw.cacodpos1 = 2 THEN unw.precio_spot +
	                                 unw.caantptosfwd / mn1.mnfactor
	                            ELSE 1.0
	                       END,
	       ParidadCosto           = CASE 
	                           WHEN unw.cacodpos1 = 2 THEN unw.capreant + unw.caantptoscos
	                                / mn1.mnfactor
	                           ELSE 1.0
	                      END,
	       MontoPesos             = unw.caequmon1 --> 0.0 --> unw.caequmon1
	       ,
	       Operador               = unw.caoperador,
	       MontoDolares           = CASE 
	                           WHEN unw.cacodpos1 = 2 AND unw.camtomon1 <> 13 THEN 
	                                unw.camtomon2
	                           ELSE unw.caequusd1
	                      END --> 0.0 --> CASE WHEN unw.cacodpos1 = 2 and unw.camtomon1 <> 13 THEN unw.camtomon2 ELSE unw.caequusd1 END
	       ,
	       ResultadoMesa = unw.caspread,
	       Fecha = unw.cafecvcto,
	       Relacionado = '--',
	       FolioRelacionado = 0,
	       FechaEmision = unw.cafecvcto,
	       FechaVencimiento = unw.cafecvcto,
	       SegmentoComercial = cli.Seg_Comercial
	FROM   #TMP_CARTERA_ANTICIPO_FORWARD unw
	       LEFT JOIN BacParamSuda.dbo.PRODUCTO pro WITH(NOLOCK)
	            ON  pro.id_sistema = 'BFW'
	            AND pro.codigo_producto = unw.cacodpos1
	       LEFT JOIN BacParamSuda.dbo.CLIENTE cli WITH(NOLOCK)
	            ON  cli.clrut = unw.cacodigo
	            AND cli.clcodigo = unw.cacodcli
	       LEFT JOIN BacParamSuda.dbo.MONEDA mn1 WITH(NOLOCK)
	            ON  mn1.mncodmon = unw.cacodmon1
	       LEFT JOIN BacParamSuda.dbo.MONEDA mn2 WITH(NOLOCK)
	            ON  mn2.mncodmon = unw.cacodmon2;
	
	SELECT *
	FROM   #RESULTADOS_MESA;
	
	SET NOCOUNT OFF;
END;
GO
