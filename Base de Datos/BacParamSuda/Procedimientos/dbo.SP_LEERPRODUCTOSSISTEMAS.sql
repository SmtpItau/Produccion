USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERPRODUCTOSSISTEMAS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERPRODUCTOSSISTEMAS] 
       (
        @Sistema CHAR (05)
       )
AS
BEGIN
 SET NOCOUNT ON
 SELECT 
 codigo_producto, 
 descripcion
 FROM Producto
 WHERE id_sistema = @Sistema
END

GO
