USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARCALCESOPE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARCALCESOPE] ( @nProCom  NUMERIC (  3, 0 ),
                                      @nNroCom  NUMERIC ( 10, 0 ),
                                      @nProVen  NUMERIC (  3, 0 ),
                                      @nNroVen  NUMERIC ( 10, 0 ),
                                      @nMtoCal  NUMERIC ( 21, 4 ),
                                      @dFecVcto DATETIME         ,
                                      @dFecCal  DATETIME         ,
                                      @sUsuario CHAR ( 10 )
                                    )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @nmtoant NUMERIC ( 21, 04 )
   SELECT  @nmtoant = 0
 
   IF @nMtoCal = 0
   BEGIN
      SELECT @nmtoant = ccmonto 
      FROM   MFCC
      WHERE  ccposvta = @nProVen AND
             ccopevta = @nNroVen AND
             ccposcmp = @nProCom AND
             ccopecmp = @nNroCom
      DELETE
      FROM  MFCC
      WHERE ccposvta = @nProVen AND
            ccopevta = @nNroVen AND
            ccposcmp = @nProCom AND
            ccopecmp = @nNroCom
      UPDATE MFCA
      SET    camtocalzado = camtocalzado + ( @nmtocal - @nmtoant )
      WHERE  canumoper = @nnrocom
  
      UPDATE MFCA
      SET    camtocalzado = camtocalzado + ( @nmtocal - @nmtoant )
      WHERE  canumoper = @nnroven
      RETURN
   END
   IF EXISTS ( SELECT ccmonto
               FROM   MFCC
               WHERE  ccposvta = @nProVen AND
                      ccopevta = @nNroVen AND
                      ccposcmp = @nProCom AND
                      ccopecmp = @nNroCom
             )
   BEGIN
      SELECT @nmtoant = ccmonto
      FROM   MFCC
      WHERE  ccposvta = @nProVen AND
             ccopevta = @nNroVen AND
             ccposcmp = @nProCom AND
             ccopecmp = @nNroCom
      UPDATE MFCC
      SET    ccposcmp  = @nProCom ,
             ccopecmp  = @nNroCom ,
             ccposvta  = @nProVen ,
             ccopevta  = @nNroVen ,
             ccmonto   = @nMtoCal ,
             ccfecven  = @dFecVcto,
             ccfecuact = @dFecCal ,
             ccusuario = @sUsuario
      WHERE  ccposvta = @nProVen AND  
             ccopevta = @nNroVen AND
             ccposcmp = @nProCom AND  
             ccopecmp = @nNroCom AND
             ccfecven= @dFecVcto     
   END
   ELSE
   BEGIN
  
      SELECT @nmtoant = 0
      INSERT
      INTO   MFCC
      VALUES ( @nProCom ,
               @nNroCom ,
               @nProVen ,
               @nNroVen ,
               @nMtoCal ,
               @dFecVcto,
               @dFecCal ,
               @sUsuario
             )
   END
   UPDATE MFCA
   SET    camtocalzado = camtocalzado + ( @nmtocal - @nmtoant )
   WHERE  canumoper = @nnrocom
  
   UPDATE MFCA
   SET    camtocalzado = camtocalzado + ( @nmtocal - @nmtoant )
   WHERE  canumoper = @nnroven
  
   SET NOCOUNT OFF
END

GO
