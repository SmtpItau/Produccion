USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_BUSCAINSTRUMENTOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_BUSCAINSTRUMENTOS]
  (
   @usuario CHAR(15),
   @codigo_producto CHAR(5),
   @incodigo NUMERIC(5)
  )
AS 
BEGIN
 --SELECT * FROM MATRIZ_ATRIBUCION_INSTRUMENTO
 SELECT 
        usuario,
        codigo_producto,
        incodigo,
        plazo_desde,
        plazo_hasta,
        montoinicio,
        montofinal
        FROM MATRIZ_ATRIBUCION_INSTRUMENTO
        WHERE  usuario = @usuario 
   AND codigo_producto=@codigo_producto
   AND incodigo=@incodigo
END
GO
