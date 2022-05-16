USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntCampos_Leer_Evento]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_BacMntCampos_Leer_Evento]

AS 
BEGIN

      SET NOCOUNT ON
      SET DATEFORMAT dmy

      SELECT 
                   codigo_evento 
            ,      descripcion_campo

      FROM      EVENTO_CONTABLE
      ORDER BY 
                  descripcion_campo


      SET NOCOUNT OFF

END


GO
