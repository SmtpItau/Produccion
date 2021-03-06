USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_VALOR_DEFECTO_CARGA_EXT_SPOT]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRAE_VALOR_DEFECTO_CARGA_EXT_SPOT] ( @ORIGEN		VARCHAR(10),
                                                         		@CODMON     NUMERIC(5),
                                                         		@TIPOCV     VARCHAR(1),
                                                         		@CLIENTE	INT=0 )
AS
BEGIN

	IF NOT EXISTS(	SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
					WHERE idPlataforma   = @ORIGEN
					AND idMoneda1       = @CODMON
					AND idOperacion     = @TIPOCV
					AND idCliente	    = @CLIENTE)
	BEGIN
		   SELECT	Default_iCodCorresponsal_Quien,
					Default_iCodCorresponsal_Desde,
					Default_iCodCorresponsal_Donde,
					Default_iFormaPagoMN,
					Default_iFormaPagoMX,
					Default_sCodigoOMA,
					Default_sCodigoComercio,
					Default_sCodigoConcepto,
					Default_sCodigoUsuario
		   FROM CargaOperaciones_DefectoValores
		   WHERE idPlataforma   = @ORIGEN
			AND idMoneda1       = @CODMON
			AND idOperacion     = @TIPOCV
			AND idCliente	    = 0
	END

	ELSE
	BEGIN
		   SELECT	Default_iCodCorresponsal_Quien,
					Default_iCodCorresponsal_Desde,
					Default_iCodCorresponsal_Donde,
					Default_iFormaPagoMN,
					Default_iFormaPagoMX,
					Default_sCodigoOMA,
					Default_sCodigoComercio,
					Default_sCodigoConcepto,
					Default_sCodigoUsuario
		   FROM CargaOperaciones_DefectoValores
		   WHERE idPlataforma   = @ORIGEN
			AND idMoneda1       = @CODMON
			AND idOperacion     = @TIPOCV
			AND idCliente	    = @CLIENTE
	END
END
 
 
 
 
 
GO
