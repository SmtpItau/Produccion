USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_RIESGO_PAIS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_RIESGO_PAIS](
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nNumoper NUMERIC(10) )
AS
BEGIN
 DECLARE @nTotalDisponible NUMERIC (19,4) ,
  @nMonto   NUMERIC (19,4) ,
  @nCodigo_pais  NUMERIC(05)
 DECLARE Cursor_RIESGO_PAIS SCROLL CURSOR FOR
 SELECT Codigo_Pais  ,
  SUM(MontoTransaccion)
 FROM VIEW_LINEA_CHEQUEAR
 WHERE NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 AND Codigo_Producto = @cProducto
 GROUP BY
  Codigo_Pais
 OPEN Cursor_RIESGO_PAIS
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM Cursor_RIESGO_PAIS
  INTO @nCodigo_pais ,
   @nMonto
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT @nTotalDisponible = 0
  SELECT @nTotalDisponible = TotalDisponible
         FROM VIEW_RIESGO_PAIS
  WHERE Codigo_pais = @nCodigo_pais
  IF @nTotalDisponible < @nMonto
   INSERT INTO #TEMP1 SELECT 'OPERACION SOBREPASA LIMITE RIESGO PAIS'
 END
 CLOSE Cursor_RIESGO_PAIS
 DEALLOCATE Cursor_RIESGO_PAIS
END



GO
