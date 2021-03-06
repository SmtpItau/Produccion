USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_ANTICIPOS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INF_ANTICIPOS_SWAP]
   (   @dFechaDesde   DATETIME
   ,   @dFechaHasta   DATETIME
   ,   @cUsuario      VARCHAR(15)
   )

AS

BEGIN
   -- SP_INF_ANTICIPOS_SWAP '20070517', '20070517', 'pp'
   -- SP_INF_ANTICIPOS_SWAP '20140131', '20140131' , 'MAP'
   SET NOCOUNT ON

   DECLARE @cFechaEmision   CHAR(10)
          SET @cFechaEmision   = CONVERT(CHAR(10),GETDATE(),103)

   DECLARE @cHoraEmision    CHAR(10)
       SET @cHoraEmision    = CONVERT(CHAR(10),GETDATE(),108)

   DECLARE @cFechaProceso   CHAR(10)
       SET @cFechaProceso   = CONVERT(CHAR(10),(SELECT fechaproc FROM SWAPGENERAL),103)

   DECLARE @FechaAyer       datetime
       SET @FechaAyer      = ( Select fechaant FROM SWAPGENERAL )

   DECLARE @cSubTitulo      VARCHAR(50)
       SET @cSubTitulo      = CASE WHEN @dFechaDesde = @dFechaHasta THEN 'AL '       + CONVERT(CHAR(10),@dFechaDesde,103)
                                   ELSE                                  'DESDE EL ' + CONVERT(CHAR(10),@dFechaDesde,103) + ' HASTA EL ' + CONVERT(CHAR(10),@dFechaHasta,103)
                              END
							  
   CREATE TABLE #TMP_ANTICIPOS

   (   NUM_Contrato      NUMERIC(10)
   ,   NUM_Flujo         NUMERIC(10)
   ,   FEC_Anticipo      DATETIME
   ,   NOM_Cliente       VARCHAR(50)
   ,   MON_Valorizacion  CHAR(3)
   ,   MTM_Activo        FLOAT
   ,   MTM_Pasivo        FLOAT
   ,   MTM_Neto          FLOAT
   ,   MON_Liquidacion   CHAR(3)
   ,   MTO_Liquidacion   FLOAT
   ,   POR_Margen        FLOAT
   ,   MTO_Margen        FLOAT
   ,   MTO_MargenPeso    FLOAT
   ,   Total_Parcial     CHAR(7)
   ,   Producto          CHAR(25)
   ,   Nocional_Activo   FLOAT
   ,   Nocional_Pasivo   FLOAT
   ,   MON_Activo        CHAR(3)
   ,   MON_Pasivo        CHAR(3)
   ,   Nocional_Activo_Ori FLOAT
   ,   Nocional_Pasivo_Ori FLOAT
   )
   
   INSERT INTO #TMP_ANTICIPOS
   SELECT 'NUM_Contrato'      = numero_operacion
   ,      'NUM_Flujo'         = numero_flujo
   ,      'FEC_Anticipo'      = Fecha_Vence_Flujo
   ,      'NOM_Cliente'       = SUBSTRING(clnombre,1,50)
   ,      'MON_Valorizacion'  = '   '--, max( monv.mnnemo )
   ,      'MTM_Activo'        = sum( Valor_Mercado_Activo_Mda_Val )
   ,      'MTM_Pasivo'        = sum( Valor_Mercado_Pasivo_Mda_Val )
   ,      'MTM_Neto'          = max( Valor_Mercado_Mda_Val )
   ,      'MON_Liquidacion'   = '   '-- , max( mPag.mnnemo )
   ,      'MTO_Liquidacion'   = sum( Recibimos_Monto + Pagamos_Monto )
   ,      'POR_Margen'        = max( Porcentaje_Margen )
   ,      'MTO_Margen'        = max( Monto_Margen )
   ,      'MTO_MargenPeso'    = max( Monto_Margen_CLP )
   ,      'Total_Parcial'     = ( case when ( select max(C2.numero_flujo) 
                                              from cartera C2 
                                              where Cartera.Numero_OPeracion = C2.Numero_operacion  ) 
                                            <> Cartera.Numero_Flujo then 'PARCIAL' else 'TOTAL' end )
   ,      'Producto'          = ( case when max(tipo_Swap) = 1 then 'SWAP DE TASAS (IRS)' 
                                       when max(tipo_Swap) = 2 then 'SWAP DE MONEDAS (CCS)'
                                       when max(tipo_Swap) = 3 then 'FORWARD RATE (FRA)'
                                       when max(tipo_Swap) = 4 then 'SWAP PROMEDIO CAMARA' end )
   ,      'Nocional_Activo'    = 0.0
   ,      'Nocional_Pasivo'    = 0.0
   ,      'MON_Activo'         = '   '
   ,      'MON_Pasivo'         = '   '
   ,      'Nocional_Activo_Ori' = 0.0
   ,      'Nocional_Pasivo_Ori' = 0.0   
   FROM   CARTERA
          INNER JOIN BacParamSuda..CLIENTE     ON clrut = rut_cliente AND clcodigo = codigo_cliente
    WHERE Estado              = 'N' 
  --    AND Tipo_Flujo          = 1
      AND Fecha_Vence_Flujo   BETWEEN @dFechaDesde and @dFechaHasta
    group by numero_operacion
   ,         numero_flujo
   ,  Fecha_Vence_Flujo
   ,         SUBSTRING(clnombre,1,50)
   
   UPDATE #TMP_ANTICIPOS 
      Set 
            MON_Valorizacion = ( Select Mon.mnnemo from Cartera, BacParamSuda..MONEDA Mon where Mon.mncodmon = Moneda_Valorizacion  and numero_operacion = NUM_Contrato and Estado = 'N' and tipo_Flujo = 1 )
          , MON_Liquidacion  = ( Select Mon.mnnemo from Cartera, BacParamSuda..MONEDA Mon where Mon.mncodmon = recibimos_moneda  and numero_operacion = NUM_Contrato and Estado = 'N' and tipo_Flujo = 1 )
          , Nocional_Activo = ( select Compra_Amortiza from Cartera where numero_operacion = NUM_Contrato and Estado = 'N' and tipo_Flujo = 1 )
          , Nocional_Pasivo = ( select Venta_Amortiza from Cartera where numero_operacion = NUM_Contrato and Estado = 'N' and tipo_Flujo = 2 )
          , MON_Activo      = ( select Mon.mnnemo from Cartera, BacParamSuda..MONEDA Mon 
                                 where Mon.mncodmon = Compra_Moneda
                                 and   numero_operacion = NUM_Contrato
                                 and   estado = 'N' and tipo_flujo = 1 )
          , MON_Pasivo      = ( select Mon.mnnemo from Cartera, BacParamSuda..MONEDA Mon 
                                 where Mon.mncodmon = Venta_Moneda
                                 and   numero_operacion = NUM_Contrato
                                 and   estado = 'N' and tipo_flujo = 2 )         
          , Nocional_Activo_Ori = ( select max( Compra_Saldo + Compra_Amortiza ) from CarteraRes where numero_operacion = NUM_Contrato and tipo_Flujo = 1 and fecha_Proceso  = @FechaAyer and estado_flujo = 1)
          , Nocional_Pasivo_Ori = ( select max( Venta_Saldo + Venta_Amortiza ) from CarteraRes where numero_operacion = NUM_Contrato and   tipo_Flujo = 2  and fecha_proceso = @FechaAyer and estado_flujo = 1)
   IF (SELECT COUNT(1) FROM #TMP_ANTICIPOS) = 0
   BEGIN
      INSERT INTO #TMP_ANTICIPOS
      SELECT 'NUM_Contrato'      = 0
      ,      'NUM_Flujo'         = 0
      ,      'FEC_Anticipo'      = ''
      ,      'NOM_Cliente'       = ''
      ,      'MON_Valorizacion'  = ''
      ,      'MTM_Activo'        = 0
      ,      'MTM_Pasivo'        = 0
      ,      'MTM_Neto'          = 0
      ,      'MON_Liquidacion'   = ''
      ,      'MTO_Liquidacion'   = 0
      ,      'POR_Margen'        = 0
      ,      'MTO_Margen'        = 0
      ,      'MTO_MargenPeso'    = 0
      ,      'Total_Parcial'     = 'SinDat'
      ,      'Producto'          = 'Sin Datos'
      ,      'Nocional_Activo'   = 0.0
      ,      'Nocional_Pasivo'   = 0.0
      ,      'MON_Activo'        = '   '
      ,      'MON_Pasivo'        = '   '
      ,      'Nocional_Activo_Ori' = 0.0
      ,      'Nocional_Pasivo_Ori' = 0.0
   END
   
	DECLARE @BANNER VARBINARY(MAX),
			@fechaProceso DATETIME 
	SELECT @BANNER = cpg.BannerCorto
	FROM   BacParamSuda.DBO.Contratos_ParametrosGenerales cpg
   
   SELECT 'NUM_Contrato'      = NUM_Contrato
      ,   'NUM_Flujo'         = NUM_Flujo
      ,   'FEC_Anticipo'      = FEC_Anticipo
      ,   'NOM_Cliente'       = NOM_Cliente
      ,   'MON_Valorizacion'  = MON_Valorizacion
      ,   'MTM_Activo'        = MTM_Activo
      ,   'MTM_Pasivo'        = MTM_Pasivo
      ,   'MTM_Neto'          = MTM_Neto
      ,   'MON_Liquidacion'   = MON_Liquidacion
      ,   'MTO_Liquidacion'   = MTO_Liquidacion
      ,   'POR_Margen'        = POR_Margen
      ,   'MTO_Margen'        = MTO_Margen
      ,   'MTO_MargenPeso'    = MTO_MargenPeso
      ,   'FECHA_PROCESO'     = @cFechaProceso
      ,   'FECHA_EMISION'     = @cFechaEmision
      ,   'HORA_EMISION'      = @cHoraEmision
      ,   'USUARIO'        = @cUsuario
      ,   'SUBTITULO'         = @cSubTitulo
      ,   'Total_Parcial'     = Total_Parcial
      ,   'Producto'          = Producto
      ,      'Nocional_Activo'   = Nocional_Activo
      ,      'Nocional_Pasivo'   = Nocional_Pasivo
      ,      'MON_Activo'        = MON_Activo
      ,      'MON_Pasivo'        = MON_Pasivo
      ,      'Nocional_Activo_Ori' = Nocional_Activo_Ori
      ,      'Nocional_Pasivo_Ori' = Nocional_Pasivo_Ori
	  ,		'BannerCorto'				= @BANNER
   FROM   #TMP_ANTICIPOS

END

GO
