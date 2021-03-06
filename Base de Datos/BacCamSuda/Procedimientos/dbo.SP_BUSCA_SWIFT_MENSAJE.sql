USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_SWIFT_MENSAJE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_SWIFT_MENSAJE]
      (
         @COD_MSG        VARCHAR(6) 
      )
AS
BEGIN
SET NOCOUNT ON  
   SELECT codigo_mensaje_swift
         ,campo_nombre
         ,campo_descripcion
         ,campo_opcion
         ,campo_tipo
         ,campo_activo 
   FROM SWIFT_MENSAJE
  WHERE codigo_mensaje_swift   = @COD_MSG
SET NOCOUNT OFF
END



GO
