USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BOMA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BOMA    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BOMA    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BOMA] 
AS
BEGIN
SET NOCOUNT ON
 SELECT codigo,glosa,tipope  
 FROM METB02 
SET NOCOUNT OFF
END
GO
