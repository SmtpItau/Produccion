USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICATASAS]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VERIFICATASAS]
               ( @dfecpro DATETIME )
AS
BEGIN
  SELECT  DISTINCT di.diserie          
  INTO #TEMP1
   FROM 
   MDDI di,
   mdtr tr
  WHERE 
   tr.trfecha = @dfecpro 
  AND tr.trserie = di.diserie 
  IF  (SELECT  COUNT(*) FROM #TEMP1 ) = 0 SELECT 'NO', 'HAY ALGUNOS INSTRUMENTOS A LOS CUALES NO SE HA CAMBIADO FACTOR, FAVOR GRABAR NUEVOS FACTORES PARA DIA DE PROCESO'
  ELSE  SELECT 'SI', 'OK'
   
END

GO
