USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_PRODUCTO]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[VIEW_PRODUCTO]
AS 
   SELECT
         'codigo_producto' = CASE  WHEN codigo_producto = 'CPX' THEN 'CP' 
				   WHEN codigo_producto = 'VPX' THEN 'VP' END
			     	 , 
         descripcion,
         id_sistema
   FROM BACPARAMSUDA..PRODUCTO 
   WHERE id_sistema = 'BEX' 


GO
