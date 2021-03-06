USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_CHEQUEARERROR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LIMITES_CHEQUEARERROR]
      (
      @cSistema CHAR (03) ,
      @nNumoper NUMERIC (10,0)
      )
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT * FROM VIEW_LIMITE_TRANSACCION_ERROR WHERE NumeroOperacion=@nNumoper AND Id_Sistema=@cSistema)
 BEGIN
  IF @cSistema = 'BTR'
  BEGIN
   UPDATE MDMO SET mostatreg  = 'P' WHERE monumoper=@nNumoper
   IF EXISTS(SELECT * FROM MDCP WHERE cpnumdocu=@nNumoper)
    UPDATE MDCP SET Estado_Operacion_Linea = 'P' WHERE cpnumdocu=@nNumoper
   IF EXISTS(SELECT * FROM MDDI WHERE dinumdocu=@nNumoper)
    UPDATE MDDI SET Estado_Operacion_Linea = 'P' WHERE dinumdocu=@nNumoper
   IF EXISTS(SELECT * FROM MDCI WHERE cinumdocu=@nNumoper)
    UPDATE MDCI SET Estado_Operacion_Linea = 'P' WHERE cinumdocu=@nNumoper
  END
  IF @cSistema='BCC'
   UPDATE MEMO SET moestatus = 'P' WHERE monumope=@nNumoper
  IF @cSistema='BFW'
   UPDATE MFMO SET moestado  = 'P' WHERE monumoper=@nNumoper
 END
 SELECT Mensaje, Monto 
 FROM VIEW_LIMITE_TRANSACCION_ERROR
 WHERE  NumeroOperacion=@nNumoper AND Id_Sistema=@cSistema
  
 SET NOCOUNT OFF
END
-- select * from VIEW_CONTROL_FINANCIERO
-- select * from VIEW_LINEA_TRANSACCION
-- select * from VIEW_MATRIZ_ATRIBUCION
-- select * from VIEW_MATRIZ_ATRIBUCION_INSTRUMENTO
-- select * from VIEW_LIMITE_TRANSACCION
-- select * from VIEW_LIMITE_TRANSACCION_ERROR

GO
