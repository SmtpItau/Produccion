USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_MERCADO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_MERCADO]
AS 
BEGIN
   SET NOCOUNT ON
   SELECT codigo_producto 
         ,descripcion 
     FROM VIEW_PRODUCTO 
    WHERE id_sistema = 'BCC'
   SET NOCOUNT OFF
END



GO
