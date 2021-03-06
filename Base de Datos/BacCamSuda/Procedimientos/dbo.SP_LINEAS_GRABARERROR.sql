USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRABARERROR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_GRABARERROR]
    (
    @cSistema CHAR (03) ,
    @nNumoper NUMERIC (10,0)
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Error CHAR(1)
 SELECT @Error = 'N'
 SELECT @Error = 'S'
 FROM VIEW_LINEA_TRANSACCION_DETALLE
 WHERE  Error = 'S'
 AND NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 IF @Error = 'S'
 BEGIN
  IF @cSistema = 'BTR'
  BEGIN
   UPDATE mdmo SET mostatreg = 'P' WHERE monumoper = @nNumoper
   IF EXISTS(SELECT * FROM MDCP WHERE cpnumdocu=@nNumoper)
    UPDATE MDCP SET Estado_Operacion_Linea = 'P' WHERE cpnumdocu=@nNumoper
   IF EXISTS(SELECT * FROM MDDI WHERE dinumdocu=@nNumoper)
    UPDATE MDDI SET Estado_Operacion_Linea = 'P' WHERE dinumdocu=@nNumoper
   IF EXISTS(SELECT * FROM MDCI WHERE cinumdocu=@nNumoper)
    UPDATE MDCI SET Estado_Operacion_Linea = 'P' WHERE cinumdocu=@nNumoper
  END
  IF @cSistema = 'BCC' UPDATE memo SET moestatus = 'P' WHERE monumope  = @nNumoper
  IF @cSistema = 'BFW' UPDATE mfmo SET moestado  = 'P' WHERE monumoper = @nNumoper
  SELECT Mensaje_Error,
   MontoExceso
  FROM VIEW_LINEA_TRANSACCION_DETALLE
  WHERE  Error = 'S'
  AND NumeroOperacion = @nNumoper
  AND Id_Sistema = @cSistema
 END
 SET NOCOUNT OFF
END

GO
