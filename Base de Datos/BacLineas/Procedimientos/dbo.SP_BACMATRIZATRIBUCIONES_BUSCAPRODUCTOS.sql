USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_BUSCAPRODUCTOS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_BUSCAPRODUCTOS]
         (
             @usuario             CHAR   (15)
          ,  @codigo_producto     CHAR   (05)
         )
AS 
BEGIN

 SELECT usuario
 ,      codigo_producto
 ,      plazo_desde
 ,      plazo_hasta
 ,      Monto_Maximo_Operacion
 ,      Monto_Maximo_Acumulado
 ,      Acumulado_Diario
   FROM MATRIZ_ATRIBUCION_INSTRUMENTO
  WHERE usuario         = @usuario 
    AND codigo_producto = @codigo_producto
 ORDER BY plazo_desde
 ,	  plazo_hasta
 ,	  codigo_producto

END
GO
