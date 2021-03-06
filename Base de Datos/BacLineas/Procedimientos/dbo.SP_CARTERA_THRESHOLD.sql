USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERA_THRESHOLD]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARTERA_THRESHOLD]
	(	@IdSistema	CHAR(3)         = ''
	,	@nProducto	VARCHAR(5)	= ''
	,	@dFecha		DATETIME     	= ''	
	,	@RutCliente	NUMERIC(9) 	= 0
	,	@CodCliente	NUMERIC(9) 	= 0
	,	@cOperador 	VARCHAR(50)     = ''
        ,       @nTipoFlujo     INTEGER         = 1
	)
AS
BEGIN

   --> @nTipoFlujo
   --> Se Selecciona 1 para cartola emitida al Banco o Ejecutivo
   --> Se Selecciona 2 para cartola emitida al Ejecutivo

   SET NOCOUNT ON

   DECLARE @dFechaForward	DATETIME
       SET @dFechaForward	= (SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock))

   DECLARE @dFechaSwap		DATETIME
       SET @dFechaSwap		= (SELECT fechaproc FROM bacSwapSuda.dbo.SWAPGENERAL with(nolock))

   DECLARE @FecProceso   	DATETIME
       SET @FecProceso    	= (SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock))

   DECLARE @FecEmision   	CHAR(10)
       SET @FecEmision    	= (SELECT  CONVERT ( CHAR(10) , getdate() , 103 ) )

   DECLARE @HoraEmision   	CHAR(10)
       SET @HoraEmision   	= (SELECT  CONVERT ( CHAR(10) , getdate() , 108 ) )

   CREATE TABLE #TMP_RETORNO_FINAL
   (   /*01*/ Operador         VARCHAR(15)
   ,   /*02*/ Sistema          CHAR(3)
   ,   /*03*/ Producto         VARCHAR(25)
   ,   /*04*/ RutCliente       NUMERIC(10)
-- ,   /*05*/ CodCliente       INTEGER
   ,   /*06*/ Nombre           VARCHAR(50)
   ,   /*07*/ NumContrato      INTEGER
   ,   /*08*/ Bloqueado        VARCHAR(20)
   ,   /*09*/ motivobloq       VARCHAR(150)
   ,   /*10*/ descripcion      VARCHAR(50)
   ,   /*11*/ catipoper        VARCHAR(10)
   ,   /*12*/ fecha            DATETIME
   ,   /*13*/ cafecvcto        DATETIME
   ,   /*14*/ PzoRes           NUMERIC(9)
   ,   /*15*/ camtomon1        NUMERIC(21,4)
   ,   /*16*/ catipcam         NUMERIC(21,4)
   ,   /*17*/ nMTM             NUMERIC(21,0)
   ,   /*18*/ nMtoThresHold    NUMERIC(21,4)
   ,   /*19*/ Excesos          NUMERIC(21,4)
   ,   /*20*/ GarantiaTotal    NUMERIC(21,4)
   ,   /*21*/ RutMda1Mda2      VARCHAR(15)
   ,   /*22*/ DescMda1Mda2     VARCHAR(100)
   ,   /*23*/ camtomon2        NUMERIC(21,4)
   ,   /*24*/ catipmoda        VARCHAR(20)
   ,   /*25*/ DirCli           VARCHAR(150)
   ,   /*26*/ FecEmision       CHAR(10)
   ,   /*27*/ FecProceso       CHAR(10)
   ,   /*28*/ HoraEmision      CHAR(10)
   )

    DECLARE @nProdFwd	INTEGER
        SET @nProdFwd 	= CASE WHEN @IdSistema = 'BFW' THEN CONVERT(INTEGER,LTRIM(RTRIM(@nProducto)))
                               ELSE 			  -1
			  END
    DECLARE @nProdSwap  INTEGER		
	SET @nProdSwap 	= CASE WHEN @nProducto = 'ST' THEN 1 
			       WHEN @nProducto = 'SM' THEN 2
			       WHEN @nProducto = 'FR' THEN 3
			       WHEN @nProducto = 'SP' THEN 4
			  END


   SELECT canumoper, cacodpos1, cacodmon1, cacodmon2, cacodcart, cacodigo, cacodcli, catipoper, catipmoda, cafecha
	, catipcam, camtomon1, camtomon2, cafecvcto, caoperador, cafpagomn, cafpagomx, fres_obtenido
     INTO #TMP_CARTERA_FORWARD
     FROM BacFwdSuda.dbo.MFCA with(nolock)
    WHERE 1 = 2
 
   IF @dFechaForward = @dFecha
   BEGIN
   	INSERT INTO #TMP_CARTERA_FORWARD
   	SELECT canumoper, cacodpos1, cacodmon1, cacodmon2, cacodcart, cacodigo, cacodcli, catipoper, catipmoda, cafecha
	,      catipcam, camtomon1, camtomon2, cafecvcto, caoperador, cafpagomn, cafpagomx, fres_obtenido
	FROM   BacFwdSuda.dbo.MFCA with(nolock)
	WHERE (cacodigo   = @RutCliente OR @RutCliente  = 0)
	AND   (cacodcli   = @CodCliente OR @CodCliente  = 0)
	AND   (cacodpos1  = @nProdFwd   OR @nProdFwd   	= 0)

   END ELSE
   BEGIN
   	INSERT INTO #TMP_CARTERA_FORWARD
   	SELECT canumoper, cacodpos1, cacodmon1, cacodmon2, cacodcart, cacodigo, cacodcli, catipoper, catipmoda, cafecha
	,      catipcam, camtomon1, camtomon2, cafecvcto, caoperador, cafpagomn, cafpagomx, fres_obtenido
	FROM   BacFwdSuda.dbo.MFCARES with(nolock)
    	WHERE  cafechaproceso = @dFecha
	AND   (cacodigo   = @RutCliente OR @RutCliente  = 0)
	AND   (cacodcli   = @CodCliente OR @CodCliente  = 0)
	AND   (cacodpos1  = @nProdFwd   OR @nProdFwd	= 0)
   END

   SELECT numero_operacion, numero_flujo, tipo_flujo, tipo_swap, cartera_inversion, rut_cliente, codigo_cliente, fecha_cierre
        , fecha_inicio, fecha_termino, fecha_inicio_flujo, fecha_vence_flujo
	, compra_moneda, compra_capital, compra_amortiza, compra_saldo, compra_interes, compra_spread, compra_codigo_tasa, compra_valor_tasa
	, compra_valor_tasa_hoy, compra_codamo_capital, compra_mesamo_capital, compra_codamo_interes, compra_mesamo_interes, compra_base
	, venta_moneda, venta_capital, venta_amortiza, venta_saldo, venta_interes, venta_spread, venta_codigo_tasa, venta_valor_tasa
	, venta_valor_tasa_hoy, venta_codamo_capital, venta_mesamo_capital, venta_codamo_interes, venta_mesamo_interes, venta_base
	, operador, modalidad_pago, tipo_operacion, Tasa_Compra_Curva, valor_razonableclp
     INTO #TMP_CARTERA_SWAP
     FROM BacSwapSuda.dbo.CARTERA with(nolock)
    WHERE 1 = 2

   IF @dFechaSwap = @dFecha
   BEGIN
	INSERT INTO #TMP_CARTERA_SWAP
	SELECT numero_operacion, numero_flujo, tipo_flujo, tipo_swap, cartera_inversion, rut_cliente, codigo_cliente, fecha_cierre
             , fecha_inicio, fecha_termino, fecha_inicio_flujo, fecha_vence_flujo
             , compra_moneda, compra_capital, compra_amortiza, compra_saldo, compra_interes, compra_spread, compra_codigo_tasa, compra_valor_tasa
             , compra_valor_tasa_hoy, compra_codamo_capital, compra_mesamo_capital, compra_codamo_interes, compra_mesamo_interes, compra_base
             , venta_moneda, venta_capital, venta_amortiza, venta_saldo, venta_interes, venta_spread, venta_codigo_tasa, venta_valor_tasa
             , venta_valor_tasa_hoy, venta_codamo_capital, venta_mesamo_capital, venta_codamo_interes, venta_mesamo_interes, venta_base
             , operador, modalidad_pago, tipo_operacion, Tasa_Compra_Curva, valor_razonableclp
          FROM BacSwapSuda.dbo.CARTERA with(nolock)
	 WHERE (rut_cliente 	= @rutcliente or @rutcliente  = 0)
	   AND (codigo_cliente  = @codcliente or @codcliente  = 0)
	   AND (tipo_swap   	= @nprodswap  or @nproducto   = '')
   END ELSE
   BEGIN
	INSERT INTO #TMP_CARTERA_SWAP
	SELECT numero_operacion, numero_flujo, tipo_flujo, tipo_swap, cartera_inversion, rut_cliente, codigo_cliente, fecha_cierre
             , fecha_inicio, fecha_termino, fecha_inicio_flujo, fecha_vence_flujo
             , compra_moneda, compra_capital, compra_amortiza, compra_saldo, compra_interes, compra_spread, compra_codigo_tasa, compra_valor_tasa
             , compra_valor_tasa_hoy, compra_codamo_capital, compra_mesamo_capital, compra_codamo_interes, compra_mesamo_interes, compra_base
             , venta_moneda, venta_capital, venta_amortiza, venta_saldo, venta_interes, venta_spread, venta_codigo_tasa, venta_valor_tasa
             , venta_valor_tasa_hoy, venta_codamo_capital, venta_mesamo_capital, venta_codamo_interes, venta_mesamo_interes, venta_base
             , operador, modalidad_pago, tipo_operacion, Tasa_Compra_Curva, valor_razonableclp
          FROM BacSwapSuda.dbo.CARTERARES with(nolock)
	 WHERE Fecha_Proceso 	= @dFecha
	   AND (rut_cliente 	= @rutcliente or @rutcliente  = 0)
	   AND (codigo_cliente  = @codcliente or @codcliente  = 0)
	   AND (tipo_swap   	= @nprodswap  or @nproducto   = '')
   END


   IF @IdSistema = 'BFW' OR @IdSistema=''
   BEGIN
	INSERT INTO #TMP_RETORNO_FINAL
	SELECT 	       /*01*/ 'operador' 	= mfca.caoperador
		,      /*02*/ 'sistema'	        = prod.id_sistema
		,      /*03*/ 'productoa'	= substring(prod.descripcion,1,25)
		,      /*04*/ 'rutcliente'	= cli.clrut
		,      /*05*/ 'nombre'	        = substring(cli.clnombre,1, 50)
		,      /*06*/ 'NumContrato'	= mfca.canumoper
		,      /*07*/ 'Bloqueado' 	= CASE WHEN lingral.bloqueado='' THEN 'DESBLOQUEADO' ELSE 'BLOQUEADO' END
		,      /*08*/ 'motivobloq'	= cli.motivo_bloqueo
		,      /*09*/ 'descripcion'	= prod.descripcion
		,      /*10*/ 'CaTipOper' 	= CASE WHEN mfca.catipoper='C' THEN 'COMPRA' ELSE 'VENTA' END
		,      /*11*/ 'fecha'		= mfca.cafecha																		
		,      /*12*/ 'cafecvcto'	= mfca.cafecvcto 																		
		,      /*13*/ 'PzoRes' 	        = DATEDIFF(day,@FecProceso,mfca.cafecha) 													
		,      /*14*/ 'camtomon1'	= mfca.camtomon1																	
		,      /*15*/ 'CaTipCam'	= CONVERT(NUMERIC(15,9), mfca.catipcam) 																	
		,      /*16*/ 'nMTM' 		= ISNULL(CONVERT(NUMERIC(21,2), ROUND(mfca.fres_obtenido, 2)),0)
		,      /*17*/ 'nMtoThresHold'   = ISNULL(CONVERT(NUMERIC(21,2), ROUND(threshold.threshold_aplicado, 2)), 0.0)
		,      /*18*/ 'Excesos' 	= ISNULL(CASE 	WHEN mfca.fres_obtenido > threshold.threshold_aplicado   THEN (mfca.fres_obtenido - threshold.threshold_aplicado) 
						      		WHEN mfca.fres_obtenido <= threshold.threshold_aplicado  THEN 0  								
		 			         	 END, 0.0)
		,      /*19*/ 'GarantiaTotal'	= cli.garantiatotal
		,      /*20*/ 'RutMda1Mda2'     = LTRIM(RTRIM(CONVERT(CHAR(10),cli.Clrut)))  + LTRIM(RTRIM(mon1.mnnemo)) + LTRIM(RTRIM(mon2.mnnemo))
		,      /*21*/ 'DescMda1Mda2'	= LTRIM(RTRIM(prod.Descripcion)) + ' ' +LTRIM(RTRIM(mon1.mnnemo)) + '/' + LTRIM(RTRIM(mon2.mnnemo))
		,      /*22*/ 'CaMtoMon2'	= mfca.CaMtoMon2	
		,      /*23*/ 'catipmoda' 	= CASE WHEN mfca.catipmoda='E'  THEN 'E.FISICA' ELSE 'COMPENSACION' END
		,      /*24*/ 'DirCli'	        = cli.cldirecc
		,      /*25*/ 'FecEmision' 	= @fecemision
		,      /*26*/ 'FecProceso'	= @fecproceso
		,      /*27*/ 'HoraEmision' 	= @horaemision
		FROM    #TMP_CARTERA_FORWARD mfca --> CAMBIAR POR CARTERA MFCA
			INNER 	JOIN BacParamSuda.dbo.CLIENTE   	      	  cli		ON cli.clrut = mfca.cacodigo      AND cli.clcodigo = mfca.cacodcli
			INNER	JOIN BacParamSuda.dbo.PRODUCTO 	     	      	  prod 		ON prod.id_sistema = 'BFW' AND prod.codigo_producto = mfca.cacodpos1
			LEFT  	JOIN BacLineas.dbo.LINEA_GENERAL 	      	  LinGral 	ON lingral.rut_cliente = mfca.cacodigo  AND lingral.codigo_cliente = mfca.cacodcli
			LEFT  	JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION 	  Threshold	ON threshold.sistema = 'BFW' AND threshold.producto = mfca.cacodpos1 AND threshold.numero_operacion = mfca.canumoper 
			LEFT	JOIN view_moneda 				  mon1 	   	ON mon1.mncodmon = mfca.cacodmon1
			LEFT 	JOIN view_moneda 				  mon2 	   	ON mon2.mncodmon = mfca.cacodmon2

	 END


	IF @IdSistema = 'PCS' OR @IdSistema=''
	BEGIN


                INSERT INTO #TMP_RETORNO_FINAL
		SELECT 'operador' 	= swap.operador
		,	'sistema'	= prod.id_sistema
		,	'productoa'	= substring(prod.descripcion,1,25)
		,	'rutcliente'	= cli.clrut
		,	'nombre'	= substring(cli.clnombre,1, 50)
		,	'numcontrato'	= swap.numero_operacion
		,	'Bloqueado' 	= CASE WHEN lingral.bloqueado='' THEN 'DESBLOQUEADO' ELSE 'BLOQUEADO' END
		,	'motivobloq'	= cli.motivo_bloqueo
		,	'descripcion'	= prod.descripcion
		,	'CaTipOper' 	= CASE WHEN swap.tipo_operacion='C' THEN 'COMPRA' ELSE 'VENTA' END
		,	'fecha'		= swap.fecha_inicio																	
		,	'CaFecVcto'	= swap.fecha_termino																	
		,	'PzoRes' 	= DATEDIFF(day,@fecproceso,swap.fecha_termino) 													
		,	'CaMtoMon1'	= swap.compra_capital																	
		,	'CaTipCam'	= swap.Tasa_Compra_Curva																
		,	'nMTM' 		= ISNULL(CONVERT(NUMERIC(21,2), ROUND(swap.valor_razonableclp, 2)),0)
		,	'nMtoThresHold' = ISNULL(CONVERT(NUMERIC(21,2), ROUND(threshold.threshold_aplicado, 2)), 0.0)								
		,	'Excesos' 	= ISNULL(CASE WHEN swap.valor_razonableclp > threshold.threshold_aplicado   THEN (swap.valor_razonableclp - threshold.threshold_aplicado) 
						      WHEN swap.valor_razonableclp <= threshold.threshold_aplicado  THEN 0  								
		 			         END, 0.0)
		,	'garantiatotal'	= cli.garantiatotal
		,	'RutMda1Mda2'   = LTRIM(RTRIM(CONVERT(CHAR(10),cli.clrut)))  + LTRIM(RTRIM(mon1.mnnemo)) + LTRIM(RTRIM(mon2.mnnemo))
		,	'DescMda1Mda2'  = LTRIM(RTRIM(prod.descripcion)) + ' ' +LTRIM(RTRIM(mon1.mnnemo)) + '/' + LTRIM(RTRIM(mon2.mnnemo))
		,	'CaMtoMon2'	= 0 
		,	'catipmoda' 	= CASE WHEN swap.modalidad_pago='E'  THEN 'E.FISICA' ELSE 'COMPENSACION' END
		,	'DirCli'	= cli.cldirecc
		,	'FecEmision' 	= @fecemision
		,	'FecProceso'	= @fecproceso
		,	'HoraEmision' 	= @horaemision
		 FROM #TMP_CARTERA_SWAP  swap
			INNER 	JOIN BacParamSuda.dbo.CLIENTE 		      cli		ON  cli.clrut = swap.rut_cliente AND cli.clcodigo 	= swap.codigo_cliente
			INNER 	JOIN BacParamSuda.dbo.PRODUCTO 		      prod 		ON  prod.id_sistema = 'PCS' AND prod.codigo_producto 	= CASE   WHEN swap.tipo_swap  = 1 THEN 'ST'
																					  WHEN swap.tipo_swap  = 2 THEN 'SM'	
																					 WHEN swap.tipo_swap  = 3 THEN 'FR'	
																		 			  WHEN swap.tipo_swap  = 4 THEN 'SP'	
																          		  END
			LEFT 	JOIN BacLineas.dbo.LINEA_GENERAL 	      LinGral 		ON  lingral.rut_cliente  = swap.rut_cliente  AND lingral.codigo_cliente = swap.codigo_cliente
			LEFT  	JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION Threshold 	ON  threshold.sistema = 'PCS' AND threshold.numero_operacion  = swap.numero_operacion 		
			LEFT 	JOIN view_moneda 			      mon1 		ON  mon1.mncodmon =  swap.compra_moneda
			LEFT 	JOIN view_moneda 			      mon2 		ON  mon2.mncodmon =  swap.venta_moneda

		WHERE swap.tipo_flujo 	        = @nTipoFlujo
                  AND swap.numero_flujo 	= (SELECT MIN(numero_flujo) FROM bacswapsuda..cartera WHERE  tipo_flujo  = @nTipoFlujo  AND  numero_operacion= swap.numero_operacion)
	END

      SELECT Operador
         ,   Sistema
         ,   Producto
         ,   RutCliente
         ,   Nombre
         ,   NumContrato
         ,   Bloqueado
         ,   motivobloq
         ,   descripcion
         ,   catipoper
         ,   fecha
         ,   cafecvcto
         ,   PzoRes
         ,   camtomon1
         ,   catipcam
         ,   nMTM
         ,   nMtoThresHold
         ,   Excesos
         ,   GarantiaTotal
         ,   RutMda1Mda2
         ,   DescMda1Mda2
         ,   camtomon2
         ,   catipmoda
         ,   DirCli
         ,   FecEmision
         ,   FecProceso
         ,   HoraEmision
      FROM   #TMP_RETORNO_FINAL
      ORDER BY RutCliente,Sistema, Producto

END
GO
