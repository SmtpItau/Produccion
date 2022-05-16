USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_SUBROGA_LEER]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_SUBROGA_LEER] (@usuario CHAR(15))
AS
BEGIN

	SET NOCOUNT ON

	DECLARE	@subroga	CHAR(1)
	DECLARE @usuario_subr	CHAR(15)


	SELECT	@subroga=subrogacion
	FROM	USUARIO
	WHERE	usuario = @usuario


	SELECT	@usuario_subr = usuario_subroga
	FROM	excepcion_usuario
	WHERE	usuario = @usuario
	GROUP BY usuario_subroga

	SELECT	@subroga, @usuario_subr


	SET NOCOUNT OFF

END
-- SP_SUBROGA_LEER 'ADMINISTRA'
--select * from excepcion_usuario

GO
