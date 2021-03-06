USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAOPERGARANTIAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAOPERGARANTIAS]
	(	@numGarantia	NUMERIC(9),
		@rutCliente	NUMERIC(9),
		@codCliente	NUMERIC(5),
		@codSistema	CHAR(3),
		@numOperacion	NUMERIC(9)
	)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO tbl_Registro_Garantias(NumeroOperacion,
					RutCliente,
					CodCliente,
					Sistema,
					OperacionSistema)	 
				VALUES(	@numGarantia,
					@rutCliente,
					@codCliente,
					@codSistema,
					@numOperacion)
END
GO
