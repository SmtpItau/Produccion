USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ERROR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_ERROR]
    (
    @cSistema CHAR (03) ,
    @nNumoper NUMERIC (10,0)
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Estado_Linea CHAR(1)
 SELECT @Estado_Linea = 'P'
 SELECT  @Estado_Linea = ISNULL( ( CASE WHEN Operador_Ap_Lineas = '' THEN 'P' ELSE 'A' END ) , 'P' )
 FROM    aprobacion_operaciones
 WHERE   NumeroOperacion = @nNumoper
  AND Id_Sistema = @cSistema
 SELECT  Mensaje_Error,
  MontoExceso
 FROM  linea_transaccion_detalle   
 WHERE   Error = 'S'
  AND NumeroOperacion = @nNumoper
  AND Id_Sistema = @cSistema
  AND @estado_linea = 'P'
 SET NOCOUNT OFF
END
-- EXECUTE Sp_Lineas_Error 'BFW', 29177

GO
