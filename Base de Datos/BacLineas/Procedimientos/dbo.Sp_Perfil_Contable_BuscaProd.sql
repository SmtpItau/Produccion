USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Perfil_Contable_BuscaProd]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Perfil_Contable_BuscaProd    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[Sp_Perfil_Contable_BuscaProd]
                                    ( @pareid_sistema  CHAR(03)
          )
AS
BEGIN
SET NOCOUNT ON
  SELECT 
   codigo_producto,
   descripcion
  FROM
   PRODUCTO
  WHERE  
   id_sistema  = @pareid_sistema
 
SET NOCOUNT OFF
END






GO
