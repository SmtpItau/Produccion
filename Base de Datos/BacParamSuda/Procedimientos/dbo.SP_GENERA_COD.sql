USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_COD]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Genera_Cod    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_GENERA_COD]
  
 
AS
BEGIN 
 SET NOCOUNT OFF
 SELECT MAX(mncodcor)
 FROM MONEDA
 SET NOCOUNT ON
END
GO
