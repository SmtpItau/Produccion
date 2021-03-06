USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_GRABAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_GRABAR]
				(
				@dFecPro 	DATETIME	,
				@cSistema	CHAR	(03)	,
				@cProducto	CHAR	(05)	,
				@nCodInst	NUMERIC	(05,0)	,
				@nNumoper	NUMERIC	(10,0)	,
				@nMonto		NUMERIC	(19,4)	,
				@dFecvctop	DATETIME	,
				@cUsuario	CHAR	(15)	,
				@cCheckLimOp	CHAR	(1)	,
				@cCheckLimInst	CHAR	(1)
			)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO VIEW_LIMITE_TRANSACCION
	SELECT	@dFecPro 	,
		@nNumoper	,
		@cSistema	,
		@cProducto	,
		@nCodInst	,
		@nMonto		,
		@dFecvctop	,
		@cUsuario	,
		@cCheckLimOp	,
		@cCheckLimInst	

	
	SET NOCOUNT OFF

END

GO
