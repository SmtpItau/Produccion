USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESUMEN_SINACOFI]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RESUMEN_SINACOFI]
AS 
BEGIN
  SELECT cantidad = COUNT(*)
        ,Tipo_Operacion=(CASE WHEN tipo_documento = 1 THEN 'Compra' ELSE 'Venta' END )
        ,mnnemo
        ,operacion_fecha
        ,Hora_Proc= CONVERT(CHAR(08),GETDATE(),108)
        ,total=SUM(monto_origen) 
    FROM view_planilla_spt
        ,view_moneda 
        ,meac
   WHERE operacion_moneda=mncodmon and
         planilla_fecha = acfecpro         
GROUP BY tipo_documento
        ,mnnemo
        ,operacion_fecha HAVING COUNT (*) > 0 
ORDER BY tipo_operacion
END 







GO
