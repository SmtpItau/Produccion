USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDMPGrabar]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMPGrabar    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDMPGrabar    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
/*==========================================================================*/
/*==========================================================================*/
CREATE PROCEDURE [dbo].[Sp_MDMPGrabar]
       (
        @ncodprod    NUMERIC(5,0)    , -- C¢digo Producto
        @ncodigo     NUMERIC(5,0)    , -- C¢digo Moneda
        @cestado     CHAR(01)          -- Estado de la moneda
       )
AS
BEGIN
   /*=======================================================================*/
   /*=======================================================================*/
   IF EXISTS(
              SELECT       mpestado
                     FROM  MDMP
                     WHERE mpproducto = @ncodprod AND 
                           mpcodigo   = @ncodigo
            ) BEGIN
      UPDATE       MDMP 
             SET   mpestado   = @cestado,
          mpSistema = 'PCS' 
             WHERE mpproducto = @ncodprod AND 
                   mpcodigo   = @ncodigo
   END ELSE BEGIN
      INSERT INTO MDMP (
                        mpproducto,
                        mpcodigo,
                        mpestado,
   mpSistema
                       )
             VALUES    (
                        @ncodprod,
                        @ncodigo,
                        @cestado,
   'PCS'
                       )
   END
   /*=======================================================================*/
   /*=======================================================================*/
   RETURN
END






GO
