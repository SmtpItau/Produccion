USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_PROCESO_ACTIVO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_PROCESO_ACTIVO] (
	@CodCategoria as int, 
	@NemoSistema as char(3)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT	tbtasa, tbglosa
	FROM	TABLA_GENERAL_DETALLE
	WHERE  tbcateg = @CodCategoria
	AND    ltrim(rtrim(nemo)) = ltrim(rtrim(@NemoSistema ))

END

GO
