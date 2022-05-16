USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_PROD_TCKINMESA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_PROD_TCKINMESA]
AS
   BEGIN
      SELECT codigo_producto
         ,   descripcion
      FROM   BacParamSuda..PRODUCTO
      WHERE  Id_Sistema       = 'BFW'
         AND codigo_producto  IN(1, 2,3,10,12)
   END
   SET NOCOUNT OFF
GO
