USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_MNT_RELACION_FPAGO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_MNT_RELACION_FPAGO]
	(	@iTag			SMALLINT
	,	@cOrigen		VARCHAR(5)
	,	@CodExterno		VARCHAR(20) = ''
	,	@CodInterno		SMALLINT	= 0
	)
AS
BEGIN

	SET NOCOUNT ON

	IF @iTag = 1
	BEGIN
		SELECT  nCodExterno		= nCodExterno
			,	cDescripcion	= cDescripcion
			,	nCodInterno		= isnull( Fpa.codigo, 0)
			,	nDesInterno		= isnull( Fpa.Glosa,  '')
		FROM	dbo.SADP_RELACION_FPAGO
				LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO Fpa ON Fpa.codigo = nCodInterno
		WHERE	cOrigen			= @cOrigen
	END

	IF @iTag = 2
	BEGIN
		UPDATE dbo.SADP_RELACION_FPAGO 
		   SET nCodInterno	= @CodInterno 
		 WHERE cOrigen		= @cOrigen 
		   AND nCodExterno	= @CodExterno
	END

END
GO
