USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_GRABA_COLOR]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_GRABA_COLOR](
                                    @iUsuario    Char(15),    
                                    @iEstado     Char(1) ,
                                    @iColor1     Float   ,
                                    @iColor2     Float   
                                  )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


DECLARE @nColor1    FLOAT
DECLARE @nColor2    FLOAT

    SELECT  @nColor1=COLOR_DEFAULT_FONDO , 
            @nColor2=COLOR_DEFAULT_TEXTO 
    FROM COLOR 
    WHERE USUARIO = 'ADMINISTRA' AND ESTADO = @iEstado

    IF EXISTS( SELECT * FROM COLOR WHERE USUARIO=@iUsuario AND ESTADO=@iEstado ) BEGIN
        
        UPDATE COLOR 
        SET COLOR_FONDO = @iColor1,
            COLOR_TEXTO = @iColor2
        WHERE USUARIO=@iUsuario AND ESTADO=@iEstado
        
    END ELSE BEGIN
        
        INSERT COLOR 
        VALUES( @iUsuario , @iEstado , @iColor1 , @iColor2 , @nColor1 , @nColor2 )
        
    END

END
GO
