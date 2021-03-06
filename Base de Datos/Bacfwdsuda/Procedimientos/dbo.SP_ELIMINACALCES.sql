USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINACALCES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINACALCES] ( @nNroOpe1     NUMERIC(6,0) ,
        @nNroOpe2     NUMERIC(6,0)  
 
      )
 
AS
BEGIN
SET NOCOUNT ON
 BEGIN TRANSACTION
 
 DECLARE @monto NUMERIC(21,4)      
  
   /*=======================================================================*/
   /*=======================================================================*/
 SELECT @monto = 0 
 SELECT @monto=ccmonto
 
 FROM MFCC
 
 WHERE ccopecmp = @nNroOpe1 AND 
              ccopevta = @nNroOpe2
       
 IF @@error <> 0 BEGIN
           ROLLBACK TRANSACTION
           SELECT -1, 'Error: en la lectura de calces.'
    SET NOCOUNT OFF
           RETURN
        END
        DELETE FROM MFCC
 WHERE ccopecmp = @nNroOpe1 AND 
              ccopevta = @nNroOpe2
 IF @@error <> 0 BEGIN
           ROLLBACK TRANSACTION
           SELECT -1, 'Error: en la eliminaci«n de calces.'
    SET NOCOUNT OFF
           RETURN
        END
        UPDATE MFCA
 SET camtocalzado = camtocalzado - @monto
 WHERE canumoper=@nNroOpe1
 
        UPDATE MFCA
 SET camtocalzado = camtocalzado - @monto
 WHERE canumoper=@nNroOpe2
 IF @@error <> 0 BEGIN
           ROLLBACK TRANSACTION
           SELECT -1, 'Error: en la actualizaci«n de calces en la cartera.'
    SET NOCOUNT OFF
           RETURN
        END
/*=======================================================================*/
/* Fin Transacci«n                                                       */
/*=======================================================================*/
 COMMIT TRANSACTION
SET NOCOUNT OFF
SELECT 0
END

GO
