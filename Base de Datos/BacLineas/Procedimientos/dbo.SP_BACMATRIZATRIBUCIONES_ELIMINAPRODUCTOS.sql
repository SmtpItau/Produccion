USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_ELIMINAPRODUCTOS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_ELIMINAPRODUCTOS]
         (
            @usuario              CHAR   (15),
            @codigo_producto      CHAR   (05)
         )
AS 
BEGIN
 SET NOCOUNT ON

 DELETE
   FROM MATRIZ_ATRIBUCION_INSTRUMENTO
  WHERE usuario         = @usuario 
    AND codigo_producto = @codigo_producto


 SET NOCOUNT OFF
END
GO
