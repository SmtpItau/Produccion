USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_PROD_TCKINMESA_SPOT]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_PROD_TCKINMESA_SPOT]
AS
   BEGIN
      SELECT codigo_producto
         ,   descripcion
      FROM   BacParamSuda..PRODUCTO
      WHERE  Id_Sistema       = 'BCC' AND codigo_producto <> 'WEEK'
         AND ESTADO = 1
   END
   SET NOCOUNT OFF
GO
