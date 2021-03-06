USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTENER_DATOS_FUENTEEXTERNA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OBTENER_DATOS_FUENTEEXTERNA]
	( 	 @codModulo		CHAR(3)
		,@codProducto		VARCHAR(5)
		,@codMoneda		VARCHAR(5)
		,@dias			INTEGER
                ,@tipoOper		CHAR(1)
		,@DatoFteExterna 	NUMERIC(19,4)OUTPUT 
	)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @codCurva	VARCHAR(20),
	@valBuscado		NUMERIC(19,4),
	@modo			CHAR(3)

	SELECT @DatoFteExterna = NULL

	IF @tipoOper = 'C'
		SELECT @modo = 'BID'
	ELSE
		SELECT @modo = 'ASK'

	EXECUTE SP_RETCURVA_CONTROL_PRECIOTASAS @codModulo, @codProducto, @codMoneda, @codCurva OUTPUT
	IF @codCurva IS NULL
	BEGIN
		SELECT @DatoFteExterna = NULL
		RETURN 0
	END
	EXECUTE SP_RETINTERPOLCURVAS @codCurva, @dias, @modo, @valBuscado OUTPUT
	SELECT @DatoFteExterna = @valBuscado
	RETURN 0
END

GO
