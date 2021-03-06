USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLLEERNOMBRES1]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CLLEERNOMBRES1] (@clnombre1 char(40) = '',
				    @tipo      CHAR(1)= 'N')
AS
BEGIN
	DECLARE @TIPOCL NUMERIC(2)
	SELECT @TIPOCL = 0

	SET ROWCOUNT 50   

	IF @Tipo = 'S' 
        BEGIN
	   SELECT @tipocl = 3
	   SET ROWCOUNT 0   
	END

        SELECT  clrut     ,
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
                clfax 
         FROM   BacParamSuda..Cliente
	 WHERE (cltipcli <= @tipocl OR @tipocl = 0)
	 AND   (clnombre > @clnombre1 OR @clnombre1 = '')
	 AND   (clvigente = 'S')
         ORDER BY clnombre 

         SET ROWCOUNT 0   
END


GO
