USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_ARCHIVO_SUPER]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_ARCHIVO_SUPER]
		(
	        	@cFlag			CHAR(01)
	        ,	@cNemotecnico     	CHAR(12) = ''
	        ,	@cTipo_Instrumento 	CHAR(10) = ''
	        ,	@cMoneda 		CHAR(5)  = ''
	        ,	@cPrecio   		FLOAT    = 0.0
	        ,	@cPlazo        		FLOAT    = 0.0
	        ,	@cTir_Valorizacion 	FLOAT    = 0.0
	        ,	@cTir_Transaccion 	FLOAT    = 0.0
	        ,	@cCategoria		CHAR(5)  = ''
		)
AS
BEGIN
  IF @cFlag = 'G'
	BEGIN
	   INSERT INTO LINEA_TASA_SUPER
	        SELECT 	@cNemotecnico
	        ,	@cTipo_Instrumento
	        ,	@cMoneda
	        ,	@cPrecio
	        ,	@cPlazo
	        ,	@cTir_Valorizacion
	        ,	@cTir_Transaccion
	        ,	@cCategoria
	END

  IF @cFlag = 'E'
	BEGIN
	   DELETE FROM LINEA_TASA_SUPER
	END
END
GO
