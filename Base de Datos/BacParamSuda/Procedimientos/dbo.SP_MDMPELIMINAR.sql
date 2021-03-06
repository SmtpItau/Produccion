USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMPELIMINAR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMPEliminar    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMPEliminar    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
/*==========================================================================*/
CREATE PROCEDURE [dbo].[SP_MDMPELIMINAR]
       (
        @ncodprod    NUMERIC(5,0)      -- C«digo Producto
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   IF EXISTS(
              SELECT 
   mpproducto   ,
   mpcodigo     ,
   mpestado     
       FROM MDMP 
              WHERE mpproducto = @ncodprod
            ) BEGIN
      DELETE FROM mdmp WHERE mpproducto = @ncodprod
   END
   /*=======================================================================*/
   /*=======================================================================*/
   
SET NOCOUNT OFF
SELECT 0
END

GO
