USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEFECTO_CORRESPONSAL_FPAGO_OPTEXT]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEFECTO_CORRESPONSAL_FPAGO_OPTEXT] ( @Origen AS VARCHAR(10),    
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

		SELECT	Default_iCodCorresponsal,
				Default_iCodCorresponsal_Desde,
				Default_iCodCorresponsal_Donde,
				Default_iCodCorresponsal_Quien,
				Default_iPL_Corres_Desde,
				Default_iPL_Corres_Donde,
				Default_iPL_Corres_Quien,
				Default_iFormaPagoMN,
				Default_iFormaPagoMX,
				Default_sCodigoOMA,
				Default_sCodigoComercio,
				Default_sCodigoConcepto,
				Default_sCodigoUsuario
		FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
		WHERE idPlataforma = @Origen 
		AND idMoneda1 = @CodMon 
		AND idOperacion = @TipoCV
		AND idCliente = 0
	END

	ELSE
	BEGIN

		SELECT	Default_iCodCorresponsal,
				Default_iCodCorresponsal_Desde,
				Default_iCodCorresponsal_Donde,
				Default_iCodCorresponsal_Quien,
				Default_iPL_Corres_Desde,
				Default_iPL_Corres_Donde,
				Default_iPL_Corres_Quien,
				Default_iFormaPagoMN,
				Default_iFormaPagoMX,
				Default_sCodigoOMA,
				Default_sCodigoComercio,
				Default_sCodigoConcepto,
				Default_sCodigoUsuario
		FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
		WHERE idPlataforma = @Origen 
		AND idMoneda1 = @CodMon 
		AND idOperacion = @TipoCV
		AND idCliente = @Cliente
	END
END
 
 
 
 
 
GO
