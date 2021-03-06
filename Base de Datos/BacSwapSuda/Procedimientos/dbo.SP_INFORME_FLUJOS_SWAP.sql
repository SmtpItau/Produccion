USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_FLUJOS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_FLUJOS_SWAP]  
   (   @MiFecha   DATETIME
   ,   @MiUsuario VARCHAR(15) = 'Administra'
   )
AS
BEGIN
-- Swap: MAP Abril 2008 Guardar Como, Flujo adicional
-- Sp_Informe_Flujos_Swap '20080909', 'MNAVARRO'  
-- Sp_Informe_Flujos_SwapPromCam '20070430', 'MNAVARRO' 
-- select fechaliquidacion, * from cartera order by fechaliquidacion
   SET NOCOUNT ON

   DECLARE @FlujoAdicionalActivo float
   select  @FlujoAdicionalActivo = 0
   DECLARE @FlujoAdicionalPasivo float
   select  @FlujoAdicionalPasivo = 0

   DECLARE @EstadoTasa VARCHAR(20)
   DECLARE @FechaProceso datetime

   SELECT  @EstadoTasa = CASE WHEN devengo = 0 THEN 'Tasa No Actualizada'
                              WHEN devengo = 1 THEN 'Tasa Actualizada'
                         END
          , @FechaProceso = fechaproc 
   FROM    SWAPGENERAL

   SELECT  @EstadoTasa     = CASE WHEN Vencimientos = 0 THEN 'Tasa ICP No Actualizada'
                                  WHEN Vencimientos = 1 THEN 'Tasa ICP Actualizada'
                             END
   FROM    SWAPGENERAL

   Select VmCodigo , VmValor 
   into #Valor_Moneda
     from BacParamSuda..Valor_Moneda 
          where vmfecha = @MiFecha

   insert into #Valor_Moneda
    select 13, vmvalor from BacParamSuda..Valor_Moneda 
                            where vmfecha = @MiFecha and vmcodigo = 994

   insert into #Valor_Moneda
    select 999, 1


   CREATE TABLE #TmpFlujosSwap
   (   Indice        INTEGER      NOT NULL DEFAULT(0)
   ,   Operacion     NUMERIC(9)   NOT NULL DEFAULT(0)
   ,   ActivoFechaInicio   DATETIME     NOT NULL DEFAULT('')
   ,   PasivoFechaInicio   DATETIME     NOT NULL DEFAULT('')
   ,   ActivoFechaTermino  DATETIME     NOT NULL DEFAULT('')
   ,   PasivoFechaTermino  DATETIME     NOT NULL DEFAULT('')

   ,   ActivoMoneda         INTEGER      NOT NULL DEFAULT(0)
   ,   ActivoTipoTasa       INTEGER      NOT NULL DEFAULT(0)
   ,   ActivoValorTasa      FLOAT        NOT NULL DEFAULT(0.0)
   ,   ActivoCapital        FLOAT        NOT NULL DEFAULT(0.0)
   ,   ActivoAmortizacion   FLOAT        NOT NULL DEFAULT(0.0)
   ,   ActivoInteres        FLOAT        NOT NULL DEFAULT(0.0)

   ,   PasivoMoneda         INTEGER      NOT NULL DEFAULT(0)
   ,   PasivoTipoTasa       INTEGER      NOT NULL DEFAULT(0)
   ,   PasivoValorTasa      FLOAT        NOT NULL DEFAULT(0.0)
   ,   PasivoCapital        FLOAT        NOT NULL DEFAULT(0.0)
   ,   PasivoAmortizacion   FLOAT        NOT NULL DEFAULT(0.0)
   ,   PasivoInteres        FLOAT        NOT NULL DEFAULT(0.0)


   ,   Compensacion      FLOAT        NOT NULL DEFAULT(0.0)
   ,   ActivoPrxVcto     DATETIME     NOT NULL DEFAULT('')
   ,   PasivoPrxVcto     DATETIME     NOT NULL DEFAULT('')
   ,   ActivoNroTotFlu   INTEGER      NOT NULL DEFAULT(0)
   ,   PasivoNroTotFlu   INTEGER      NOT NULL DEFAULT(0)

   ,   ActivoNroFlu INTEGER      NOT NULL DEFAULT(0)
   ,   PasivoNroFlu INTEGER      NOT NULL DEFAULT(0)

   ,   Tipo_Swap     Numeric(9)   NOT NULL DEFAULT(0)
   ,   modalidad_pago Char(1)     NOT NULL DEFAULT('')
   ,   IntercPrinc   Numeric(1)   NOT NULL DEFAULT('')
   ,   ActivoMonedaPago INTEGER   NOT NULL DEFAULT(0)
   ,   PasivoMonedaPago INTEGER   NOT NULL DEFAULT(0)
   ,   ActivoFormaPago  INTEGER   NOT NULL DEFAULT(0)
   ,   PasivoFormaPago  INTEGER   NOT NULL DEFAULT(0)
   ,   ActivoMtoPagoEF     FLOAT     NOT NULL DEFAULT(0.0)
   ,   PasivoMtoPagoEF     FLOAT     NOT NULL DEFAULT(0.0)
   ,   ActivoFlujoAdicional FLOAT        NOT NULL DEFAULT(0.0)
   ,   PasivoFlujoAdicional FLOAT        NOT NULL DEFAULT(0.0)


   )
   

   select *
   into #Informe from cartera    where fechaLiquidacion >= @MiFecha and estado <> 'C' and estado <> 'N'
   union
   select * 
              from carterahis where fechaLiquidacion >= @MiFecha and estado <> 'C' and estado <> 'N'
   

   SELECT iOperacion       = numero_operacion
   ,      Flujo            = numero_flujo
   ,      TipoFlujo        = tipo_flujo
   ,      InicioFlujo      = fecha_inicio_flujo
   ,      VctoFlujo        = fecha_vence_flujo
   ,      Moneda           = compra_moneda
   ,      TipoTasa         = compra_codigo_tasa
   ,      ValorTasa        = compra_valor_tasa
   ,      Capital          = compra_capital
   ,      Amortizacion     = compra_amortiza -- Se mostrará como concepto
   ,      FlujoAdicional   = Compra_Flujo_Adicional 
   ,      Interes          = compra_interes
   ,      Correla          = Identity(Int)
   ,      ProxVcto         = fecha_vence_flujo
   ,      TotFlujos        = numero_flujo
   ,      Tipo_swap          
   ,      modalidad_pago 
   ,      IntercPrinc  
   ,      Recibimos_Documento
   ,      Pagamos_Documento
   ,      Recibimos_Moneda
   ,      Pagamos_Moneda

    --    Se convierte solo si es necesario
   ,      Monto_Flujo      = ( compra_amortiza * IntercPrinc + compra_interes  + Compra_Flujo_Adicional  ) * 
                             ( case when Compra_Moneda = Recibimos_Moneda then 1 
                                    else -- Convertir 
                                      isnull( RecibVM.VmValor, 1) / ( case when isnull( RecibVMPag.VmValor,1) <> 0 then isnull(RecibVMPag.VmValor,1) else 1  end ) end  )
   into   #TipoFlujo_1
   from   #Informe
          LEFT JOIN #Valor_Moneda                       RecibVM    ON RecibVM.Vmcodigo      = Compra_Moneda 
          LEFT JOIN #Valor_Moneda                       RecibVMPag ON RecibVMPag.Vmcodigo   = Recibimos_Moneda 
   where  fechaLiquidacion  = @MiFecha
   and    tipo_flujo         = 1
   order by numero_operacion



   SELECT iOperacion      = numero_operacion
   ,      Flujo           = numero_flujo
   ,      TipoFlujo       = tipo_flujo
   ,      InicioFlujo     = fecha_inicio_flujo
   ,      VctoFlujo       = fecha_vence_flujo
   ,      Moneda          = venta_moneda
   ,      TipoTasa        = venta_codigo_tasa
   ,      ValorTasa       = venta_valor_tasa
   ,      Capital         = venta_capital
   ,      Amortizacion    = venta_amortiza 
   ,      FlujoAdicional  = Venta_Flujo_Adicional 
   ,      Interes         = venta_interes
   ,      Correla         = Identity(Int)
   ,      ProxVcto        = fecha_vence_flujo
   ,      TotFlujos       = numero_flujo
   ,      Tipo_swap        
   ,      modalidad_pago 
   ,      IntercPrinc   
   ,      Recibimos_Documento
   ,      Pagamos_Documento
   ,      Recibimos_Moneda
   ,      Pagamos_Moneda
    --    Se convierte solo si es necesario
   ,      Monto_Flujo      = ( venta_amortiza * IntercPrinc + venta_interes + Venta_Flujo_Adicional ) * 
                             ( case when Venta_Moneda = Pagamos_Moneda then 1 
                                    else -- Convertir 
                                      isnull( EntreVM.VmValor,1 ) / ( case when isnull( EntreVMPag.VmValor,1) <> 0 then isnull(EntreVMPag.VmValor,1) else 1  end ) end  )
   into   #TipoFlujo_2
   from   #Informe
          LEFT JOIN #Valor_Moneda                       EntreVM    ON EntreVM.Vmcodigo      = Venta_Moneda 
          LEFT JOIN #Valor_Moneda                       EntreVMPag ON EntreVMPag.Vmcodigo   = Pagamos_Moneda
   where  fechaLiquidacion = @MiFecha
   and    tipo_flujo        = 2
   order by numero_operacion
   


   UPDATE #TipoFlujo_1
   SET    TotFlujos         = (select max( I.numero_flujo ) from #Informe As I 
                                where I.Numero_operacion = #TipoFlujo_1.iOperacion
                                and   I.Tipo_flujo = 1 )
   FROM   #Informe
   WHERE  /*tipo_swap         = 4
   and    */ iOperacion        = numero_operacion
   and    tipo_flujo        = 1 

   UPDATE #TipoFlujo_1
   SET    ProxVcto          = fechaLiquidacion
   FROM   #Informe
   WHERE  iOperacion        = numero_operacion
   and    numero_flujo      = Flujo + 1
   and    tipo_flujo        = 1 


   UPDATE #TipoFlujo_2
   SET    TotFlujos         = ( select max( I.numero_flujo ) from #Informe As I 
                                where I.Numero_operacion = #TipoFlujo_2.iOperacion
                                and   I.Tipo_flujo = 2 )
   FROM   #Informe
   WHERE  iOperacion        = numero_operacion
   and    tipo_flujo        = 2


   UPDATE #TipoFlujo_2
   SET    ProxVcto          = fechaLiquidacion
   FROM   #Informe
   WHERE  iOperacion        = numero_operacion
   and    numero_flujo      = Flujo + 1
   and    tipo_flujo        = 2

   DECLARE @FlujosEntregamos   INTEGER
   ,       @FlujosRecibimos    INTEGER

   SELECT  @FlujosEntregamos = 0
   SELECT  @FlujosRecibimos  = 0

   SELECT  @FlujosEntregamos = COUNT(1) FROM #TipoFlujo_1
   SELECT  @FlujosRecibimos  = COUNT(1) FROM #TipoFlujo_2


   IF @FlujosEntregamos >= @FlujosRecibimos
   BEGIN
      -- ADVERTENCIA: COnservar el orden del CREATE
      INSERT INTO #TmpFlujosSwap
      SELECT Indice    = Correla
      ,      Operacion = iOperacion
      ,      ActivoFechaInicio = InicioFlujo
      ,      PasivoFechaInicio = convert( datetime, '1900/01/01' )
      ,      ActivoFechaTermino = VctoFlujo
      ,      PasivoFechaTermino = convert( datetime, '1900/01/01' )

      ,      ActivoMoneda       = Moneda
      ,      ActivoTipoTasa     = TipoTasa
      ,      ActivoValorTasa    = ValorTasa
      ,      ActivoCapital      = Capital
      ,      ActivoAmortizacion = Amortizacion
      ,      ActivoInteres      = Interes
      

      ,      PasivoMoneda       = 0
      ,      PasivoTipoTasa     = 0
      ,      PasivoValorTasa    = 0
      ,      PasivoCapital      = 0
      ,      PasivoAmortizacion = 0
      ,      PasivoInteres      = 0

      ,      Compensacion       = Monto_Flujo 

      ,      ActivoPrxVcto      = ProxVcto
      ,      PasivoPrxVcto      = convert(datetime,'1900/01/01')
      ,      ActivoNroTotFlu    = TotFlujos
      ,      PasivoNroTotFlu    = 0

      ,      ActivoNroFlu       = Flujo
      ,      PasivoNroFlu       = 0
      ,      Tipo_swap            
      ,      modalidad_pago 
      ,      IntercPrinc   

      ,      ActivoMonedaPago = Recibimos_Moneda
      ,      PasivoMonedaPago = 0
      ,      ActivoFormaPago  = Recibimos_Documento
      ,      PasivoFormaPago  = 0
      ,      ActivoMtoPagoEF  = Monto_Flujo
      ,      PasivoMtoPagoEF  = 0
      ,      ActivoFlujoAdicional = FlujoAdicional
      ,      PasivoFlujoAdicional = 0

      
      FROM   #TipoFlujo_1



      UPDATE #TmpFlujosSwap
      SET    PasivoMoneda       = Moneda
      ,      PasivoTipoTasa     = TipoTasa
      ,      PasivoValorTasa    = ValorTasa
      ,      PasivoCapital      = Capital
      ,      PasivoAmortizacion = Amortizacion
      ,      PasivoInteres      = Interes
      ,      Compensacion       = ( Compensacion - Monto_Flujo )
      ,      PasivoPrxVcto      = ProxVcto
      ,      PasivoNroTotFlu    = TotFlujos
      ,      PasivoNroFlu       = Flujo
      ,      PasivoFechaInicio  = InicioFlujo 
      ,      PasivoFechaTermino = VctoFlujo 
      ,      PasivoMonedaPago = Pagamos_Moneda
      ,      PasivoFormaPago  = Pagamos_Documento
      ,      PasivoMtoPagoEF  = Monto_Flujo
      ,      PasivoFlujoAdicional = FlujoAdicional

      FROM   #TipoFlujo_2
      WHERE  Operacion     = iOperacion
--    WHERE  Indice        = Correla

   END ELSE
   BEGIN
       
      INSERT INTO #TmpFlujosSwap  

      -- ADVERTENCIA: COnservar el orden del CREATE
      SELECT Indice    = Correla
      ,      OPeracion = iOperacion
      ,      ActivoFechaInicio = convert( datetime, '1900/01/01' )
      ,      PasivoFechaInicio = InicioFlujo
      ,      ActivoFechaTermino = convert( datetime, '1900/01/01' )
      ,      PasivoFechaTermino = VctoFlujo
      ,      ActivoMoneda        = 0 
      ,      ActivoTipoTasa      = 0 
      ,      ActivoValorTasa     = 0.0 
      ,      ActivoCapital       = 0.0 
      ,      ActivoAmortizacion  = 0.0 
      ,      ActivoInteres       = 0.0 
      ,      PasivoMoneda        = Moneda
      ,      PasivoTipoTasa      = TipoTasa
      ,      PasivoValorTasa     = ValorTasa
      ,      PasivoCapital       = Capital
      ,      PasivoAmortizacion  = Amortizacion
      ,      PasivoInteres       = Interes 
      ,      Compensacion        = - Monto_Flujo
      ,      ActivoPrxVcto  = convert(datetime,'1900/01/01')
      ,      PasivoPrxVcto  = ProxVcto
      ,      ActivoNroTotFlu  = 0
      ,      PasivoNroTotFlu  = TotFlujos
      ,      ActivoNroFlu     = 0
      ,      PasivoNroFlu     = Flujo
      ,      Tipo_swap        
      ,      modalidad_pago 
      ,      IntercPrinc   
      ,      ActivoMonedaPago = 0
      ,      PasivoMonedaPago = Pagamos_Moneda
      ,      ActivoFormaPago  = 0
      ,      PasivoFormaPago  = Pagamos_Documento
      ,      ActivoMtoPagoEF  = 0
      ,      PasivoMtoPagoEF  = Monto_Flujo
      ,      ActivoFlujoAdcional = 0
     ,       PasivoFlujoAdicional = FlujoAdicional

      FROM   #TipoFlujo_2

      UPDATE #TmpFlujosSwap
      SET    ActivoMoneda        = Moneda
      ,      ActivoTipoTasa      = TipoTasa
      ,      ActivoValorTasa     = ValorTasa
      ,      ActivoCapital       = Capital
      ,      ActivoAmortizacion  = Amortizacion
      ,      ActivoInteres  = Interes
      ,      Compensacion        = Compensacion + Monto_Flujo
      ,      ActivoPrxVcto      = ProxVcto
      ,      ActivoNroTotFlu     = TotFlujos
      ,      ActivoNroFlu        = Flujo
      ,      ActivoFechaInicio = InicioFlujo
      ,      ActivoFechaTermino = VctoFlujo
      ,      ActivoMonedaPago = Recibimos_Moneda
      ,      ActivoFormaPago  = Recibimos_Documento
      ,      ActivoMtoPagoEF  = Monto_Flujo
      ,      ActivoFlujoAdicional = FlujoAdicional
      FROM   #TipoFlujo_1
      WHERE  Operacion     = iOperacion
--    WHERE  Indice        = Correla

   END


   SELECT 	Indice
,	Operacion
,	ActivoFechaInicio
,       PasivoFechaInicio
,	ActivoFechaTermino
,       PasivoFechaTermino
,	ActivoMoneda
,	ActivoTipoTasa
,	ActivoValorTasa
,	ActivoCapital
,	ActivoAmortizacion
,	ActivoInteres
	

,	PasivoMoneda
,	PasivoTipoTasa
,	PasivoValorTasa
,	PasivoCapital
,	PasivoAmortizacion
,	PasivoInteres


	
,	Compensacion = case when modalidad_pago = 'C' then Compensacion else 0 end

,	ActivoPrxVcto
,	PasivoPrxVcto
,	ActivoNroTotFlu
,	PasivoNroTotFlu
,       ActivoNroFlu
,       PasivoNroFlu


   ,      Recibimor.tbglosa               as ActivoTipoTasaA
   ,      Entregamos.tbglosa              as PasivoTipoTasaA
   ,      isnull( Recib.mnnemo, 'N/A' )   as ActivoMonedaA
   ,      isnull( Entre.mnnemo , 'N/A' )  as PasivoMonedaA
   ,      convert(char(10),@FechaProceso,103)  as FechaProceso       -- Ante @MiFecha 16/05/2008
   ,      upper(@MiUsuario)               as Usuario
   ,      convert(char(10),GETDATE(),103) as FechaEmision
   ,      convert(char(10),GETDATE(),108) as HoraEmision
   ,      @EstadoTasa                     as ActualizacionTasa
   ,      Case when Tipo_Swap = 1 then 'Swap de Tasas'
               when Tipo_Swap = 2 then 'Swap de Monedas'
               when Tipo_Swap = 3 then 'Forward Rate Ag.'
               when Tipo_Swap = 4 then 'Ind. Cámara Promedio'
               else 'IRR' end             as Tipo_Swap_Palabras
   ,      modalidad_pago 
   ,      IntercPrinc   
   ,      isnull( RecibPag.mnnemo, 'N/A' )   as ActivoMonedaPagoA
   ,      isnull( EntrePag.mnnemo , 'N/A' )  as PasivoMonedaPagoA
   ,      isnull( RecibFpPag.Glosa, 'N/A' )   as ActivoFPPagoA
   ,      isnull( EntreFpPag.Glosa , 'N/A' )  as PasivoFPPagoA

   ,      isnull( RecibVM.vmvalor , 0 )   As ActivoTCMMoneda     
   ,      isnull( EntreVM.vmvalor, 0 )    As PasivoTCMMoneda     
   ,      isnull( RecibVMPag.vmvalor, 0 ) As ActivoTCMMonedaPago 
   ,   isnull( EntreVMPag.vmValor, 0 ) As PasivoTCMMonedaPago 
   ,      ActivoMtoPagoEF  = case when modalidad_pago = 'C' then 0 else ActivoMtoPagoEF end
   ,      PasivoMtoPagoEF  = case when modalidad_pago = 'C' then 0 else PasivoMtoPagoEF end
   ,      ActivoFLujoAdicional
   ,      PasivoFlujoAdicional
   ,      Proyectado       = case when @MiFecha > @FechaProceso then 'Proyectado' 
                                  when @MiFecha =@FechaProceso  then 'Del dia'
                              else     'Pagos Históricos' end
   FROM   #TmpFlujosSwap 
          LEFT JOIN bacparamsuda..tabla_general_detalle Recibimor  ON Recibimor.tbcateg  = 1042       AND Recibimor.tbcodigo1  = ActivoTipoTasa
          LEFT JOIN bacparamsuda..tabla_general_detalle Entregamos ON Entregamos.tbcateg = 1042       AND Entregamos.tbcodigo1 = PasivoTipoTasa
          LEFT JOIN bacparamsuda..moneda                Recib      ON Recib.mncodmon     = ActivoMoneda
          LEFT JOIN bacparamsuda..moneda                Entre      ON Entre.mncodmon     = PasivoMoneda
          LEFT JOIN bacparamsuda..moneda                RecibPag   ON RecibPag.mncodmon  = ActivoMonedaPago
          LEFT JOIN bacparamsuda..moneda                EntrePag   ON EntrePag.mncodmon  = PasivoMonedaPago
          LEFT JOIN bacparamsuda..Forma_De_Pago         RecibFpPag ON RecibFpPag.codigo  = ActivoFormaPago
          LEFT JOIN bacparamsuda..Forma_De_Pago         EntreFpPag ON EntreFpPag.codigo  = PasivoFormaPago
          LEFT JOIN #Valor_Moneda                       RecibVM    ON RecibVM.Vmcodigo      = ActivoMoneda 
          LEFT JOIN #Valor_Moneda                       RecibVMPag ON RecibVMPag.Vmcodigo   = ActivoMonedaPago 
          LEFT JOIN #Valor_Moneda                       EntreVM    ON EntreVM.Vmcodigo      = PasivoMoneda 
          LEFT JOIN #Valor_Moneda                       EntreVMPag ON EntreVMPag.Vmcodigo   = PasivoMonedaPago
   ORDER BY Operacion

END
GO
