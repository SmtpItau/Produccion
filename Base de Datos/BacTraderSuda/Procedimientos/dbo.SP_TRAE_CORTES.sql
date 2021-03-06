USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_CORTES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_CORTES]
   (   @numdocu 	VARCHAR(15) = 'ADMINISTRA'
   ,   @correlativo	INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON

   IF NOT EXISTS( SELECT 1 FROM MDCO WHERE conumdocu = @numdocu AND cocorrela = @correlativo )
   BEGIN
      SELECT corutcart   = 0
         ,   conumdocu   = 0
         ,   cocorrela   = 0
         ,   comtocort   = 0          
         ,   cocantcortd = 0        
         ,   cocantcorto = 0

   END ELSE
   BEGIN
	SELECT  corutcart
	,   	conumdocu    
	,   	cocorrela 
	,   	comtocort             
	,   	cocantcortd           
	,   	cocantcorto 
	FROM    MDCO 
	WHERE   conumdocu = @numdocu
	AND     cocorrela = @correlativo
   END

END

GO
