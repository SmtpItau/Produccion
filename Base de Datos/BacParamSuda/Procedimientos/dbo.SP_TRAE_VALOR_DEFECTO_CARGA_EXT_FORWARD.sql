USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_VALOR_DEFECTO_CARGA_EXT_FORWARD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRAE_VALOR_DEFECTO_CARGA_EXT_FORWARD] (	@ORIGEN		VARCHAR(10),
                                                            		@CODMON		NUMERIC(5),
                                                            		@TIPOCV		VARCHAR(1),
                                                            		@CLIENTE	INT=0 )
AS
BEGIN

	IF NOT EXISTS(	SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
					WHERE idPlataforma  = @ORIGEN
					AND idMoneda1     = @CODMON
					AND idOperacion   = @TIPOCV
					AND idCliente	  = @CLIENTE)
	BEGIN
		   SELECT	Default_iFormaPagoMN,
					Default_iFormaPagoMX,
					Default_sCodAreaResponable,
					Default_sCodCartNormativa,
					Default_sCodSubCartNormativa,
					Default_sCodigoLibro,
					Default_iCodidogCartera,
					Default_iCodigoBroker,
					Default_iTipRetiro,
					Default_sCodigoUsuario
		  FROM  CargaOperaciones_DefectoValores
		  WHERE idPlataforma  = @ORIGEN
			AND idMoneda1     = @CODMON
			AND idOperacion   = @TIPOCV
			AND idCliente	  = 0
	END

	ELSE
	BEGIN
		   SELECT	Default_iFormaPagoMN,
					Default_iFormaPagoMX,
					Default_sCodAreaResponable,
					Default_sCodCartNormativa,
					Default_sCodSubCartNormativa,
					Default_sCodigoLibro,
					Default_iCodidogCartera,
					Default_iCodigoBroker,
					Default_iTipRetiro,
					Default_sCodigoUsuario
		  FROM  CargaOperaciones_DefectoValores
		  WHERE idPlataforma  = @ORIGEN
			AND idMoneda1     = @CODMON
			AND idOperacion   = @TIPOCV
			AND idCliente	  = @CLIENTE
	END
END
 
 
 
 
GO
