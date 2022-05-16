USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ERROR]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_ERROR]
    (
    @cSistema CHAR (03) ,
    @nNumoper NUMERIC (10,0)
    )
AS
BEGIN
 SELECT Mensaje_Error
 FROM VIEW_LINEA_TRANSACCION_DETALLE
 WHERE  Error = 'S'
 AND NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
END

GO
