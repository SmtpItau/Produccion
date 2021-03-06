USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Actualiza_Star]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_Actualiza_Star]
   (  @Sistema CHAR  (03) ,
    @Producto CHAR (03) ,
    @Numero_Oper NUMERIC (09) ,
    @dFecha  DATETIME ,
    @Monto_Op NUMERIC (19,4) OUTPUT

   )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

 DECLARE @cSw   CHAR(1)

 DECLARE @Fecha_Proceso  DATETIME


 SELECT  @Fecha_Proceso = (SELECT fecha_proceso FROM datos_generales)


 SELECT  @cSw '*'

 SELECT @Monto_Op   = monto_operacion,
  @cSw    = ''
 FROM CARTERA_LINEAS_STAR
 WHERE numero_operacion = @Numero_Oper
 AND Producto  = @Producto
 AND @Fecha_Proceso  = fecha_proceso


 IF @cSw = '*'
 BEGIN

  SELECT @Fecha_Proceso = MAX(fecha_proceso)
  FROM CARTERA_LINEAS_STAR
  WHERE numero_operacion = @Numero_Oper
  AND Producto  = @Producto
  AND @Fecha_Proceso  <= fecha_proceso


  SELECT @Monto_Op   = monto_operacion
  FROM CARTERA_LINEAS_STAR
  WHERE numero_operacion = @Numero_Oper
  AND Producto  = @Producto
  AND @Fecha_Proceso  = fecha_proceso

 END



-- select * from CARTERA_LINEAS_STAR

 SET NOCOUNT OFF

END


GO
