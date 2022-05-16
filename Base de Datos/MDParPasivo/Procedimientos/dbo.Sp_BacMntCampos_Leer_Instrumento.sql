USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntCampos_Leer_Instrumento]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_BacMntCampos_Leer_Instrumento]
            (
            @id_sistema      CHAR(3)
            )

AS 
BEGIN
      SET NOCOUNT ON
      SET DATEFORMAT dmy

      IF @id_sistema = 'BTR' BEGIN

            SELECT 

                   incodigo 
            ,      inserie      
            ,      inglosa

            FROM      INSTRUMENTO
            
            ORDER BY 
                      inglosa
      END

      SET NOCOUNT OFF
END



GO
