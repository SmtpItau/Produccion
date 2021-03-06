USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDMPLeer]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMPLeer    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMPLeer    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
/*==========================================================================*/
/*==========================================================================*/
CREATE PROCEDURE [dbo].[Sp_MDMPLeer]
       (
        @ncodprod    NUMERIC(5,0)      -- C«digo Producto
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT       mncodmon     ,
                mnglosa      ,
                "estado" = ISNULL((SELECT       mpestado 
                                          FROM  MDMP 
                                          WHERE mpproducto = @ncodprod  AND
                                                mncodmon   =  mpcodigo), "0" )
             FROM  MONEDA
             WHERE mnrefmerc <> "1"
   /*=======================================================================*/
   /*=======================================================================*/
 SET NOCOUNT OFF
END






GO
