USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDRCGrabarGruposCarteras]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_MDRCGrabarGruposCarteras]
       (
        @Codigo_Grupo  CHAR(5)        	,
        @Descripcion_Grupo CHAR(50)    	
       )
AS 
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy
   IF EXISTS(
              SELECT Descripcion
                     FROM TIPO_GRUPO_CARTERA
                     WHERE 	Codigo_Grupo_Cartera = @Codigo_Grupo
            ) BEGIN
      UPDATE       TIPO_GRUPO_CARTERA
             SET  
			Descripcion = @Descripcion_Grupo
             WHERE 
			Codigo_Grupo_Cartera = @Codigo_Grupo
    END ELSE BEGIN
      INSERT INTO TIPO_GRUPO_CARTERA 	(
					Codigo_Grupo_Cartera	,
					Descripcion
                         		)
             VALUES      		( 
					@Codigo_Grupo	,
					@Descripcion_Grupo
					)
   END
SET NOCOUNT OFF
SELECT 0
END

GO
