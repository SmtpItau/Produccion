USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_APLICAN_CONTROL_PRECIOSTASAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNT_APLICAN_CONTROL_PRECIOSTASAS]
				(	@codSis		CHAR(3),
					@codProd	CHAR(5),
					@aplica		CHAR(1) )
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT codSistema FROM BacParamsuda..TBL_APLICAN_CONTROL_PRECIOSTASAS
				WHERE codSistema = @codSis AND codProducto = @codProd)

		UPDATE BacParamsuda..TBL_APLICAN_CONTROL_PRECIOSTASAS
		SET aplicaControl = @aplica
		WHERE codSistema = @codSis AND codProducto = @codProd
	ELSE
		INSERT INTO BacParamsuda..TBL_APLICAN_CONTROL_PRECIOSTASAS
		VALUES(@codSis, @codProd, @aplica)
END
GO
