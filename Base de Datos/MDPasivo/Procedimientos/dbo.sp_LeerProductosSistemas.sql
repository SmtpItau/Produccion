USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_LeerProductosSistemas]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_LeerProductosSistemas] 
       (
        @Sistema CHAR (05)
       )
AS
BEGIN


   	SET DATEFORMAT DMY
	SET NOCOUNT ON
 SELECT 
 codigo_producto, 
 descripcion
 FROM Producto
 WHERE id_sistema = @Sistema
END
GO
