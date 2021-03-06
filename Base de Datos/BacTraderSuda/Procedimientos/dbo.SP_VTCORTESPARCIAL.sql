USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VTCORTESPARCIAL]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VTCORTESPARCIAL]
                                   ( @nRutcart   NUMERIC  (9,0) ,
                                     @nNumdocu   NUMERIC (10,0) ,
                                     @nCorrela   NUMERIC  (5,0) ,
                                     @nNumoper   NUMERIC (10,0) ,
                                     @nCantcort  NUMERIC (19,4) ,
                                     @nMontcort  NUMERIC (19,4) )
AS
BEGIN
set nocount on
       /*--------------------------------------------------------*
        * registrar los cortes vendidos,asociados a la venta.-   *
        *--------------------------------------------------------*/

          INSERT INTO MDCV ( cvrutcart    ,
                             cvnumdocu    ,
                             cvcorrela    ,
                             cvnumoper    ,
                             cvcantcort   ,
                             cvmtocort    ,
                             cvtipoper    ,
                             cvstatreg    )
                 VALUES   (  @nRutcart    ,
                             @nNumdocu    ,
                             @nCorrela    ,
                             @nNumoper    ,
                             @nCantcort   ,
                             @nMontcort   ,
                             ''           ,  
                             ''           )
       /*--------------------------------------------------------*
        * rebajar los cortes disponibles.-                       *
        *--------------------------------------------------------*/
          UPDATE MDCO  SET cocantcortd = cocantcortd - @nCantcort
                       WHERE corutcart = @nRutcart   AND
                             conumdocu = @nNumdocu   AND
                             cocorrela = @nCorrela   AND
                             comtocort = @nMontcort
SELECT 'OK'
set nocount off
RETURN
END

GO
