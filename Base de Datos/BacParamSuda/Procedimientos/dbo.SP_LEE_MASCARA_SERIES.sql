USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MASCARA_SERIES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Lee_Mascara_Series    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Lee_Mascara_Series    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_LEE_MASCARA_SERIES](@Incodigo NUMERIC(3))
AS
BEGIN
 SELECT secodigo,semascara FROM SERIE WHERE secodigo = @Incodigo
END
--Sp_Lee_Mascara_Series 20

GO
