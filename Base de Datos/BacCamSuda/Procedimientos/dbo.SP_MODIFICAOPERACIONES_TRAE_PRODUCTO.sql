USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICAOPERACIONES_TRAE_PRODUCTO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MODIFICAOPERACIONES_TRAE_PRODUCTO]
            (   @SISTEMA   CHAR(3)='')
AS 
BEGIN
   SELECT CODIGO_PRODUCTO
          , DESCRIPCION
          , ID_SISTEMA
   FROM   VIEW_PRODUCTO
   WHERE ID_SISTEMA = @SISTEMA -- 'BCC'
   ORDER BY CODIGO_PRODUCTO
END

GO
