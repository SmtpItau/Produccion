USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLLEERNOMBRES1]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLLEERNOMBRES1] (@clnombre1 CHAR(40))
AS
BEGIN
       SET ROWCOUNT 50
       SELECT   clrut     ,
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
                clfax     ,
                mxcontab  ,
                clpais    ,
                clciudad  ,
		clvigente
        FROM	cliente
	WHERE 	clnombre >= @clnombre1 
        ORDER BY clnombre

	SET ROWCOUNT 0

END
GO
