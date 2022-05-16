USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Productos_X_Sistema]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Productos_X_Sistema]
      (
      @id_sistema      CHAR(3)
      )

AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

      SELECT 
             codigo_producto
            ,descripcion
            ,id_sistema 
      
      FROM PRODUCTO WHERE id_sistema = @id_sistema

END


GO
