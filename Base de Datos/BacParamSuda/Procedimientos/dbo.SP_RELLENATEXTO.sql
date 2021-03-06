USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RELLENATEXTO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RELLENATEXTO]
	(	@texto	 VARCHAR(1024),
		@relleno VARCHAR(1),
		@largo   NUMERIC(5),
		@sentido NUMERIC(1),
		@stexto VARCHAR(1024) OUTPUT
	)
AS
BEGIN
	SET NOCOUNT ON
	IF LEN(@relleno) = 0
	BEGIN
		SELECT @stexto = @texto
		RETURN 0
	END
	IF LEN(@texto) > @largo
	BEGIN
		SELECT @stexto = @texto
		RETURN 0
	END

	DECLARE @i  NUMERIC(9),
		    @orelleno VARCHAR(1),
		    @cambio CHAR(1)

	SET @orelleno = @relleno
	IF @relleno = ' '
		SELECT @relleno = '.',
			 @cambio = 'S'
	ELSE
		SELECT @cambio = 'N'

	SET @i = 1

	WHILE @i <= @largo
	BEGIN
		IF LEN(@texto) >= @largo
			SELECT @i = @largo
		ELSE
			IF @sentido = 1
				SELECT @texto = @relleno + @texto
			ELSE
				SELECT @texto = @texto + @relleno

		SELECT @i = @i + 1
	END
	IF @cambio = 'S'
		SELECT @texto = REPLACE(@texto, @relleno, @orelleno)

	SELECT @stexto = @texto
	SET NOCOUNT OFF
END
GO
