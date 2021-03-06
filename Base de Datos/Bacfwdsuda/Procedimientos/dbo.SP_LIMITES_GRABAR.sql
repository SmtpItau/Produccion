USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_GRABAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_GRABAR]
    (
    @dFecPro  DATETIME ,
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nCodInst NUMERIC (05,0) ,
    @nNumoper NUMERIC (10,0) ,
    @nMonto  NUMERIC (19,4) ,
    @dFecvctop DATETIME ,
    @cUsuario CHAR (15) ,
    @cCheckLimOp CHAR (1) ,
    @cCheckLimInst CHAR (1)
   )
AS
BEGIN
 SET NOCOUNT ON
 DELETE  VIEW_LIMITE_TRANSACCION 
 WHERE  @nNumoper = NumeroOperacion AND
  @cSistema = Id_Sistema  
 INSERT INTO VIEW_LIMITE_TRANSACCION
 SELECT @dFecPro  ,
  @nNumoper ,
  @cSistema ,
  @cProducto ,
  @nCodInst ,
  @nMonto  ,
  @dFecvctop ,
  @cUsuario ,
  @cCheckLimOp ,
  @cCheckLimInst 
 
 SET NOCOUNT OFF
END
-- select * from VIEW_CONTROL_FINANCIERO
-- select * from VIEW_LINEA_TRANSACCION
-- select * from VIEW_MATRIZ_ATRIBUCION
-- select * from VIEW_MATRIZ_ATRIBUCION_INSTRUMENTO
-- select * from VIEW_LIMITE_TRANSACCION WHERE Id_Sistema = 'BFW'
-- select * from VIEW_LIMITE_TRANSACCION_ERROR

GO
