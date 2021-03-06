USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_ELIMINAINSTRUMENTOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_ELIMINAINSTRUMENTOS]
         (
   @usuario  CHAR(15),
   @codigo_producto CHAR(5),
   @incodigo  CHAR(5)
   ) 
AS 
BEGIN
 SET NOCOUNT ON
 DELETE FROM MATRIZ_ATRIBUCION_INSTRUMENTO
  WHERE 
   usuario         = @usuario   AND
         codigo_producto = @codigo_producto  AND
         incodigo = @incodigo
 SET NOCOUNT OFF
END
GO
