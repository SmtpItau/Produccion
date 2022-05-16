USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TIP_OPERACION]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_TIP_OPERACION]
   (   @cSistema   CHAR(3)   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT codigo_producto , descripcion
       FROM PRODUCTO 
      WHERE id_sistema = @cSistema

END



GO
