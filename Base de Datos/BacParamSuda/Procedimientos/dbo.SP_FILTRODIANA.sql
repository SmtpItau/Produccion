USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRODIANA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_FiltroDiana    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_FILTRODIANA]
AS
BEGIN
 
SET NOCOUNT ON
SELECT codigo_producto,descripcion
 FROM PRODUCTO
SET NOCOUNT OFF
END
GO
