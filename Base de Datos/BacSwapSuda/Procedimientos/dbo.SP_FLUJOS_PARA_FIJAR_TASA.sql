USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJOS_PARA_FIJAR_TASA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FLUJOS_PARA_FIJAR_TASA]  
   (   @Usuario VARCHAR(15) = 'Administra'
   )
AS
BEGIN


declare @Fecha_Proceso datetime
select  @Fecha_Proceso = fechaproc from swapgeneral

select Numero_Operacion                                  As NroOperacion,
       Numero_Flujo                                      As NroFlujo,
       fecha_Fijacion_Tasa                               As Fijacion, 
       fecha_inicio_flujo                                As Inicio,
       fecha_Vence_Flujo                                 As Fin,
       Codigo_Tasa.tbglosa                               As Indice, 
       MonedaCap.mnnemo                                  As Moneda ,
       case when venta_zcr + compra_zcr = 1 
            then 'Tasa Fijada' else 'Falta Fijar' end    As TasaFijada , 
       Compra_Valor_Tasa   
     + Venta_Valor_Tasa                                  As Valor_Fijado ,

       isnull( ValorTasa.Tasa, 0 )                       As Valor_Sistema,

       (Case when fecha_Fijacion_Tasa <= @Fecha_Proceso 
             then Compra_Valor_Tasa   
                  + Venta_Valor_Tasa
                  - ValorTasa.Tasa 
             else 0 end)                                 As Diferencia, 
       (Case when fecha_Fijacion_Tasa <= @Fecha_Proceso
             and  Compra_Valor_Tasa   
                  + Venta_Valor_Tasa
                  - ValorTasa.Tasa  <> 0
             then 'Valor Fijado debe ser igual a Valor Sistema' 
             else ' ' end )                              As Observacion,
        @Fecha_Proceso                                   As FechaProceso,
        @Usuario                                          As Usuario,
		'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)

 
from    cartera 
        LEFT JOIN BacParamSuda..Tabla_General_Detalle As Codigo_Tasa on Codigo_Tasa.tbcateg = 1042  and  Codigo_Tasa.tbcodigo1 = compra_Codigo_tasa + venta_Codigo_Tasa 
        LEFT JOIN BacParamSuda..Moneda                As MonedaCap   on MonedaCap.MnCodMon =  Compra_Moneda + Venta_Moneda
        LEFT JOIN BacParamSuda..MONEDA_TASA           As ValorTasa   on ValorTasa.Sistema = 'PCS'                                       
                                                                        and ValorTasa.periodo = 1                                           
                                                                        and ValorTasa.CodMon  = Compra_Moneda + Venta_Moneda                
                                                                        and ValorTasa.CodTasa = compra_Codigo_tasa + venta_Codigo_Tasa      
                                                                        and ValorTasa.Fecha   = fecha_Fijacion_Tasa                         
where 
    compra_Codigo_tasa + venta_Codigo_Tasa <> 0                     -- Solo Tasas Variables
   and compra_Codigo_tasa + venta_Codigo_Tasa <> 13                 -- No ICP
   and fecha_Fijacion_Tasa <= @Fecha_Proceso                        -- Solo las que tienen que estar fijadas 
   and fecha_inicio_Flujo <> fecha_Vence_Flujo                      -- Descarta los flujos efectivos
   and estado <> 'C'                                                -- Descarta las cotizaciones del listado

order by fecha_Fijacion_Tasa, numero_operacion

END

GO
