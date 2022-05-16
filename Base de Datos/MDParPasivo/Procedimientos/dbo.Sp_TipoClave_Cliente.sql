USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TipoClave_Cliente]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TipoClave_Cliente] 
                                       (@usuario CHAR(15))

AS
BEGIN
      
      SET NOCOUNT ON
      SET DATEFORMAT dmy

            SELECT Tipo_Clave,
                   Largo_Clave,
                   Dias_Expiracion
            FROM   USUARIO
            WHERE  usuario = @usuario


      SET NOCOUNT OFF

END








GO
