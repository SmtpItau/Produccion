USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO]
                  (
                   @sistema CHAR(3)
                  )
AS 
BEGIN

	SET NOCOUNT ON

      	SELECT	codigo_producto	,
		descripcion	,
		id_sistema 
          FROM 	VIEW_PRODUCTO
	 WHERE	id_sistema = @sistema
	 ORDER BY descripcion 

	SET NOCOUNT OFF

END
GO
