USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_SUBROGA_GRABAR]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SUBROGA_GRABAR] (	@usuario CHAR(15),
						@subroga	CHAR(1))
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	UPDATE	usuario
	SET	subrogacion=@subroga
	WHERE	usuario = @usuario

	SET NOCOUNT OFF

END
-- SP_SUBROGA_LEER 'ADMINISTRA'
--select * from excepcion_usuario
GO
