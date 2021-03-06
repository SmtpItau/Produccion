USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Productos_Sistemas]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Sp_Leer_Productos_Sistemas]
   (
         @SISTEMA      CHAR(3) = 'BTR'
   )
AS
BEGIN


   	SET DATEFORMAT DMY
	SET NOCOUNT ON

   SELECT   codigo_producto
   ,        descripcion
   FROM     PRODUCTO 
   WHERE    id_sistema  = @SISTEMA
   AND      contabiliza = 'S'
   ORDER BY descripcion

END


GO
