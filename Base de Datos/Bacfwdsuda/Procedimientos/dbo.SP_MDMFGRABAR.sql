USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMFGRABAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDMFGRABAR]
       (
        @ncodmon     NUMERIC(5,0)    , -- C½digo Moneda
        @ncodfor     NUMERIC(9,0)    , -- C½digo Forma de Pago
        @cestado     CHAR(01)          -- Estado 
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   IF EXISTS(
              SELECT       mfestado
                     FROM  VIEW_MONEDA_FORMA_DE_PAGO
                     WHERE mfcodmon = @ncodmon AND 
                           mfcodfor = @ncodfor
            ) BEGIN
       UPDATE       VIEW_MONEDA_FORMA_DE_PAGO 
              SET   mfestado   = @cestado
              WHERE mfcodmon   = @ncodmon AND 
                    mfcodfor   = @ncodfor
   END ELSE BEGIN
      INSERT INTO VIEW_MONEDA_FORMA_DE_PAGO  (
                                   mfcodmon,
                                   mfcodfor,
                                   mfestado
                                 )
             VALUES              (
                                   @ncodmon,
                                   @ncodfor,
                                   @cestado
                                 )
   END
   /*=======================================================================*/
   /*=======================================================================*/
   
SET NOCOUNT OFF
SELECT 0
END

GO
