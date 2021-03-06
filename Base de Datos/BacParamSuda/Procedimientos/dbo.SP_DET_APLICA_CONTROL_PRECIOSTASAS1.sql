USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DET_APLICA_CONTROL_PRECIOSTASAS1]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DET_APLICA_CONTROL_PRECIOSTASAS1]
	(	@verSistema		CHAR(3),
		@verProducto	VARCHAR(5),
		@rutCliente		NUMERIC(9,0) = -1,
		@codCliente		NUMERIC(9,0) = -1
	)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Aplica_CPT1	CHAR(1),
			@Aplica_CPT2	CHAR(1),
			@tipCli			NUMERIC(5,0)

		SELECT	@Aplica_CPT1 = 'N',
				@Aplica_CPT2 = 'N'	

	IF @rutCliente = -1 AND @codCliente = -1	/* No hay cliente */
		SELECT @Aplica_CPT1 = '*'
	ELSE
	BEGIN
		SELECT @tipCli = Cltipcli FROM Bacparamsuda..CLIENTE
		WHERE Clrut = @rutCliente AND Clcodigo = @codCliente
		IF EXISTS(SELECT aplicaControl FROM TBL_CLASCLTE_APLICAN_CONTROLPT
			WHERE tipoCliente = @tipCli)
			
			SELECT @Aplica_CPT1 = aplicaControl
			FROM TBL_CLASCLTE_APLICAN_CONTROLPT
			WHERE tipoCliente = @tipCli
	
	END
				
	IF EXISTS(SELECT aplicaControl FROM TBL_APLICAN_CONTROL_PRECIOSTASAS
		WHERE codSistema = @verSistema AND codProducto = @verProducto)

		SELECT @Aplica_CPT2 = aplicaControl
		FROM TBL_APLICAN_CONTROL_PRECIOSTASAS
		WHERE codSistema = @verSistema AND codProducto = @verProducto

	
	SELECT	@Aplica_CPT1 AS Aplica_CPT1 
	,		@Aplica_CPT2 AS Aplica_CPT2
	
	
END

GO
