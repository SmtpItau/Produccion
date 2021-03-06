USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJOS_SWAP]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJOS_SWAP]
AS
BEGIN

   SET NOCOUNT ON

   -->     Lee Fecha desde la tabla de control para evitar consultas no necesarias
   DECLARE @AcFecProc   DATETIME
   DECLARE @AcFecAnte   DATETIME

    SELECT @AcFecProc   = fechaproc 
         , @AcFecAnte   = fechaant
      FROM SWAPGENERAL  WITH (NOLOCK)
     WHERE entidad      = '01'
   -->     Lee Fecha desde la tabla de control para evitar consultas no necesarias

   -->     Crea Tabla maestra con los Valore de Moneda para el DÃ­a   
   CREATE TABLE #VALOR_TC_CONTABLE
   (   vmcodigo   INTEGER   NOT NULL DEFAULT(0)
   ,   vmvalor    FLOAT     NOT NULL DEFAULT(0.0)
   )
   CREATE INDEX #ixt_VALOR_TC_CONTABLE ON #VALOR_TC_CONTABLE ( vmcodigo )

   INSERT INTO #VALOR_TC_CONTABLE EXECUTE SP_LEE_VALORES_MONEDA_TCRC @AcFecProc
   -->     Crea Tabla maestra con los Valore de Moneda para el DÃ­a

   -->     Asigna los Valores del DÃ­a
   DECLARE @ValUSDHoy  NUMERIC(18,2)
       SET @ValUSDHoy  = ISNULL((SELECT ISNULL(vmvalor, 0.0) FROM #VALOR_TC_CONTABLE WHERE vmcodigo =  13), 0.0)

   DECLARE @ValUFHoy   NUMERIC(18,2)
       SET @ValUFHoy   = ISNULL((SELECT ISNULL(vmvalor, 0.0) FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 998), 0.0)
   -->     Asigna los Valores del DÃ­a

   CREATE TABLE #NEOSOFT
   (   C_pais		      CHAR(3)
   ,   F_interfaz	      DATETIME
   ,   N_identificacion       VARCHAR(4)
   ,   C_empresa              VARCHAR(3)
   ,   C_interno	      CHAR(16)
   ,   Nro_Operacion          VARCHAR(20)
   ,   F_pago		      DATETIME
   ,   M_cuota_local	      NUMERIC(18,2)
   ,   M_amortizacion	      NUMERIC(18,2)
   ,   M_interes	      NUMERIC(18,2)
   ,   C_sucursal             CHAR(3)
   ,   C_interno_sucursal     VARCHAR(3)
   ,   Registros	      INTEGER
   ,   Tipo_Flujo	      VARCHAR(1)
   ,   M_cuota_local_Aux      NUMERIC(18,2)
   ,   M_interes_Aux          NUMERIC(18,2)
   ,   M_Amortizacion_Aux     NUMERIC(18,2)
   ,   Numero_Flujo           NUMERIC(9)
   ,   Marca                  CHAR(3)        -- MAP 20060816 Para Marcar si se procesÃ³ su interes negativo
   ,   TipoFlujo              INTEGER
   )
   CREATE INDEX #ittrf_NEOSOFT ON #NEOSOFT (Nro_Operacion, Numero_Flujo, TipoFlujo)

   -->    Crea Temporal de Cartera de Swap
   SELECT numero_operacion
        , numero_flujo
        , tipo_flujo
        , tipo_swap
        , fecha_inicio
        , fecha_inicio_flujo
        , fecha_termino
        , fecha_vence_flujo   
        , fechaLiquidacion
        , compra_moneda
        , venta_moneda
        , compra_capital
        , venta_capital
        , compra_amortiza
        , venta_amortiza
        , compra_saldo
        , venta_saldo
        , compra_interes
        , venta_interes
        , compra_spread
        , venta_spread
        , compra_codigo_tasa
        , venta_codigo_tasa
        , activo_clp_c08
        , pasivo_clp_c08
        , activo_mo_c08
        , pasivo_mo_c08
        , compra_base
        , venta_base
        , valormoneda              = CONVERT(FLOAT,0.0)
        , icorrelativo             = identity(int)
        , 'compra_flujo_adicional' = ISNULL(compra_flujo_adicional, 0)
        , 'venta_flujo_adicional'  = ISNULL(venta_flujo_adicional,  0)
        , compra_amortiza_clp      = CONVERT(FLOAT,0.0)
        , venta_amortiza_clp       = CONVERT(FLOAT,0.0)
        , IntercPrinc              = 1 --> Enciende Indicador de Intercambio de Nocionales.-  Juan Pablo Freire
        , UFFinal                  = CONVERT(FLOAT,0.0)
        , UFInicial                = CONVERT(FLOAT,0.0)
     INTO #CARTERA_VIGENTE_HOY 
     FROM CARTERA            WITH (NOLOCK) 
    WHERE fecha_Cierre      <= @AcFecProc
-- ' CER 12/11/2008 - Se comenta ya que se debe filtrar por la fecha de pago y no por la de vcto.     
      AND fechaLiquidacion > @AcFecProc
--    AND (Fecha_vence_flujo > @AcFecProc AND tipo_swap <> 3 OR fechaLiquidacion > @AcFecProc AND Tipo_swap = 3)
      AND Fecha_Termino      > @AcFecProc
      AND Estado            <> 'N'
      AND Estado            <> 'C'

   CREATE INDEX #ixt_CARTERA_VIGENTE_HOY ON #CARTERA_VIGENTE_HOY (numero_operacion, numero_flujo, tipo_flujo, tipo_swap)
   CREATE INDEX #icc_CARTERA_VIGENTE_HOY ON #CARTERA_VIGENTE_HOY (icorrelativo)
   -->    Crea Temporal de Cartera de Swap

   -->    Modela Amortizaciones Negativas
   UPDATE #CARTERA_VIGENTE_HOY
      SET compra_amortiza_clp = (compra_amortiza * -1) * vmvalor
     FROM #VALOR_TC_CONTABLE
    WHERE Tipo_Flujo          = 1
      and compra_amortiza     < 0
      and compra_moneda       = vmcodigo

   UPDATE #CARTERA_VIGENTE_HOY
      SET venta_amortiza_clp  = (venta_amortiza * -1) * vmvalor
     FROM #VALOR_TC_CONTABLE
    WHERE Tipo_Flujo          = 2
      and venta_amortiza      < 0
      and venta_moneda        = vmcodigo

   UPDATE cart
      SET cart.compra_amortiza= ISNULL((SELECT (paso.venta_amortiza_clp / vmvalor)
                                          FROM #CARTERA_VIGENTE_HOY paso
                                         WHERE paso.tipo_flujo          = 2
                                           and paso.numero_operacion    = cart.numero_operacion
                                           and paso.fecha_vence_flujo   = cart.fecha_vence_flujo
                                           and paso.venta_amortiza_clp <> 0), cart.Compra_Amortiza)
     FROM #CARTERA_VIGENTE_HOY cart
          INNER JOIN #VALOR_TC_CONTABLE ON vmcodigo = cart.compra_moneda
    WHERE cart.tipo_flujo     = 1

   UPDATE cart
      SET cart.venta_amortiza= ISNULL((SELECT (paso.compra_amortiza_clp / vmvalor)
                                         FROM #CARTERA_VIGENTE_HOY paso
                                        WHERE paso.tipo_flujo          = 1
                                          and paso.numero_operacion    = cart.numero_operacion
                                          and paso.fecha_vence_flujo   = cart.fecha_vence_flujo
                                          and paso.compra_amortiza_clp <> 0), cart.venta_Amortiza)
     FROM #CARTERA_VIGENTE_HOY cart
          INNER JOIN #VALOR_TC_CONTABLE ON vmcodigo = cart.venta_moneda
    WHERE cart.tipo_flujo     = 2
   -->    Modela Amortizaciones Negativas

   DELETE FROM #CARTERA_VIGENTE_HOY
         WHERE tipo_flujo   = 1
           AND compra_saldo + compra_Amortiza + compra_flujo_adicional <= 0

   DELETE FROM #CARTERA_VIGENTE_HOY
         WHERE tipo_flujo   = 2
           AND venta_saldo  + venta_Amortiza  + venta_flujo_adicional  <= 0

   UPDATE #CARTERA_VIGENTE_HOY
      SET valormoneda = vmvalor
     FROM #VALOR_TC_CONTABLE
    WHERE vmcodigo    = CASE WHEN tipo_flujo = 1 THEN compra_moneda ELSE venta_moneda END

   -->    Carga UF proyectada por contrato
   UPDATE #CARTERA_VIGENTE_HOY    
      SET valormoneda    = UFProyectada
        , UFFinal        = UFProyectada
        , UFInicial      = UFProyInicio
     FROM RELACION_CONTRATO_UFPROYECTADA
    WHERE FechaProceso   = @AcFecProc
      AND tipo_flujo     = 1
      AND compra_moneda  = 998
      AND NumeroContrato = numero_operacion
      AND TipoFlujo      = tipo_flujo
      AND NumeroFlujo    = numero_flujo

   UPDATE #CARTERA_VIGENTE_HOY    
      SET valormoneda    = UFProyectada
        , UFFinal        = UFProyectada
        , UFInicial      = UFProyInicio
     FROM RELACION_CONTRATO_UFPROYECTADA
    WHERE FechaProceso   = @AcFecProc
      AND tipo_flujo     = 2
      AND venta_moneda   = 998
      AND NumeroContrato = numero_operacion
      AND TipoFlujo      = tipo_flujo
      AND NumeroFlujo    = numero_flujo
   -->    Carga UF proyectada por contrato

   CREATE TABLE #OPERACIONES
   (   NumContrato   NUMERIC(9)    NOT NULL DEFAULT(0)
   ,   NumFlujo      NUMERIC(9)    NOT NULL DEFAULT(0)
   ,   TipoFlujo     NUMERIC(9)    NOT NULL DEFAULT(0)
   ,   Pago          DATETIME      NOT NULL DEFAULT('')
   ,   MtoCuota      NUMERIC(18,2) NOT NULL DEFAULT(0.0)
   ,   MtoAmortiza   NUMERIC(18,2) NOT NULL DEFAULT(0.0)
   ,   MtoInteres    NUMERIC(18,2) NOT NULL DEFAULT(0.0)
   )
   CREATE INDEX #ixxt_OPERACIONES ON #OPERACIONES (NumContrato, NumFlujo, TipoFlujo)


   -->    Genera Retorno Activo
   INSERT INTO #OPERACIONES
   SELECT NumContrato = numero_operacion
        , NumFlujo    = numero_flujo
        , TipoFlujo   = tipo_flujo
        , Pago        = fechaLiquidacion
        , MtoCuota    = CASE WHEN compra_moneda  = 999 THEN ROUND((compra_amortiza * intercprinc + activo_mo_c08 + compra_flujo_adicional), 0)
                             WHEN compra_moneda <> 999 THEN ROUND((compra_amortiza * intercprinc + activo_mo_c08 + compra_flujo_adicional) * valormoneda,0)
                        END
        , MtoAmortiza = CASE WHEN compra_moneda <> 999 THEN ROUND((compra_amortiza * intercprinc + compra_flujo_adicional) * valormoneda, 0)
                             WHEN compra_moneda  = 999 THEN ROUND( compra_amortiza * intercprinc + compra_flujo_adicional, 0) 
                        END
        , MtoInteres  = CASE WHEN compra_moneda <> 999 THEN ROUND(activo_mo_c08 * valormoneda, 0)
                             WHEN compra_moneda  = 999 THEN ROUND(activo_mo_c08, 0)
                        END
     FROM #CARTERA_VIGENTE_HOY
    WHERE tipo_flujo  = 1
   -->    Genera Retorno Activo


   -->    Genera Retorno Pasivo
   INSERT INTO #OPERACIONES
   SELECT NumContrato = numero_operacion
        , NumFlujo    = numero_flujo
        , TipoFlujo   = tipo_flujo
        , Pago        = fechaLiquidacion
        , MtoCuota    = CASE WHEN venta_moneda  = 999 THEN ROUND((venta_amortiza * intercprinc  + pasivo_mo_c08 + venta_flujo_adicional), 0)
                             WHEN venta_moneda <> 999 THEN ROUND((venta_amortiza * intercprinc  + pasivo_mo_c08 + venta_flujo_adicional) * valormoneda,0)
                        END
        , MtoAmortiza = CASE WHEN venta_moneda <> 999 THEN ROUND((venta_amortiza * intercprinc  + venta_flujo_adicional) * valormoneda, 0)
                             WHEN venta_moneda  = 999 THEN ROUND( venta_amortiza * intercprinc  + venta_flujo_adicional, 0) 
                        END
        , MtoInteres  = CASE WHEN venta_moneda <> 999 THEN ROUND(pasivo_mo_c08 * valormoneda, 0)
                             WHEN venta_moneda  = 999 THEN ROUND(pasivo_mo_c08, 0)
                        END
    FROM #CARTERA_VIGENTE_HOY
    WHERE tipo_flujo  = 2
   -->    Genera Retorno Pasivo

   -->    ------------------------------------------------------------------------
   -->    Recalcula el Flujo Vigente de cada uno de los Swap Promedio Camara en UF
      --> Flujo Recibimos
   SELECT contrato    = car.numero_operacion
        , flujo       = car.numero_flujo
-->     , Reajuste    = car.activo_clp_c08   --> car.activo_mo_c08
-->                   + ROUND((((fin.vmvalor - ini.vmvalor) * car.compra_capital * DATEDIFF(DAY, fecha_inicio_flujo, fecha_vence_flujo) / DATEDIFF(DAY, fecha_inicio_flujo, @AcFecProc) / fin.vmvalor) * @ValUFHoy),0)
        , Reajuste    = CASE WHEN compra_codigo_tasa = 13 THEN ROUND((car.activo_mo_c08 * UFFinal),0)
                             ELSE                              ROUND((car.activo_mo_c08 * UFFinal),0)
                        END
                      + ROUND( ((UFFinal - UFInicial) * car.compra_capital) ,0)
     INTO #CARTERA_ACTIVA
     FROM #CARTERA_VIGENTE_HOY car
      --> INNER JOIN BacParamSuda..VALOR_MONEDA ini ON ini.vmfecha = car.fecha_inicio_flujo and ini.vmcodigo = car.compra_moneda
      --> INNER JOIN BacParamSuda..VALOR_MONEDA Fin ON Fin.vmfecha = @AcFecProc             and Fin.vmcodigo = car.compra_moneda
    WHERE car.tipo_flujo    = 1
      and car.tipo_swap     = 4 --> Se saca comentario hoy 29-12-2008
      and car.compra_moneda = 998
-->      and car.numero_flujo  = (SELECT MIN(numero_flujo) FROM CARTERA with(nolock) WHERE numero_operacion = car.numero_operacion and tipo_flujo = 1)
  ORDER BY car.numero_operacion, car.numero_flujo
   
   UPDATE #OPERACIONES  
      SET MtoInteres    = Reajuste
-->     , MtoCuota      = MtoAmortiza + Reajuste
     FROM #CARTERA_ACTIVA
    WHERE NumContrato   = contrato
      AND NumFlujo      = flujo
      AND TipoFlujo     = 1


      --> Flujo Entregamos
   SELECT contrato    = car.numero_operacion
        , flujo       = car.numero_flujo
-->     , Reajuste    = car.pasivo_clp_c08   --> car.pasivo_mo_c08
-->                   + ROUND((((fin.vmvalor - ini.vmvalor) * car.venta_capital * DATEDIFF(DAY, fecha_vence_flujo, fecha_inicio_flujo) / DATEDIFF(DAY, @AcFecProc, fecha_inicio_flujo) / fin.vmvalor) * @ValUFHoy),0)
        , Reajuste    = CASE WHEN venta_codigo_tasa = 13 THEN ROUND((car.pasivo_mo_c08 * UFFinal),0)
                             ELSE                             ROUND((car.pasivo_mo_c08 * UFFinal),0)
                        END
                      + ROUND( ((UFFinal - UFInicial) * car.venta_capital) ,0)
     INTO #CARTERA_PASIVA
     FROM #CARTERA_VIGENTE_HOY car
      --> INNER JOIN BacParamSuda..VALOR_MONEDA ini ON ini.vmfecha = car.fecha_inicio_flujo and ini.vmcodigo = car.venta_moneda
      --> INNER JOIN BacParamSuda..VALOR_MONEDA Fin ON Fin.vmfecha = @AcFecProc             and Fin.vmcodigo = car.venta_moneda
    WHERE car.tipo_flujo    = 2
      and car.tipo_swap     = 4 --> Se saca comentario hoy 29-12-2008
      and car.venta_moneda  = 998
-->      and car.numero_flujo  = (SELECT MIN(numero_flujo) FROM CARTERA with(nolock) WHERE numero_operacion = car.numero_operacion and tipo_flujo = 1)
  ORDER BY car.numero_operacion, car.numero_flujo

   UPDATE #OPERACIONES  
      SET MtoInteres    = Reajuste
-->     , MtoCuota      = MtoAmortiza + Reajuste
     FROM #CARTERA_PASIVA
    WHERE NumContrato   = contrato
      AND NumFlujo      = flujo
      AND TipoFlujo     = 2
   -->    Recalcula el Flujo Vigente de cada uno de los Swap Promedio Camara en UF
   -->    ------------------------------------------------------------------------


   -->    Crea la Salida Final por Flujo 
   INSERT INTO #NEOSOFT
   SELECT 'C_pais'		= 'CL'
      ,   'F_interfaz'		= GETDATE()
      ,   'N_identificacion'	= 'FD52'
      ,   'C_empresa'		= '001'
      ,   'C_interno'		= 'MD02'
      ,   'Nro_operacion'   	= NumContrato
      ,   'F_pago'		= Pago
      ,   'M_cuota_local'	= MtoAmortiza + MtoInteres --> MtoCuota
      ,   'M_amortizacion'	= MtoAmortiza
      ,   'M_interes'		= MtoInteres 
      ,   'C_sucursal'		= '1  '
      ,   'C_interno_sucursal'	= ''
      ,   'Registros'		= (SELECT COUNT(1) FROM #OPERACIONES)
      ,   'Tipo_Flujo'		= CASE WHEN TipoFlujo = 1 THEN 'A' ELSE 'P' END
      ,   'M_cuota_local_Aux'   = 0
      ,   'M_interes_Aux'       = 0
      ,   'M_Amortizacion_Aux'  = 0
      ,   'Numero_Flujo'        = NumFlujo
      ,   'Marca'               = ' '
      ,   'TipoFlujo'           = TipoFlujo
   FROM   #OPERACIONES

   UPDATE #NEOSOFT
      SET M_cuota_local  = ABS(M_cuota_local)
        , M_amortizacion = ABS(M_amortizacion)
        , M_interes      = ABS(M_interes)
        , Tipo_Flujo     = CASE WHEN Tipo_Flujo = 'A' THEN 'P' ELSE 'A' END
    WHERE M_amortizacion < 0

   DELETE FROM #NEOSOFT
         WHERE (M_interes + M_amortizacion + M_cuota_local) = 0

   SELECT C_pais 
        , F_interfaz
        , N_identificacion
        , C_empresa
        , C_interno
        , Nro_Operacion
        , F_pago
        , ABS((M_cuota_local))
        , ABS((M_amortizacion))
        , ABS((M_interes))
        , C_sucursal
        , C_interno_sucursal
        , Registros
        , Tipo_Flujo
        , M_cuota_local_Aux
        , M_interes_Aux
        , M_Amortizacion_Aux
        , Numero_Flujo
        , Marca
        , TipoFlujo   
      FROM #NEOSOFT 
  ORDER BY Nro_Operacion, TipoFlujo, F_pago 

END

GO
