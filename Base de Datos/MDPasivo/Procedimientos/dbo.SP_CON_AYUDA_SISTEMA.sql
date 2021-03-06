USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_AYUDA_SISTEMA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CON_AYUDA_SISTEMA]
                                            @id_sistema            CHAR(03)
                                         ,  @nombre_formulario     CHAR(100) 
AS
BEGIN
    
    SET NOCOUNT ON
    SET DATEFORMAT dmy

    DECLARE @ruta_archivo  CHAR(255)
    DECLARE @id_contexto   NUMERIC(10)

    SET @ruta_archivo = ' '
    SET @id_contexto  = 0

    SET ROWCOUNT 1

    SELECT @ruta_archivo = ISNULL(ruta_archivo,' ')
          ,@id_contexto  = ISNULL(id_contexto,0)
        FROM AYUDA_SISTEMA
        WHERE UPPER(nombre_formulario) = UPPER(@nombre_formulario)
        AND   (id_sistema = @id_sistema OR @id_sistema = ' ')

    SET ROWCOUNT 0
    
    SET NOCOUNT OFF
    
    SELECT @ruta_archivo, @id_contexto

END



GO
