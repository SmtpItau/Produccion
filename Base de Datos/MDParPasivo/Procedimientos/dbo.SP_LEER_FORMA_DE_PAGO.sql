USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_FORMA_DE_PAGO]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LEER_FORMA_DE_PAGO]

AS 
BEGIN
      SET NOCOUNT ON
      SET DATEFORMAT dmy

      SELECT 

             codigo
      ,      perfil

      FROM      FORMA_DE_PAGO
      WHERE   ESTADO<>'A'

      ORDER BY 
                GLOSA

      SET NOCOUNT OFF
END



GO
