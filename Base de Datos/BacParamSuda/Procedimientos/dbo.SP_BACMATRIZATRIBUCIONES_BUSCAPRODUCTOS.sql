USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_BUSCAPRODUCTOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_BUSCAPRODUCTOS]
         (
    @usuario   CHAR(15),
    @codigo_producto  CHAR(5)
   )
AS 
BEGIN
 --SELECT * FROM MATRIZ_ATRIBUCION
 SELECT 
  usuario,
         codigo_producto,
         plazo_desde,
         plazo_hasta,
         montoinicio,
         montofinal
  
  FROM MATRIZ_ATRIBUCION
  
  WHERE  usuario = @usuario 
   AND codigo_producto=@codigo_producto
END
GO
