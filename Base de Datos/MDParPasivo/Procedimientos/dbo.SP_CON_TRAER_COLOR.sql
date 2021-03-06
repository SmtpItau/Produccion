USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TRAER_COLOR]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CON_TRAER_COLOR](
                                    @iUsuario    Char(15),
                                    @iDefault    Integer = 0
                                  )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    IF @iDefault <> 0 BEGIN
        SELECT   USUARIO
                ,ESTADO
                ,COLOR_DEFAULT_FONDO
                ,COLOR_DEFAULT_TEXTO
                ,COLOR_FONDO
                ,COLOR_TEXTO
        FROM COLOR
        WHERE USUARIO = 'ADMINISTRA'
    END ELSE BEGIN
        SELECT   USUARIO
                ,ESTADO
                ,COLOR_FONDO
                ,COLOR_TEXTO
                ,COLOR_DEFAULT_FONDO
                ,COLOR_DEFAULT_TEXTO
        FROM COLOR
        WHERE USUARIO = @iUsuario
    END

END
GO
