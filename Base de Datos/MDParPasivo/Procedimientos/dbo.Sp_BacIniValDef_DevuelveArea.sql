USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacIniValDef_DevuelveArea]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_BacIniValDef_DevuelveArea]
AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	IF EXISTS(SELECT 1 FROM AREA_PRODUCTO ) BEGIN

		SELECT  codigo_area,
			descripcion

		FROM AREA_PRODUCTO
                ORDER BY descripcion  
                  

	END


	SET NOCOUNT ON

END



GO
