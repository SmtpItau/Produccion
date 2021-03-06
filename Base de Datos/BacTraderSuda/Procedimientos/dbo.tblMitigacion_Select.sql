USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[tblMitigacion_Select]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[tblMitigacion_Select] ( @codFamilia CHAR(06),
											@iPlazo		INT
)
AS
BEGIN  
	IF EXISTS(SELECT 1 FROM dbo.tblMitigacion WHERE codFamilia =@codFamilia)
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.tblMitigacion WHERE codFamilia =@codFamilia AND @iPlazo BETWEEN  iPlazoIni AND iPlazoFin)
		BEGIN
			SELECT 'OK'			AS Estado,
				   'OK'			AS Mensaje ,	
				   fPorcentaje  AS fPorcentaje
			  FROM dbo.tblMitigacion 
			 WHERE codFamilia =@codFamilia 
			   AND @iPlazo 
		   BETWEEN iPlazoIni 
		       AND iPlazoFin		
		END
		ELSE
		BEGIN 
			SELECT 'NOK'				AS Estado,
				   'Plazo no definido'	AS Mensaje ,	
				   0					AS fPorcentaje  
		END
	END 	
	ELSE
	BEGIN 
		SELECT 'NOK'				AS Estado,
			   'Familia no definida'AS Mensaje ,	
			   0					AS fPorcentaje  
		 		 					
	END  
END 

-- Base de Datos --
GO
