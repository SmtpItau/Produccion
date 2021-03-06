USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CUADRATURA_SINACOFI]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_CUADRATURA_SINACOFI]
AS
BEGIN
 SET NOCOUNT ON
 SELECT  fecha   , 
  planilla_fecha  , 
  planilla_numero  , 
  interesado_nombre ,
  operacion_numero ,
         tipo_documento  , 
  codigo_comercio  , 
  concepto  ,
  monto_origen  ,
  tipo_cambio  ,
  afecto_derivados ,
  mnnemo                  ,
                'Hora' = CONVERT(CHAR(08),GETDATE(),108)
 FROM view_planilla_spt  ,
  view_moneda   ,
  meac
 WHERE operacion_moneda = mncodmon AND
  planilla_fecha = acfecpro
 ORDER BY    tipo_documento ASC
 SET NOCOUNT OFF
END

GO
