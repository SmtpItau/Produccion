USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASASMAXIMAS_CHEQUEA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TASASMAXIMAS_CHEQUEA] ( @cCodigo_Producto CHAR (05) ,
      @nCodigo_Moneda  NUMERIC (05) ,
      @nDias   NUMERIC (05) ,
      @nMonto   NUMERIC (19,04) ,
      @nTasa   NUMERIC (19,04) )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nTasaMinima NUMERIC(09,04),
  @nTasaMaxima NUMERIC(09,04),
  @nContador INT
 SELECT @nTasaMinima = 0,
  @nTasaMaxima = 0,
  @nContador = 0
 SELECT @nContador = COUNT(*)
 FROM VIEW_TASAS_MAXIMAS_CONVENCIONAL
 WHERE @cCodigo_Producto = Codigo_Producto
 AND @nCodigo_Moneda  = Codigo_Moneda
 AND @nDias   >=DiasDesde 
 AND @nDias   <=DiasHasta
 AND @nMonto   >=MontoMinimo
 AND @nMonto   <=MontoMaximo
 SELECT @nTasaMinima = TasaMinima,
  @nTasaMaxima = TasaMaxima
 FROM VIEW_TASAS_MAXIMAS_CONVENCIONAL
 WHERE @cCodigo_Producto = Codigo_Producto
 AND @nCodigo_Moneda  = Codigo_Moneda
 AND @nDias   >=DiasDesde 
 AND @nDias   <=DiasHasta
 AND @nMonto   >=MontoMinimo
 AND @nMonto   <=MontoMaximo
 IF @nContador = 0
 BEGIN
  SELECT 'NO', 'No Existen Tasas Maximas Convecionales Definidas Para esta Operación'
  RETURN
 END
 IF @nContador > 1
 BEGIN
  SELECT 'NO', 'Multiple Difinición de Tasas Maximas Convecionales Para esta Operación'
  RETURN
 END
 IF @nTasa < @nTasaMinima
 BEGIN
  SELECT 'NO', 'Tasa es Inferior a Tasa Minima Convencional Para esta Operación'
  RETURN
 END
 IF @nTasa > @nTasaMaxima
 BEGIN
  SELECT 'NO', 'Tasa es Superior a Tasa Maxima Convencional Para esta Operación'
  RETURN
 END
 SELECT 'SI', 'Tasa Correcta'
 SET NOCOUNT OFF
END
--select * from VIEW_TASAS_MAXIMAS_CONVENCIONAL
-- Sp_TasasMaximas_Chequea 'CI ', 998, 30, 120000, 5.6

GO
