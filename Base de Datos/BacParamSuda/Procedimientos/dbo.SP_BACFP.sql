USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACFP]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Bacfp    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Bacfp    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACFP]
AS
BEGIN
 SELECT codigo,glosa,cc2756,diasvalor FROM FORMA_DE_PAGO ORDER BY codigo
END         
GO
