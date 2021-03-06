USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_RELAC_CLASCTE_PRECIOSTASAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNT_RELAC_CLASCTE_PRECIOSTASAS]
				(	@codTipo	NUMERIC(5,0),
					@aplica		CHAR(1) )
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT aplicaControl FROM BacParamsuda..TBL_CLASCLTE_APLICAN_CONTROLPT
				WHERE tipoCliente = @codTipo)

		UPDATE BacParamsuda..TBL_CLASCLTE_APLICAN_CONTROLPT
		SET aplicaControl = @aplica
		WHERE tipoCliente = @codTipo
	ELSE
		INSERT INTO BacParamsuda..TBL_CLASCLTE_APLICAN_CONTROLPT
		VALUES(@codTipo, @aplica)
END
GO
