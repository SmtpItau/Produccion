USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTOLA_CLIENTE]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARTOLA_CLIENTE]
   (   @idsistema    CHAR(3)     = ''
   ,   @nproducto    CHAR(5)     = ''
   ,   @dfecha       DATETIME    = ''
   ,   @rutcliente   NUMERIC(9)  = 0
   ,   @codcliente   NUMERIC(9)  = 0
   ,   @coperador    VARCHAR(50) = ''
   ,   @ntipoflujo   INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @fecproceso   DATETIME
       SET @fecproceso    = (SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock))

   DECLARE @fecemision   CHAR(10)
       SET @fecemision    = (SELECT  CONVERT ( CHAR(10) , getdate() , 103 ) )

   DECLARE @horaemision   CHAR(10)
       SET @horaemision   = (SELECT  CONVERT ( CHAR(10) , getdate() , 108 ) )


   CREATE TABLE #TMP_RETORNO_FINAL
   (   /*01*/ Operador         VARCHAR(15)
   ,   /*02*/ Sistema          CHAR(3)
   ,   /*03*/ Producto         VARCHAR(25)
   ,   /*04*/ RutCliente       NUMERIC(10)
   ,   /*05*/ Nombre           VARCHAR(50)
   ,   /*06*/ NumContrato      INTEGER
   ,   /*07*/ descripcion      VARCHAR(50)
   ,   /*08*/ catipoper        VARCHAR(10)
   ,   /*09*/ fecha            DATETIME
   ,   /*10*/ cafecvcto        DATETIME
   ,   /*11*/ PzoRes           NUMERIC(9)
   ,   /*12*/ camtomon1        NUMERIC(21,4)
   ,   /*13*/ camtomon2        NUMERIC(21,4)
   ,   /*14*/ catipcam         NUMERIC(21,4)
   ,   /*15*/ nMTM             NUMERIC(21,0)
   ,   /*16*/ RutMda1Mda2      VARCHAR(15)
   ,   /*17*/ DescMda1Mda2     VARCHAR(100)
   ,   /*18*/ catipmoda        VARCHAR(20)
   ,   /*19*/ DirCli           VARCHAR(150)
   ,   /*20*/ FecEmision       CHAR(10)
   ,   /*21*/ FecProceso       CHAR(10)
   ,   /*22*/ HoraEmision      CHAR(10)
   ,   /*23*/ pcs_nNumOper     INTEGER 
   ,   /*24*/ pcs_nFlujo       INTEGER 
   ,   /*25*/ pcs_cFecInicio   DATETIME
   ,   /*26*/ pcs_cFecVcto     DATETIME
   ,   /*27*/ pcs_cProxVcto    DATETIME
   ,   /*28*/ pcs_nNocional    NUMERIC(21,4) 
   ,   /*29*/ pcs_nTasas       NUMERIC(21,4) 
   ,   /*30*/ Ejecutivo        VARCHAR(50)
   )

   CREATE INDEX #Ix_TMP_RETORNO_FINAL on #TMP_RETORNO_FINAL (rutcliente, nombre, sistema, producto)

   IF @IdSistema = 'BFW' OR @IdSistema=''
   BEGIN

      DECLARE @nProdFwd INTEGER
          SET @nProdFwd = CAST( @nProducto AS INTEGER)

      INSERT INTO #TMP_RETORNO_FINAL
      SELECT /*01*/ 'operador' 	        = mfca.caoperador
         ,   /*02*/ 'sistema'	        = prod.id_sistema
         ,   /*03*/ 'productoa'	        = substring(prod.descripcion,1,25)
         ,   /*04*/ 'rutcliente'	= cli.clrut
         ,   /*05*/ 'nombre'	        = substring(cli.clnombre,1, 50)
         ,   /*06*/ 'NumContrato'	= mfca.canumoper
         ,   /*07*/ 'descripcion'	= prod.descripcion
         ,   /*08*/ 'CaTipOper' 	= CASE WHEN mfca.catipoper='C' THEN 'COMPRA' ELSE 'VENTA' END
         ,   /*09*/ 'fecha'		= mfca.cafecha																		
         ,   /*10*/ 'cafecvcto'	        = mfca.cafecvcto 																		
         ,   /*11*/ 'PzoRes' 	        = DATEDIFF(DAY,@FecProceso,mfca.cafecha) 													
         ,   /*12*/ 'camtomon1'	        = mfca.camtomon1																	
         ,   /*13*/ 'CaMtoMon2'	        = mfca.CaMtoMon2	
         ,   /*14*/ 'CaTipCam'	        = CONVERT(NUMERIC(15,9), mfca.catipcam) 																	
         ,   /*15*/ 'nMTM' 		= ISNULL(CONVERT(NUMERIC(21,2), ROUND(mfca.fres_obtenido, 2)),0)
         ,   /*16*/ 'RutMda1Mda2'       = LTRIM(RTRIM(CONVERT(CHAR(10),cli.clrut)))  + LTRIM(RTRIM(mon1.mnnemo)) + LTRIM(RTRIM(mon2.mnnemo))
         ,   /*17*/ 'DescMda1Mda2'	= LTRIM(RTRIM(prod.descripcion)) + ' ' +LTRIM(RTRIM(mon1.mnnemo)) + '/' + LTRIM(RTRIM(mon2.mnnemo))
         ,   /*18*/ 'catipmoda' 	= CASE WHEN mfca.catipmoda='E'  THEN 'E.FISICA' ELSE 'COMPENSACION' END
         ,   /*19*/ 'DirCli'	        = cli.cldirecc
         ,   /*20*/ 'FecEmision' 	= @fecemision
         ,   /*21*/ 'FecProceso'	= @fecproceso
         ,   /*22*/ 'HoraEmision' 	= @horaemision
         ,   /*23*/ 'pcs_nNumOper'      = 0
         ,   /*24*/ 'pcs_nFlujo'        = 0
         ,   /*25*/ 'pcs_cFecInicio'    = ''
         ,   /*26*/ 'pcs_cFecVcto'      = ''
         ,   /*27*/ 'pcs_cProxVcto'     = ''
         ,   /*28*/ 'pcs_nNocional'     = 0
         ,   /*29*/ 'pcs_nTasas'        = 0
         ,   /*30*/ 'Ejecutivo'         = ISNULL(CASE WHEN cli.ejecutivo_comercial = '' THEN 'SIN EJECUTIVO'
                                                      ELSE                                   cli.ejecutivo_comercial
                                                 END, 'SIN EJECUTIVO')
      FROM   BacFwdSuda.dbo.MFCA mfca   --> CAMBIAR POR CARTERA MFCA
             INNER JOIN BacParamSuda.dbo.CLIENTE   cli ON cli.clrut = mfca.cacodigo AND cli.clcodigo = mfca.cacodcli
             INNER JOIN BacParamSuda.dbo.PRODUCTO prod ON prod.id_sistema = 'BFW' AND prod.codigo_producto = mfca.cacodpos1
             LEFT  JOIN view_moneda 		  mon1 ON mon1.mncodmon = mfca.cacodmon1
             LEFT  JOIN view_moneda 		  mon2 ON mon2.mncodmon = mfca.cacodmon2
      WHERE (mfca.cacodigo   = @RutCliente OR @RutCliente  = 0) 
        AND (mfca.cacodcli   = @CodCliente OR @CodCliente  = 0)
        AND (mfca.cacodpos1  = @nProdFwd   OR @nProdFwd    = 0) 
   END

   IF @IdSistema = 'PCS' OR @IdSistema=''
   BEGIN

      DECLARE @nProdSwap as INTEGER		
       SELECT @nProdSwap = CASE WHEN @nProducto = 'ST' THEN 1 
                                WHEN @nProducto = 'SM' THEN 2
                                WHEN @nProducto = 'FR' THEN 3
                                WHEN @nProducto = 'SP' THEN 4
                           END

      INSERT INTO #TMP_RETORNO_FINAL
      SELECT /*01*/ 'Operador'        = cart.operador
         ,   /*02*/ 'Sistema'         = prod.id_sistema
         ,   /*03*/ 'Producto'        = substring(prod.descripcion,1,25)
         ,   /*04*/ 'RutCliente'      = cli.clrut
         ,   /*05*/ 'Nombre'          = substring(cli.clnombre,1, 50)
         ,   /*06*/ 'NumContrato'     = cart.numero_operacion
         ,   /*07*/ 'descripcion'     = prod.descripcion
         ,   /*08*/ 'catipoper'       = CASE WHEN cart.tipo_operacion='C' THEN 'COMPRA' ELSE 'VENTA' END
         ,   /*09*/ 'fecha'           = ''
         ,   /*10*/ 'cafecvcto'       = ''
         ,   /*11*/ 'PzoRes'          = 0
         ,   /*12*/ 'camtomon1'       = 0
         ,   /*13*/ 'camtomon2'       = 0
         ,   /*14*/ 'catipcam'        = CASE WHEN cart.tipo_operacion='C' THEN cart.Tasa_Compra_Curva	 ELSE cart.Tasa_Venta_Curva END
         ,   /*15*/ 'nMTM'            = CONVERT(NUMERIC(21,2), ROUND(cart.Valor_RazonableCLP, 2)) 	
         ,   /*16*/ 'RutMda1Mda2'     = LTRIM(RTRIM(CONVERT(CHAR(10),cli.Clrut)))  + LTRIM(RTRIM(mon1.mnnemo)) + LTRIM(RTRIM(mon2.mnnemo))
         ,   /*17*/ 'DescMda1Mda2'    = LTRIM(RTRIM(prod.Descripcion)) + ' ' +LTRIM(RTRIM(mon1.mnnemo)) + '/' + LTRIM(RTRIM(mon2.mnnemo))
         ,   /*18*/ 'catipmoda'       = CASE WHEN cart.modalidad_pago='E'  THEN 'E.FISICA' ELSE 'COMPENSACION' END
         ,   /*19*/ 'DirCli'          = cli.cldirecc
         ,   /*20*/ 'FecEmision'      = @fecemision
         ,   /*21*/ 'FecProceso'      = @fecproceso
         ,   /*22*/ 'HoraEmision'     = @horaemision
         ,   /*23*/ 'pcs_nNumOper'    = cart.numero_operacion
         ,   /*24*/ 'pcs_nFlujo'      = cart.numero_flujo
         ,   /*25*/ 'pcs_cFecInicio'  = cart.fecha_inicio_flujo
         ,   /*26*/ 'pcs_cFecVcto'    = cart.fecha_vence_flujo
         ,   /*27*/ 'pcs_cProxVcto'   = CASE WHEN cart.fecha_vence_flujo = cart.fecha_termino THEN cart.fecha_termino
                                             ELSE (SELECT proxv.fecha_vence_flujo 
                                                     FROM BacSwapSuda.dbo.CARTERA proxv 
                                                    WHERE proxv.numero_operacion = cart.numero_operacion
			                              AND proxv.tipo_flujo       = cart.tipo_flujo
                        			      AND proxv.numero_flujo     = (cart.numero_flujo + 1))
		                        END
         ,   /*28*/ 'pcs_nNocional'   = CASE WHEN @nTipoFlujo = 1 THEN cart.compra_capital    ELSE cart.venta_capital    END
         ,   /*29*/ 'pcs_nTasas'      = CASE WHEN @nTipoFlujo = 1 THEN cart.compra_valor_tasa ELSE cart.venta_valor_tasa END
         ,   /*30*/ 'Ejecutivo'       = ISNULL(CASE WHEN cli.ejecutivo_comercial = '' THEN 'SIN EJECUTIVO'
                                                    ELSE                                   cli.ejecutivo_comercial
                                               END, 'SIN EJECUTIVO')
      FROM   BacSwapSuda.dbo.CARTERA               cart
             INNER JOIN BacParamSuda.dbo.CLIENTE    cli ON cli.clrut = cart.rut_cliente  AND cli.clcodigo = cart.codigo_cliente
             INNER JOIN BacParamSuda.dbo.PRODUCTO  prod ON prod.id_sistema = 'PCS' AND prod.codigo_producto = CASE WHEN cart.tipo_swap  = 1 THEN 'ST'
											                           WHEN cart.tipo_swap  = 2 THEN 'SM'
											                           WHEN cart.tipo_swap  = 3 THEN 'FR'
											                           WHEN cart.tipo_swap  = 4 THEN 'SP'
											                      END
             LEFT  JOIN VIEW_MONEDA                mon1 ON mon1.mncodmon = CASE WHEN @nTipoFlujo = 1 THEN cart.compra_moneda ELSE cart.venta_moneda END
             LEFT  JOIN VIEW_MONEDA                mon2 ON mon2.mncodmon = CASE WHEN @nTipoFlujo = 1 THEN cart.compra_moneda ELSE cart.venta_moneda END
             INNER JOIN (SELECT numero_operacion  AS numoper 
                              , MIN(numero_flujo) AS numfluj
                              , tipo_flujo AS tipfluj
                           FROM BacSwapSuda.dbo.CARTERA
                          WHERE tipo_flujo = @nTipoFlujo
                       GROUP BY numero_operacion, tipo_flujo) grup ON grup.numoper        = cart.numero_operacion
                                                                  AND grup.numfluj        = cart.numero_flujo
                                                                  AND grup.tipfluj        = cart.tipo_flujo
                                                                 AND (cart.rut_cliente 	  = @rutcliente OR @rutcliente  = 0) 
                                                                 AND (cart.codigo_cliente = @codcliente OR @codcliente  = 0)
                                                                 AND (cart.tipo_swap   	  = @nprodswap  OR @nproducto   = '')
  	              ORDER BY cart.numero_operacion, cart.numero_flujo, cart.tipo_flujo
   END

   DECLARE @nFilas NUMERIC(5)
       SET @nFilas = ( SELECT COUNT(1) FROM #TMP_RETORNO_FINAL)

   SELECT /*01*/ Operador       = Operador
      ,   /*02*/ Sistema        = Sistema
      ,   /*03*/ Producto       = Producto
      ,   /*04*/ RutCliente     = RutCliente
      ,   /*05*/ Nombre         = Nombre
      ,   /*06*/ NumContrato    = NumContrato
      ,   /*07*/ descripcion    = descripcion
      ,   /*08*/ catipoper      = catipoper
      ,   /*09*/ fecha          = fecha
      ,   /*10*/ cafecvcto      = cafecvcto
      ,   /*11*/ PzoRes         = PzoRes
      ,   /*12*/ camtomon1      = camtomon1
      ,   /*13*/ camtomon2      = camtomon2
      ,   /*14*/ catipcam       = catipcam
      ,   /*15*/ nMTM           = nMTM
      ,   /*16*/ RutMda1Mda2    = RutMda1Mda2
      ,   /*17*/ DescMda1Mda2   = DescMda1Mda2
      ,   /*18*/ catipmoda      = catipmoda
      ,   /*19*/ DirCli         = DirCli
      ,   /*20*/ FecEmision     = FecEmision
      ,   /*21*/ FecProceso     = FecProceso
      ,   /*22*/ HoraEmision    = HoraEmision
      ,   /*23*/ pcs_nNumOper   = pcs_nNumOper
      ,   /*24*/ pcs_nFlujo     = pcs_nFlujo
      ,   /*25*/ pcs_cFecInicio = pcs_cFecInicio
      ,   /*26*/ pcs_cFecVcto   = pcs_cFecVcto
      ,   /*27*/ pcs_cProxVcto  = pcs_cProxVcto
      ,   /*28*/ pcs_nNocional  = pcs_nNocional
      ,   /*29*/ pcs_nTasas     = pcs_nTasas
      ,   /*30*/ Filas          = @nFilas
      ,   /*31*/ Ejecutivo      = Ejecutivo
   FROM   #TMP_RETORNO_FINAL
   ORDER BY rutmda1mda2

END
GO
