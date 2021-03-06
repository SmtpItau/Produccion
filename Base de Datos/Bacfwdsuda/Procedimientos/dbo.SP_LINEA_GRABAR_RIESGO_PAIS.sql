USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_GRABAR_RIESGO_PAIS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEA_GRABAR_RIESGO_PAIS](
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nNumoper NUMERIC(10) )
AS
BEGIN
 DECLARE @nTotalDisponible NUMERIC (19,4) ,
  @nMonto   NUMERIC (19,4) ,
  @nCodigo_pais  NUMERIC(05) ,
  @dFecvctop  DATETIME ,
  @cUsuario  CHAR (15) ,
  @dFeciniop  DATETIME
 DECLARE Cursor_RIESGO_PAIS SCROLL CURSOR FOR
 SELECT Codigo_Pais  ,
  SUM(MontoTransaccion) ,
  FechaVencimiento ,
  Operador  ,
  FechaOperacion
 FROM VIEW_LINEA_CHEQUEAR
 WHERE NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 AND Codigo_Producto = @cProducto
 GROUP BY
  Codigo_Pais  ,
  FechaVencimiento ,
  Operador  ,
  FechaOperacion
 OPEN Cursor_RIESGO_PAIS
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM Cursor_RIESGO_PAIS
  INTO @nCodigo_pais ,
   @nMonto  ,
   @dFecvctop ,
   @cUsuario ,
   @dFeciniop 
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
         UPDATE VIEW_RIESGO_PAIS
  SET TotalOcupado = TotalOcupado    + @nMonto,
   TotalDisponible = TotalDisponible - @nMonto
  WHERE Codigo_pais = @nCodigo_pais
  INSERT INTO VIEW_RIESGO_PAIS_DETALLE(
   codigo_pais  ,
   numero_operacion ,
   fechainicio  ,
   fechafinal  ,
   montooperacion  ,
   usuario      )
  SELECT @nCodigo_pais  ,
   @nNumoper  ,
   @dFeciniop  ,
   @dFecvctop  ,
   @nMonto   ,
   @cUsuario
 END
 CLOSE Cursor_RIESGO_PAIS
 DEALLOCATE Cursor_RIESGO_PAIS
END
-- select * FROM VIEW_RIESGO_PAIS
-- select * FROM VIEW_RIESGO_PAIS_detalle
GO
