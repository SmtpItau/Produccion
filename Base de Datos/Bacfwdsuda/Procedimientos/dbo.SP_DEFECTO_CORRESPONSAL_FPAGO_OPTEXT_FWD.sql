USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEFECTO_CORRESPONSAL_FPAGO_OPTEXT_FWD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEFECTO_CORRESPONSAL_FPAGO_OPTEXT_FWD] (	@Origen AS VARCHAR(10),    
																	@CodMon AS NUMERIC(5),
																	@TipoCV AS VARCHAR(1),
																	@Cliente AS INT=0)

AS BEGIN

	IF NOT EXISTS(SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
					WHERE idPlataforma = @Origen 
					AND idMoneda1 = @CodMon 
					AND idOperacion = @TipoCV
					AND idCliente = @Cliente)
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
		FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
		WHERE idPlataforma = @Origen 
		AND idMoneda1 = @CodMon 
		AND idOperacion = @TipoCV
		AND idCliente = 0
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
		FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
		WHERE idPlataforma = @Origen 
		AND idMoneda1 = @CodMon 
		AND idOperacion = @TipoCV
		AND idCliente = @Cliente
	END
END
 
 
 
 
 
GO
