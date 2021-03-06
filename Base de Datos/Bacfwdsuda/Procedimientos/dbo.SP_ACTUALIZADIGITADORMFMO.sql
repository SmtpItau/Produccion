USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZADIGITADORMFMO]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZADIGITADORMFMO]
   (   @digitador  CHAR(15)
   ,   @numdocu    NUMERIC(10,0)
   )
AS
BEGIN

   /*
      JBH, 23-11-2009.  Actualiza el digitador en archivo mfmo, solo si el movimiento no está anulado.
   */

   UPDATE MFMO
      SET moDigitador  = @digitador
      WHERE monumoper    = @numdocu
      AND moestado    <> 'A'

   IF (SELECT monumope FROM BacCamSuda.dbo.MEMO WHERE monumfut = @numdocu) > 0
   BEGIN
      UPDATE BacCamSuda.dbo.MEMO
         SET modigitador = @digitador
         WHERE monumfut    = @numdocu
   END
   
END
GO
