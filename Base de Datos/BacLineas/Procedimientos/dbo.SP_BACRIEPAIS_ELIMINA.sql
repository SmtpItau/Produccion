USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACRIEPAIS_ELIMINA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACRIEPAIS_ELIMINA    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BACRIEPAIS_ELIMINA    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACRIEPAIS_ELIMINA] ( @codigo NUMERIC(5) )
AS
BEGIN
 SET NOCOUNT ON
 DELETE FROM RIESGO_PAIS WHERE codigo_pais= @codigo 
 SET NOCOUNT OFF
END
GO
