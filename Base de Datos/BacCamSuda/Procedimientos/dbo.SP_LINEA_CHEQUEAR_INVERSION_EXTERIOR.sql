USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_INVERSION_EXTERIOR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_INVERSION_EXTERIOR](
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nNumoper NUMERIC(10) )
AS
BEGIN
 DECLARE @nTotalDisponible NUMERIC (19,4) ,
  @nTotalDisponibleSpo NUMERIC (19,4) ,
  @nTotalDisponibleFwd NUMERIC (19,4) ,
  @nMonto   NUMERIC (19,4) ,
  @nRutcli  NUMERIC (09,0) ,
  @nCodigo  NUMERIC (09,0) ,
  @nPlazo   NUMERIC (05,0)
 DECLARE Cursor_INVERSION_EXTERIOR SCROLL CURSOR FOR
 SELECT Rut_Cliente  ,
  Codigo_Cliente  ,
  DATEDIFF(DAY,fechaoperacion,fechavencimiento),
  SUM(MontoTransaccion)
 FROM VIEW_LINEA_CHEQUEAR
 WHERE NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 AND Codigo_Producto = @cProducto
 GROUP 
 BY Rut_Cliente  ,
  Codigo_Cliente  ,
  DATEDIFF(DAY,fechaoperacion,fechavencimiento)
 OPEN Cursor_INVERSION_EXTERIOR
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM Cursor_INVERSION_EXTERIOR
  INTO @nRutcli ,
   @nCodigo ,
   @nPlazo  ,
   @nMonto
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT @nTotalDisponible = 0,
   @nTotalDisponibleSpo = 0,
   @nTotalDisponibleFwd = 0
  SELECT @nTotalDisponible = InvExt_Disponible,
   @nTotalDisponibleSpo = ArbSpo_Disponible,
   @nTotalDisponibleFwd = ArbFwd_Disponible
         FROM VIEW_INVERSION_EXTERIOR
  WHERE Rut_Cliente  = @nRutcli
  AND Codigo_Cliente  = @nCodigo
  AND Plazo  = @nPlazo
  IF @nTotalDisponible < @nMonto
   INSERT INTO #TEMP1 SELECT 'OPERACION SOBREPASA LIMITE INVERSION EXTERIOR CLIENTE'
  IF ( @cSistema = 'BCC' AND @cProducto = 'ARBI' ) AND @nTotalDisponibleSpo < @nMonto
   INSERT INTO #TEMP1 SELECT 'OPERACION SOBREPASA LIMITE INVERSION EXTERIOR SPOT CLIENTE'
  IF ( @cSistema = 'BFW' AND @cProducto = '1' ) AND @nTotalDisponibleFwd < @nMonto
   INSERT INTO #TEMP1 SELECT 'OPERACION SOBREPASA LIMITE INVERSION EXTERIOR FORWARD CLIENTE'
 END
 CLOSE Cursor_INVERSION_EXTERIOR
 DEALLOCATE Cursor_INVERSION_EXTERIOR
END



GO
