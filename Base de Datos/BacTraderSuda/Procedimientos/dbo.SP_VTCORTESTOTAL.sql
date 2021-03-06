USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VTCORTESTOTAL]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VTCORTESTOTAL]
                                 ( @nRutcart   NUMERIC  (9,0) ,
                                   @nNumdocu   NUMERIC (10,0) ,
                                   @nCorrela   NUMERIC  (5,0) ,
                                   @nNumoper   NUMERIC (10,0) )
AS
BEGIN
set nocount on 
 INSERT INTO 
 MDCV(
  cvrutcart    ,
  cvnumdocu    ,
  cvcorrela    ,
  cvnumoper    ,
  cvcantcort   ,
  cvmtocort    ,
  cvtipoper    ,
  cvstatreg    )
 SELECT  
  @nRutcart    ,
  @nNumdocu    ,
  @nCorrela    ,
  @nNumoper    ,
  cocantcortd  ,
  comtocort    ,
  ''           ,
  ''
 FROM 
  MDCO
 WHERE 
  corutcart    =  @nRutcart   
 AND conumdocu    =  @nNumdocu
 AND cocorrela    =  @nCorrela
 AND cocantcortd  >  0
 IF @@ERROR<>0 BEGIN 
  SELECT  'ERROR_PROC  PROBLEMAS EN LA GRABACIÓN DE CORTES VENDIDOS'
  set nocount off
  RETURN 1
 END
 UPDATE MDCO  
 SET cocantcortd = 0
 WHERE  corutcart    =  @nRutcart   
 AND conumdocu    =  @nNumdocu   
 AND cocorrela    =  @nCorrela   
 AND cocantcortd  >  0
 IF @@ERROR<>0 BEGIN 
  SELECT  'ERROR_PROC  PROBLEMAS EN LA ACTUALIZACIÓN DE CORTES '
  set nocount off
  RETURN 1
 END
SELECT 'OK'
set nocount off
       RETURN 0
END

GO
