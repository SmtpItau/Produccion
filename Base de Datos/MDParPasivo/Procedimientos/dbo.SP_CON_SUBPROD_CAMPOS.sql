USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SUBPROD_CAMPOS]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_SUBPROD_CAMPOS]
              (   @nCodigo_Campo    CHAR(5)
              ,   @nTipo            NUMERIC(1) )
AS
BEGIN


   	SET DATEFORMAT DMY
	SET NOCOUNT ON

    DECLARE @cConsulta   VARCHAR(255)    


    IF @nTipo = 1 BEGIN

       SELECT   codigo_campo
           ,    nombre_campo
           ,    tabla_relacion
           ,    campo_consulta
           FROM RELACION_CAMPO_SUBPRODUCTO
           ORDER BY codigo_campo

    END ELSE
    BEGIN

       SELECT   @cConsulta = campo_consulta
         FROM   RELACION_CAMPO_SUBPRODUCTO
        WHERE   codigo_campo  = @nCodigo_Campo

         EXEC   (@cConsulta)

    END


    SET NOCOUNT OFF

END
GO
