USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TIPOCLAVE_CLIENTE]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TIPOCLAVE_CLIENTE] 
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
