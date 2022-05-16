USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACINFORMACIONBASICA_LEEMONEDAS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacInformacionBasica_LeeMonedas    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
CREATE PROCEDURE [dbo].[SP_BACINFORMACIONBASICA_LEEMONEDAS]
AS BEGIN
SET NOCOUNT ON
 SELECT  mncodmon, 
  mnglosa, 
  mnnemo, 
  mnsimbol 
 
 FROM MONEDA WHERE mnmx <> 'C' ORDER BY mnglosa
SET NOCOUNT OFF
END
GO
