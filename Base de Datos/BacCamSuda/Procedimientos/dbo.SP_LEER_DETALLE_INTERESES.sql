USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_DETALLE_INTERESES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_LEER_DETALLE_INTERESES] 
            (
            @fecplan        char(8),
            @numplan        numeric(7),
            @corplan        numeric(3)
            )
AS
BEGIN
set nocount on
 select 'fecha' = convert(char(10),fecha,103),
        'planilla_fecha' = convert(char(10),planilla_fecha,103),
        planilla_numero         ,
 correlativo  ,
        concepto_capital        ,
        capital                 ,
        tipo_interes            ,
        codigo_base_tasa        ,
        tasa_interes_anual      ,
        'fecha_inicial' = convert(char(10),fecha_inicial,103),
        'fecha_final' = convert(char(10),fecha_final,103),
        monto_interes           ,
        indica_pago_exterior
   from  TBDETALLEINTERESES
   where (@fecplan='' or planilla_fecha = @fecplan)     and
         (@numplan=0 or planilla_numero = @numplan)     and
         (@corplan=0 or correlativo = @corplan)
set nocount off
END

GO
