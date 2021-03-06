USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntCampos_Leer_Producto]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_BacMntCampos_Leer_Producto]  
            (
            @id_sistema      CHAR(3) = ' '
            )

AS 
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


      SELECT 

             codigo_producto
      ,      descripcion
      ,      id_sistema
      ,      contabiliza

      FROM      PRODUCTO

      WHERE 
                        
            (id_sistema = @id_sistema OR @id_sistema = ' ')
        AND contabiliza = 'S'

      ORDER BY 
                descripcion

      SET NOCOUNT OFF
END
GO
