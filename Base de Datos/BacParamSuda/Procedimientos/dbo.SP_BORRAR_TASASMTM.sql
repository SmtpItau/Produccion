USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_TASASMTM]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_TasasMTM    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_TasasMTM    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_TASASMTM]( @codtasa   INTEGER ,
                                     @codmoneda INTEGER ,
                                     @dias      INTEGER )
AS
BEGIN
SET NOCOUNT ON
     DELETE FROM TASA WHERE codigotasa   = @codtasa
                           AND codigomoneda = @codmoneda
                           AND desde        = @dias
     IF @@ERROR <> 0
        SELECT -1, 'ERROR no se puede Borrar Tasa de Mercado'
END  -- PROCEDURE
GO
