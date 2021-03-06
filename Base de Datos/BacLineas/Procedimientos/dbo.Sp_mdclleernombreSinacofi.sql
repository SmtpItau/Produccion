USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_mdclleernombreSinacofi]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_mdclleernombreSinacofi] (@clnombre1 CHAR(40))
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
                clciudad
        FROM
                 CLIENTE, VIEW_MDAC
    WHERE clrut <> acrutprop and
              clnombre >= @clnombre1 AND
              (cltipcli = 1 OR cltipcli = 2 OR cltipcli = 3)
        ORDER BY
                 clnombre
 seT ROWCOUNT 0
END






GO
