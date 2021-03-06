USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EXISTE_PRECIO_DIVISA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EXISTE_PRECIO_DIVISA]
	(
		@fecha datetime,
		@codigo_moneda numeric(5,0) = 13, --Default USD (=13) extensible a futuro.
		@perfil_comercial char(6) = 3, --Perfil según tabla COSTOS_COMEX
		@tipo_operacion char(6) = '', --sin implementar ('BID' o 'ASK')
		@monto_operacion numeric(18,4) = 0 --sin implementar
	)
AS
BEGIN

	SET NOCOUNT ON;

	--select 0;
	--RETURN 0;

	DECLARE @FechaActual AS CHAR(8)
	SET @FechaActual = CONVERT(CHAR(8), (SELECT acfecpro FROM dbo.MEAC), 112)

	IF @fecha = '' OR @fecha = null
	RETURN 0;

	SET @fecha = CONVERT(CHAR(8), (@fecha), 112)
	IF @fecha <> @FechaActual
	RETURN 0;

	DECLARE @existe AS INT;
	SET @existe = 0;
	SET @existe =
	(
		SELECT COUNT(*)
			FROM	costos_comex
			WHERE	Costo_Compra > 0 AND Costo_Venta > 0
			 AND	Fecha				= @FechaActual
			 AND	PERFIL_COMERCIAL	= @perfil_comercial
			 AND	CodMoneda			= @codigo_moneda
	)

	IF @@ERROR <> 0  
		RETURN 0

	IF @existe > 0
		SELECT 1
	ELSE
		SELECT 0

END
GO
