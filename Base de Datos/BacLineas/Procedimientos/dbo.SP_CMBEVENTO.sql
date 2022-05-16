USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBEVENTO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CMBEVENTO    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
CREATE PROCEDURE [dbo].[SP_CMBEVENTO]
AS 
BEGIN
 SET NOCOUNT ON
 SELECT codigo_evento,descripcion
 FROM VIEW_LOG_EVENTO
 ORDER BY  descripcion
 SET NOCOUNT OFF
END

GO
