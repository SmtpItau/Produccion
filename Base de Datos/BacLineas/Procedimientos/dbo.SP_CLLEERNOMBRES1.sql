USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLLEERNOMBRES1]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLLEERNOMBRES1](@clnombre1 CHAR(40))
AS
BEGIN

	SET ROWCOUNT 50

	SELECT	clrut     ,
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
                clciudad
        FROM	cliente, view_mdac
	WHERE 	clnombre >= @clnombre1 
--clrut <> acrutprop and              	
        ORDER BY
                 clnombre

	SET ROWCOUNT 0

END

-- Sp_ClLeerNombres1 'A KLEIN Y CIA LTDA'

GO
