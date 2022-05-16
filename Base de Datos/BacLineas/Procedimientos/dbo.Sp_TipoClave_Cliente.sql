USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TipoClave_Cliente]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_TipoClave_Cliente] 
                                       (@usuario CHAR(15))
AS
BEGIN
      
      SET NOCOUNT ON
            SELECT Tipo_Clave,
                   Largo_Clave,
                   Dias_Expiracion
            FROM   USUARIO
            WHERE  usuario = @usuario
      SET NOCOUNT OFF
END






GO
