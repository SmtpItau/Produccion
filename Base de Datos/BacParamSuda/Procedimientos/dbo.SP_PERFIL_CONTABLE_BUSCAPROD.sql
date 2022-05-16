USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PERFIL_CONTABLE_BUSCAPROD]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Perfil_Contable_BuscaProd    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_PERFIL_CONTABLE_BUSCAPROD]
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
