USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_INVERSION_GLOBAL]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_INVERSION_GLOBAL](
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nNumoper NUMERIC(10) )
AS
BEGIN
 DECLARE @nTotalDisponible NUMERIC (19,4) ,
  @nMonto   NUMERIC (19,4) ,
  @cSeriado  CHAR(1)  ,
  @nPlazo   NUMERIC (05,0)
 DECLARE Cursor_INVERSION_GLOBAL SCROLL CURSOR FOR
 SELECT Seriado   ,
  SUM(MontoTransaccion) ,
  DATEDIFF(day,FechaOperacion,FechaVctoInst)
 FROM VIEW_LINEA_CHEQUEAR
 WHERE NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 AND Codigo_Producto = @cProducto
 GROUP BY
  Seriado,
  DATEDIFF(day,FechaOperacion,FechaVctoInst)
 OPEN Cursor_INVERSION_GLOBAL
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM Cursor_INVERSION_GLOBAL
  INTO @cSeriado ,
   @nMonto  ,
   @nPlazo
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT @nTotalDisponible = 0
  SELECT @nTotalDisponible = TotalDisponible
         FROM VIEW_MARGEN_INVERSION_GLOBAL
  WHERE id_sistema = @cSistema
  AND codigo_producto = @cProducto
  AND seriado  = @cSeriado
  AND plazo_desde <= @nPlazo
  AND plazo_hasta > @nPlazo
  IF @nTotalDisponible < @nMonto
   INSERT INTO #TEMP1 SELECT 'INSTRUMENTO SOBREPASA LIMITE INVERSION GLOBAL'
 END
 CLOSE Cursor_INVERSION_GLOBAL
 DEALLOCATE Cursor_INVERSION_GLOBAL
END
-- select * from VIEW_MARGEN_INVERSION_GLOBAL


GO
