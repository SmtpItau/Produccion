USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBPRODUCTOTHRESHOLD]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CMBPRODUCTOTHRESHOLD]
   (   @nSistema   CHAR(5)   )
AS 
BEGIN

   SET NOCOUNT ON

   SELECT codigo_producto
      ,   descripcion
      ,   id_sistema 
      ,   ProdCodigo = CASE WHEN id_sistema = 'PCS' AND codigo_producto = 'ST' THEN '1'
                            WHEN id_sistema = 'PCS' AND codigo_producto = 'SM' THEN '2'
                            WHEN id_sistema = 'PCS' AND codigo_producto = 'FR' THEN '3'
                            WHEN id_sistema = 'PCS' AND codigo_producto = 'SP' THEN '4'
                            ELSE codigo_producto
                        END
   FROM   BacParamSuda.dbo.PRODUCTO with(nolock)
   WHERE  id_sistema = @nSistema
     and  Estado     = 1
   ORDER BY  descripcion
END

GO
