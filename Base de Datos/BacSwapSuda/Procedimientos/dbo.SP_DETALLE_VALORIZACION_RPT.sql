USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_VALORIZACION_RPT]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[SP_DETALLE_VALORIZACION_RPT](     
       @Pfechaproc char(8) , 
       @NumeroOperacion numeric(10) )
As Begin

    -- Columna única para valores activo y pasivo disitngueindo por tipo de flujo
    --declare @fechaproc datetime
    --declare @NumeroOperacion numeric(10)

    --select  @fechaproc =  fechaproc from swapgeneral
    --select  @NumeroOperacion = 462
    -- Sp_Detalle_Valorizacion_rpt '20080403', 462
    declare @fechaproc  datetime
    select  @fechaproc = fechaproc  from SwapGeneral

    Select 	
    -- Valores de la operación
       ClRut
    ,  ClDv
    ,  ClNombre
    ,  Tikker
    ,  Tipo_Swap 
    ,  Tipo_Swap_Desc = case when Tipo_Swap = 1 then 'Swap de Tasas' 
            when tipo_Swap = 2 then 'Monedas'
            when tipo_Swap = 3 then 'Fra'
            when tipo_Swap = 4 then 'Indice Cámara Promedio'
            else 'Tipo Swap Indefinido' 
       end
    , Estado 
    , Estado_Oper_lineas
    , Numero_operacion 
    , Fecha_Cierre
    -- Valores <> por Entregar - Recibir
    , Tipo_Flujo 
    , Capital              = Compra_Capital + Venta_Capital
    , Moneda_Pierna        = MdaPierna.mnGlosa 
    , Moneda_Pago          = MdaPago.mnGlosa
    , Tipo_tasa = Case when Tipo_flujo = 1 
                  then 
                      case when compra_codigo_tasa = 0 then 'Fijo' else 'Variable' end 
                  else
                      case when Venta_codigo_tasa = 0 then 'Fija' else 'Variable' end  
                  end
    , Conteo_Dias = Base.glosa 
    , CodigoTasa           = left( ( select tbglosa from bacparamSuda..Tabla_general_detalle where tbcodigo1 =  compra_codigo_tasa + venta_codigo_tasa and tbcateg = 1042 ), 10 )
    , Duration = case when tipo_flujo = 1 then vDurMacaulActivo else vDurMacaulPasivo end
    , DurationModificada = case when tipo_flujo = 1 then vDurModifiActivo else vDurModifiPasivo end
    , Convexidad         = case when tipo_flujo = 1 then vDurConvexActivo else vDurConvexPasivo end
    , AVRNetoUSD           = Valor_RazonableUSD    
    , AVRNetoCLP           = Valor_RazonableCLP
    , Total_AVR_PataMO     = Compra_Mercado + Venta_Mercado
    , Total_AVR_PataCLP    = Compra_Mercado_CLP + Venta_Mercado_CLP
    , Total_AVR_PataMdaPag = Compra_Valor_presente + Venta_Valor_presente  --- PENDIENTE: Evaluación
    , Spread               = compra_spread + Venta_spread 
    , FechaEfectiva        = FechaEfectiva
    , CurvaForward         = rtrim( ltrim( Compra_Curva_Forward ) ) + rtrim( ltrim( Venta_Curva_Forward ))     
    , CurvaDescuento       = rtrim( ltrim( Compra_Curva_Descont ) ) + rtrim( ltrim( Venta_Curva_Descont ) ) 
    -- Valores <> x Flujo
    , Numero_flujo 
    , Fecha_inicio_flujo
    , fecha_vence_flujo
    , Plazo_Anterior       = datediff( dd, @fechaproc, Fecha_Inicio_Flujo  ) 
    , Plazo                = datediff( dd, @fechaproc, Fecha_Vence_Flujo )
    , Plazo_para_Desc      = datediff( dd, @fechaproc, FechaLiquidacion ) -- Por mientras, deberia ser la de valuta   
    , Tasa_cupon_Fijado    = Compra_Valor_tasa + venta_Valor_tasa
    , Tasa_Forward         = Tasa_Compra_Curva + Tasa_Venta_Curva  
    , Saldo_Insoluto_MO    = Compra_saldo + Compra_amortiza + Venta_saldo + Venta_Amortiza
    , Tasa_Descuento_Plazo = Tasa_Compra_CurvaVR + Tasa_Venta_CurvaVR  
    , Cupon_Original       = Compra_Interes + Venta_Interes  
    , Amortizacion         = Compra_Amortiza + Venta_Amortiza
    , Flujo_Adicional      = Compra_Flujo_Adicional + Venta_Flujo_adicional
    , Intercambio_Nocional = case when IntercPrinc = 0 then 'No' else 'Si' end
    , Cupon_Proyectado_MO  = Activo_MO_C08 + Pasivo_MO_C08
    , Cupon_Proyectado_USD = Activo_USD_C08 + Pasivo_USD_C08
    , Cupon_Descontado_MO  = Activo_FlujoMO + Pasivo_FlujoMO
    , Cupon_Descontado_USD = Activo_FlujoUSD + Pasivo_FlujoUSD
    , fecha_fijacion_tasa
    , Estado_Flujo 
    , FechaLiquidacion
    , FechaValuta = FechaLiquidacion
    -- Adornos de pantalla
    , FechaProceso = ( select fechaproc  from SwapGeneral )  
	, 'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
      from cartera               C, 
           bacParamSuda..Moneda  MdaPierna, 
           bacParamSuda..Moneda  MdaPago,
           bacParamSuda..Cliente Cliente,
           Base
         WHERE  
        -- Filtros de cruce
            C.Compra_Moneda + C.Venta_MOneda = MdaPierna.mncodmon
        AND C.pagamos_moneda + C.recibimos_moneda = MdaPago.mncodmon
        AND C.Rut_cliente = Cliente.Clrut
        AND C.Codigo_Cliente = Cliente.ClCodigo
        AND Base.Codigo = compra_base + venta_base
        -- Filtros
        AND
        Numero_Operacion    = @NumeroOperacion
	and estado<>'N'
order by tipo_flujo, numero_flujo

end


GO
