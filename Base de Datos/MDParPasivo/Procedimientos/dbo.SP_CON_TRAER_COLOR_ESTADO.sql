USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TRAER_COLOR_ESTADO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CON_TRAER_COLOR_ESTADO]
                                        (  
                                            @iUsuario    Char(15),
                                            @iEstado     Char(1) ,
                                            @iTodos      Integer = 0
                                        )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

    
IF @iTodos <> 0 BEGIN

    IF EXISTS( SELECT * FROM COLOR WHERE USUARIO=@iUsuario ) BEGIN
        
        SELECT 
                ESTADO     ,
                COLOR_FONDO,
                COLOR_TEXTO                
        FROM COLOR 
        WHERE USUARIO=@iUsuario
        
    END ELSE BEGIN

        SELECT 
                ESTADO             ,
                COLOR_DEFAULT_FONDO,
                COLOR_DEFAULT_TEXTO
        FROM COLOR 
        WHERE USUARIO='ADMINISTRA'                 
        
    END

END ELSE BEGIN

    IF EXISTS( SELECT * FROM COLOR WHERE USUARIO=@iUsuario AND ESTADO=@iEstado ) BEGIN

        SELECT 
                COLOR_FONDO,
                COLOR_TEXTO
        FROM COLOR 
        WHERE USUARIO=@iUsuario AND ESTADO=@iEstado

    END ELSE BEGIN

        SELECT 
                COLOR_DEFAULT_FONDO,
                COLOR_DEFAULT_TEXTO
        FROM COLOR 
        WHERE USUARIO='ADMINISTRA' AND ESTADO=@iEstado
        
    END

END

END
GO
