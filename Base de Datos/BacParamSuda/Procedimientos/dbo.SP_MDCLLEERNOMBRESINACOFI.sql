USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERNOMBRESINACOFI]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDCLLEERNOMBRESINACOFI] (@clnombre1 CHAR(40))
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
