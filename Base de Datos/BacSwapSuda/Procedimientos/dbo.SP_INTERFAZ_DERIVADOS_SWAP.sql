USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DERIVADOS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_DERIVADOS_SWAP]
AS
BEGIN
   -- SP_INTERFAZ_DERIVADOS_SWAP, contingencia
   -- MAP 20071214 : Redefinición del flujo vigente, se utilizara campo Estado_Flujo
   -- Swap: Guardar Como    
   -- Reemplazar vRazActivoAjus_Mn  con Compra_Mercado_Clp

   SET NOCOUNT ON

   DECLARE @Max        INTEGER
   ,       @Fecha      DATETIME
   ,       @Fecha_FM   DATETIME

   SELECT  @Fecha = fechaproc 
   FROM    SWAPGENERAL

   /* BUSCA VALOR DE MONEDA PARA FIN DE MES -------------------------------------------- */
   SELECT @Fecha_FM = DATEADD(MONTH, -1, @Fecha)
   SELECT @Fecha_FM = MAX(VMFECHA) FROM VIEW_VALOR_MONEDA WHERE MONTH(VMFECHA) = MONTH(@Fecha_FM) AND YEAR(VMFECHA) = YEAR(@Fecha_FM)

   IF (SELECT MONTH(fechaproc) FROM SWAPGENERAL) <> (SELECT MONTH(fechaprox) FROM SWAPGENERAL)
      SELECT @Fecha_FM = @Fecha

   SELECT vmcodigo , vmvalor
   INTO   #ValMon
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE  vmfecha = @Fecha -- @Fecha_FM

   INSERT INTO #ValMon SELECT 13, vmvalor FROM #ValMon WHERE vmcodigo = 994
   INSERT INTO #ValMon SELECT 999 , 1.0

   SELECT vmcodigo , vmvalor 
   INTO   #VALOR_TC_CONTABLE
   FROM   #ValMon
   WHERE  vmcodigo IN(994,995,997,998,999)

   INSERT INTO #VALOR_TC_CONTABLE
   SELECT CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END , Tipo_Cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE
   WHERE  Fecha    = @Fecha 
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)
   

   /* ---------------------------------------------------------------------------------- */
   CREATE TABLE #NEOSOFT
   (   C_pais		CHAR(3)
   ,   F_interfaz	DATETIME
   ,   N_identificacion VARCHAR(4)
   ,   C_empresa        VARCHAR(3)
   ,   F_producto       CHAR(4)
   ,   T_producto       CHAR(4)
   ,   C_interno	CHAR(16)
   ,   C_producto       CHAR(1)
   ,   Tip_producto     CHAR(1)
   ,   Fecha_contable   DATETIME
   ,   C_sucursal       CHAR(3)
   ,   N_operacion     	VARCHAR(20)
   ,   I_cliente	VARCHAR(12)
   ,   D_cliente	VARCHAR(1)
   ,   F_inicio		DATETIME
   ,   F_vencimiento	DATETIME
   ,   M_compra		VARCHAR(3)
   ,   M_mda_comprada	NUMERIC(18,2)
   ,   M_venta		VARCHAR(3)
   ,   M_mda_vendida	NUMERIC(18,2)
   ,   T_vencimiento	VARCHAR(1)
   ,   Registros	INTEGER
   ,   tipoflujo	NUMERIC(1)
   ,   numero_armado    NUMERIC(20)
   ,   N_Flujo          NUMERIC(5)
   ,   M_compra_C08 	NUMERIC(18,2)
   ,   M_venta_C08  	NUMERIC(18,2)
   ,   T_tasa_compra 	VARCHAR(2)
   ,   T_tasa_venta	VARCHAR(2)
   ,   F_cambio_compra	CHAR(8)
   ,   F_cambio_venta	CHAR(8)
   ,   V_presen_activo	NUMERIC(18,2)
   ,   V_presen_pasivo	NUMERIC(18,2)
   ,   Mda_Pago_compra  VARCHAR(3)
   ,   Mda_Pago_venta   VARCHAR(3)
   )

   SELECT DISTINCT   
         'OpNumero_Operacion' = C.Numero_Operacion 
   ,     'OpRut_cliente'      = C.Rut_cliente
   ,     'OpCodigo_cliente'   = C.Codigo_cliente
   ,     'OpFecha_Cierre'     = C.Fecha_Cierre
   ,     'OpT_cartera'        = ISNULL((SELECT ccn_codigo_nuevo FROM bacparamsuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = C.car_Cartera_Normativa),4)
   ,     'OpModalidad'        = CASE WHEN C.modalidad_pago = 'E' THEN 'D' ELSE C.modalidad_pago END
   INTO  #Operaciones
   FROM  CARTERA              C 
   WHERE ( ( ( Fecha_Termino        > @Fecha and Tipo_Swap <> 3 ) or ( Tipo_Swap = 3 and FechaLiquidacion > @Fecha )  )
         -- MAP 20080115 Se corrige problema de NEOSOFT, no tomaba operaciones de un Flujo
         and (     compra_saldo + Compra_Amortiza > 0 and tipo_flujo = 1 
                or venta_saldo + venta_Amortiza > 0 and tipo_flujo = 2
                or Compra_Flujo_Adicional <> 0 and tipo_flujo = 1       -- 5203 Contingencia  
                or Venta_Flujo_Adicional <> 0 and tipo_flujo = 2        -- 5203 Contingencia
              ) 
         
         and estado <> 'N'  and estado <> 'C' )

   SELECT * 
   INTO   #FluCarVig
   FROM   CARTERA  
			inner join
			(	select	folio	= numero_operacion
					,	tipo	= tipo_flujo
					,	Flujo	= min( numero_flujo )
				from	BacSwapSuda.dbo.CARTERA with(nolock)
				where	(	Estado_Flujo	= 1
					and		Fecha_Termino	> @Fecha AND Tipo_Swap <> 3 and estado <> 'C'
						)
					or	(	Tipo_Swap		= 3 
						and FechaLiquidacion> @Fecha 
						)
				group 
				by		numero_operacion
					,	tipo_flujo

			)	grp		On	grp.folio	= numero_operacion
						and	grp.tipo	= tipo_flujo
						and	grp.Flujo	= numero_flujo
   WHERE (  Estado_Flujo	= 1
	AND		Fecha_Termino	> @Fecha AND Tipo_Swap <> 3 and estado <> 'C'
		)
	or	(	Tipo_Swap			= 3 
		and FechaLiquidacion	> @Fecha 
		)



   INSERT INTO #NEOSOFT
   SELECT DISTINCT
          'C_pais'		= 'CL'
   ,      'F_interfaz'		= GETDATE()
   ,      'N_identificacion'	= 'DE52'
   ,      'C_empresa'		= '001'
   ,      'F_producto'  	= 'MDIR'
   ,      'T_producto'    	= 'MDIR'
  ,      'C_interno'		= 'MD02'
   ,      'C_producto'		= SPACE(1)
   ,      'Tip_producto'	= 'M'
   ,      'fecha_contable' 	= @Fecha
   ,      'C_sucursal'		= '1  '
   ,      'N_operacion'   	= CONVERT(VARCHAR(20),OpNumero_operacion)
,      'rut'           	= CONVERT(CHAR(9),OpRut_cliente)
   ,      'dig'           	= ISNULL(Cldv,'0')
   ,      'fecha_inic'    	= OpFecha_Cierre
   ,      'fecha_vcto'    	= (SELECT MAX(Fechaliquidacion) FROM CARTERA As  Car WHERE Numero_operacion = OpNumero_operacion)
   ,      'M_compra'    	= ISNULL((SELECT MAX(CONVERT(VARCHAR(3),compra_moneda)) FROM CARTERA    WHERE Numero_operacion = OpNumero_operacion AND Tipo_Flujo = 1),'   ')
   ,      'M_mda_comprada'    	= ISNULL((SELECT compra_capital                         FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 1),0)
   ,      'M_venta'    		= ISNULL((SELECT MAX(CONVERT(VARCHAR(3),venta_moneda))  FROM CARTERA    WHERE Numero_operacion = OpNumero_operacion AND Tipo_Flujo = 2),'   ')
   ,      'M_mda_vendida'     	= ISNULL((SELECT venta_capital                          FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 2),0)
   ,      'T_vencimiento'      	= OpModalidad
   ,      'Registros'		= 0
   ,      'tipoflujo'		= 1
   ,      'numero_armado'	= CONVERT(VARCHAR(10),Opnumero_operacion)
   ,      'N_Flujo'             = ISNULL((SELECT numero_flujo FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 1 ), 0 )
   ,      'M_compra_C08' 	= 0.0
   ,      'M_venta_C08' 	= 0.0
   ,      'T_tasa_compra' 	= ISNULL((SELECT CASE WHEN compra_codigo_tasa  = 0 THEN 'F'      ELSE 'V' END FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 1),' ')
   ,      'T_tasa_venta'	= ISNULL((SELECT CASE WHEN venta_codigo_tasa   = 0 THEN 'F'      ELSE 'V' END FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 2),' ')
   ,      'F_cambio_compra'	= ISNULL((SELECT CASE WHEN compra_codigo_tasa  = 0 THEN SPACE(8) ELSE CONVERT(CHAR(8),fecha_vence_flujo,112) END
                                            FROM #FluCarVig WHERE numero_operacion = OpNumero_Operacion AND Tipo_flujo = 1), SPACE(8))
   ,      'F_cambio_venta'	= ISNULL((SELECT CASE WHEN venta_codigo_tasa = 0 THEN SPACE(8) ELSE CONVERT(CHAR(8),fecha_vence_flujo,112) END
                                            FROM #FluCarVig WHERE numero_operacion = OpNumero_Operacion AND Tipo_flujo = 2), SPACE(8)) 
   ,      'V_presen_activo'     = ISNULL((SELECT DISTINCT compra_mercado_clp FROM CARTERA CarAux WHERE CarAux.Numero_Operacion = Car.OpNumero_Operacion AND CarAux.Tipo_Flujo = 1),0)
   ,      'V_presen_pasivo'     = ISNULL((SELECT DISTINCT Venta_mercado_clp FROM CARTERA CarAux WHERE CarAux.Numero_Operacion = Car.OpNumero_Operacion AND CarAux.Tipo_Flujo = 2),0)
   ,      'Mda_Pago_compra'    	= ISNULL((SELECT MAX(CONVERT(VARCHAR(3),recibimos_moneda)) FROM CARTERA    WHERE Numero_operacion = OpNumero_operacion AND Tipo_Flujo = 1),'   ')
   ,      'Mda_Pago_venta'    	= ISNULL((SELECT MAX(CONVERT(VARCHAR(3),pagamos_moneda)) FROM CARTERA    WHERE Numero_operacion = OpNumero_operacion AND Tipo_Flujo = 2),'   ')
   FROM  #Operaciones	        Car 
         LEFT JOIN BacParamSuda..CLIENTE ON clrut = Car.Oprut_cliente AND clcodigo = Car.Opcodigo_cliente
   ,     BacParamSuda..ENTIDAD

   SELECT @Max      = COUNT(1)
   FROM   #NEOSOFT

   UPDATE #NEOSOFT 
   SET    registros = @Max

   SELECT C_pais           = C_pais
   ,      F_interfaz       = CONVERT(CHAR(8),F_interfaz,112)
   ,      N_identificacion = N_identificacion
   ,      C_empresa        = C_empresa
   ,      F_producto       = F_producto
   ,      T_producto       = T_producto
   ,      C_interno        = C_interno
   ,      C_producto       = C_producto
   ,      Tip_producto     = Tip_producto
   ,      Fecha_contable   = CONVERT(CHAR(8),Fecha_contable,112)
   ,      C_sucursal       = C_sucursal
   ,      N_operacion      = N_operacion
   ,      I_cliente        = I_cliente
   ,      D_cliente        = D_cliente
   ,      F_inicio         = CONVERT(CHAR(8),F_inicio,112)
   ,      F_vencimiento    = CONVERT(CHAR(8),F_vencimiento,112)
   ,      M_compra         = M_compra
   ,  M_mda_comprada   = M_mda_comprada
   ,      M_venta         = M_venta
   ,      M_mda_vendida    = M_mda_vendida
   ,      T_vencimiento    = T_vencimiento
   ,      Registros        = Registros
   ,      tipoflujo        = tipoflujo
   ,      numero_armado    = numero_armado
   , N_flujo          = N_flujo
   ,      M_compra_C08     = M_compra_C08
   ,      M_venta_C08      = M_venta_C08
   ,      T_tasa_compra    = T_tasa_compra
   ,      T_tasa_venta     = T_tasa_venta
   ,   F_cambio_compra  = F_cambio_compra
   ,      F_cambio_venta   = F_cambio_venta
   ,      V_presen_activo  = V_presen_activo
   ,      V_presen_pasivo  = V_presen_pasivo
   ,      Mda_Pago_compra  = Mda_Pago_compra
   ,      Mda_Pago_venta   = Mda_Pago_venta
   FROM   #NEOSOFT

END

GO
