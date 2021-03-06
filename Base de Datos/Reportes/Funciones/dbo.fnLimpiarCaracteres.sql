USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[fnLimpiarCaracteres]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnLimpiarCaracteres] ( @Cadena VARCHAR(MAX) )
RETURNS VARCHAR(MAX)
AS 
BEGIN
	/*
		Ejemplo
		select upper(dbo.fnLimpiarCaracteres('4C - LIQUIDEZ: INST. BCCH Y T.GRAL DE LA REPÚBLICA'))

		4C - LIQUIDEZ: INST. BCCH Y T.GRAL DE LA REPUBLICA
	*/
    RETURN 	
	REPLACE(REPLACE( /*vocales ÃÕ*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ÄËÏÖÜ*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ÂÊÎÔÛ*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ÀÈÌÒÙ*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ÁÉÍÓÚ*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ñÑçÇ  incluido espacio en blanco*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales äëïöü*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales âêîôû*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales àèìòù*/
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales áéíóú*/ @Cadena, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')		
			,'à','a'),'è','e'),'ì','i'),'ò','o'),'ù','u')
			,'â','a'),'ê','e'),'î','i'),'ô','o'),'û','u')
			,'ä','a'),'ë','e'),'ï','i'),'ö','o'),'ü','u')
			,'ñ','n'),'Ñ','N'),'ç','c'),'Ç','C'),' ',' ')
			,'Á','A'),'É','E'),'Í','I'),'Ó','O'),'Ú','U') 
			,'À','A'),'È','E'),'Ì','I'),'Ò','O'),'Ù','U') 
			,'Â','A'),'Ê','E'),'Î','I'),'Ô','O'),'Û','U')
			,'Ä','A'),'Ë','E'),'Ï','I'),'Ö','O'),'Ü','U') 
			,'Ã','A'),'Õ','O')  
END
GO
