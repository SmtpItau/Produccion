USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBPRODUCTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CMBPRODUCTO]
AS 
BEGIN
 SET NOCOUNT ON
	SELECT   codigo_producto, 
		  descripcion, 
		  id_sistema 
	FROM BacParamSuda.dbo.PRODUCTO
	WHERE id_sistema = 'BFW'
	ORDER BY  descripcion

 SET NOCOUNT OFF
END

GO
