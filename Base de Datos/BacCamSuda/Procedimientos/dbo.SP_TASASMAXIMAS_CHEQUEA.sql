USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASASMAXIMAS_CHEQUEA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  @nContador INTEGER
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
  SELECT 'NO', 'No Existen Tasas Maximas Convecionales Definidas Para esta OperaciÃ³n'
  RETURN
 END
 IF @nContador > 1
 BEGIN
  SELECT 'NO', 'Multiple DifiniciÃ³n de Tasas Maximas Convecionales Para esta OperaciÃ³n'
  RETURN
 END
 IF @nTasa < @nTasaMinima
 BEGIN
  SELECT 'NO', 'Tasa es Inferior a Tasa Minima Convencional Para esta OperaciÃ³n'
  RETURN
 END
 IF @nTasa > @nTasaMaxima
 BEGIN
  SELECT 'NO', 'Tasa es Superior a Tasa Maxima Convencional Para esta OperaciÃ³n'
  RETURN
 END
 SELECT 'SI', 'Tasa Correcta'
 SET NOCOUNT OFF
END
--select * from VIEW_TASAS_MAXIMAS_CONVENCIONAL
-- Sp_TasasMaximas_Chequea 'CI ', 998, 30, 120000, 5.6



GO
