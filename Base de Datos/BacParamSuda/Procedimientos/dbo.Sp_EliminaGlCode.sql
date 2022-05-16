USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminaGlCode]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_EliminaGlCode] (@nCodTR INT , @nCodCon Int)
AS

/***********************************************************************
DESCRIPCION    : Usuado en mantenedor BacMntCuentasGL
***********************************************************************/
BEGIN

  DELETE Tabla_Glcode 
  WHERE Codigo_Transaccion = @nCodTR 
    AND Codigo_Campo_Condicion = @nCodCon
END


GO
