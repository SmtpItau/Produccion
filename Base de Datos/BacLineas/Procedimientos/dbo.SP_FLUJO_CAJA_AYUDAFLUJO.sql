USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_CAJA_AYUDAFLUJO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_FLUJO_CAJA_AYUDAFLUJO    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_FLUJO_CAJA_AYUDAFLUJO]
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT 1 FROM TIPOCONCEPTO_FLUJOCAJA) BEGIN
  SELECT  Codigo_Concepto, 
   Concepto         
  FROM TIPOCONCEPTO_FLUJOCAJA
  ORDER BY codigo_concepto
 
 END 
 ELSE BEGIN
  
  SELECT 'ERROR'
 END
 
 SET NOCOUNT OFF
END
GO
