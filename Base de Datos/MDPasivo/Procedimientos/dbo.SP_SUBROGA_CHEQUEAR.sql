USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_SUBROGA_CHEQUEAR]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_SUBROGA_CHEQUEAR] (@usuario CHAR(15))
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT DMY
	SET NOCOUNT ON

	DECLARE	@subroga	CHAR(1)
	DECLARE @usuario_subr	CHAR(15)




	SELECT	distinct usuario1=USUARIO
	INTO	#tmp1
	FROM	excepcion_usuario WITH (NOLOCK)
	WHERE	usuario_subroga = @usuario


	SELECT	usuario
	FROM	USUARIO  WITH (NOLOCK), #tmp1
	WHERE	usuario=usuario1
	AND	subrogacion='S'
	AND	usuario<> @usuario

END


GO
