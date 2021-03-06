USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLLEERRUT1]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CLLEERRUT1] 
               (   @clrut1  numeric(9,0) ,
   		   @clcodigo  numeric(9,0) )
AS
BEGIN
  SET NOCOUNT ON
  
  SELECT  	clrut     ,
                cldv      ,
                clcodigo  , 
                clnombre  ,
                clgeneric ,
                cldirecc  ,
  		clcomuna  ,
                clregion  ,
                clcompint ,
                cltipcli  ,
                clfecingr ,
                clctacte  ,
                clfono    ,
                clfax	  ,
		clvigente
 FROM BacParamSuda..Cliente
 WHERE clrut   = @clrut1
 AND clcodigo = @clcodigo

 SET NOCOUNT OFF
 RETURN
END

GO
