USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ERRORDETALLE]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_ERRORDETALLE]
    (
    @cSistema CHAR (03) ,
    @nNumoper NUMERIC (10,0) ,
    @nNumdocu NUMERIC (10,0) ,
    @nCorrela NUMERIC (10,0)
    )
AS
BEGIN
 SET NOCOUNT ON
 SELECT Mensaje_Error,
  MontoExceso
 FROM LINEA_TRANSACCION_DETALLE
 WHERE  Error = 'S'
 AND NumeroDocumento = @nNumdocu
 AND NumeroOperacion = @nNumoper
 AND NumeroCorrelativo=@nCorrela
 AND Id_Sistema = @cSistema
 SET NOCOUNT OFF
END
-- Sp_Lineas_Error 'BTR', 2
--  SELECT * FROM LINEA_TRANSACCION_DETALLE
GO
