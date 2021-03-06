USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Load_Transfronterizo]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_Load_Transfronterizo]
	(	@nNemo		VARCHAR(20)
	,	@nRetorno	INT
	)	RETURNS		INT		--> 1: Codigo Segun tabla 42;	2: Codigo Segun Tabla 44
AS
BEGIN

	DECLARE @cRetorno		INT
		SET @cRetorno		= 0

	IF @nRetorno = 1
	BEGIN
		SELECT	@cRetorno		=	Tabla.Transfronterizo
		FROM	dbo.Tbl_Clasificacion_Instrumento	Clasificacion
				inner join (	select	IdAgencia
									,	Id
									,	CortoPlazo
									,	LargoPlazo
									,	Transfronterizo
								from	BacParamSuda.dbo.Clasificaciones_Agencia 
							)	Tabla	ON	Tabla.IdAgencia		= Clasificacion.Agencia
										and Tabla.LargoPlazo	= Clasificacion.Clasificacion
		WHERE	Clasificacion.Nemo	= @nNemo
	END

	IF @nRetorno = 2
	BEGIN	
		SET @cRetorno = 1
	END

	RETURN @cRetorno
END
GO
