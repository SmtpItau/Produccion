USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_COBERTURAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_COBERTURAS]
AS 
BEGIN

   SET NOCOUNT ON

   SELECT [N°Cobertura] = CONVERT(CHAR(8),REPLICATE('0', 8 - LEN(nCobertura)) + LTRIM(nCobertura))
   ,      [Modulo]      = cModulo
   ,      [N° Derivado] = CONVERT(CHAR(8),REPLICATE('0', 8 - LTRIM(LEN(nDerivado))) + LTRIM(nDerivado)) + '-' + LTRIM(nCorrela)
   FROM   BacTraderSuda..COBERTURAS
   ORDER BY nCobertura , nDerivado , nCorrela

END


GO
